Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135599AbREBQMw>; Wed, 2 May 2001 12:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135612AbREBQMl>; Wed, 2 May 2001 12:12:41 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:4327 "EHLO
	c0mailgw09.prontomail.com") by vger.kernel.org with ESMTP
	id <S135599AbREBQMc>; Wed, 2 May 2001 12:12:32 -0400
Message-ID: <3AF031DC.B8D793FE@mvista.com>
Date: Wed, 02 May 2001 09:12:12 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: xconfig is broken (example ppc 8xx)
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To show the problem do:

make xconfig ARCH=ppc

in the "Platform support" menu "Processor Type" select "8xx" then close
the subminue with "MainMenu"

now select "Save and Exit"

This produces the following error messages:

ERROR - Attempting to write value for unconfigured variable
(CONFIG_SCC_ENET).
ERROR - Attempting to write value for unconfigured variable
(CONFIG_FEC_ENET).

The named CONFIG options are not set, nor are a few others related to
CONFIG_SCC_ENET.
(This means the on board NIC is not configured and since this is usually
a disc less system, boot fails when trying to mount "/" over nfs.)

make menueconfig ARCH=ppc  works correctly.

The problem appears to be related to these lines in
../ARCH/ppc/config.in


if [ "$CONFIG_CPU_PPC_8xx" = "y" ]; then
source arch/ppc/8xx_io/Config.in
fi

if [ "$CONFIG_CPU_PPC_8260" = "y" ]; then
source arch/ppc/8260_io/Config.in
fi

Only one of the two files is included, however, both configure the two
options mentioned in the error messages.

I think the problem is that the "wish" script builder does not allow a
CONFIG option to be configured in two different places, even if only one
of scripts should be included.

Additional info: Kernel revs tested 2.4.2, 2.4.3
If you swap the two "if" phrases above, the 8xx config works but the
8260 fails in the same way.  I.e. the last one wins.
