Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130190AbQLHRee>; Fri, 8 Dec 2000 12:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132377AbQLHReY>; Fri, 8 Dec 2000 12:34:24 -0500
Received: from lowell.missioncriticallinux.com ([208.51.139.16]:62248 "EHLO
	dai.lowell.mclinux.com") by vger.kernel.org with ESMTP
	id <S130190AbQLHReE>; Fri, 8 Dec 2000 12:34:04 -0500
Message-ID: <3A3116B4.A80A7882@mclinux.com>
Date: Fri, 08 Dec 2000 12:13:24 -0500
From: Peng Dai <dai@mclinux.com>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: System.map with symbols from discarded sections
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quite a few functions in the 2.3 kernels and up are marked as __exit.
This puts the functions in the .text.exit section that is marked as
DISCARD
in vmlinux.lds.

It turns out that if the function is static, ld never puts it into the
symbol
table of vmlinux; however, if the function is global, ld throws it into
the
*ABS* section of vmlinux with an address most likely lower than
PAGE_OFFSET.
These symbols are included in System.map since they are not 'a' type but
'A'
type. An example of which is 'acpi_exit', as shown below,

00000000 A acpi_exit
c0100000 A _text
c0100000 t startup_32
c0100000 T _stext
...

It seems rather harmless except it breaks the readprofile utitlity which
reads
the System.map. I am wondering if ld is behaving correctly.

Regards,
Peng

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
