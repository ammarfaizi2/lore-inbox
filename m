Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261697AbSJFQTJ>; Sun, 6 Oct 2002 12:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261685AbSJFQR5>; Sun, 6 Oct 2002 12:17:57 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:27377 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261697AbSJFQRF>; Sun, 6 Oct 2002 12:17:05 -0400
Subject: Re: [PATCH 2.2] i386/dmi_scan updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021006101026.92C2A62DC0@mallaury.noc.nerim.net>
References: <20021006101026.92C2A62DC0@mallaury.noc.nerim.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 17:31:57 +0100
Message-Id: <1033921917.21257.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 13:12, Jean Delvare wrote
> 
> I don't agree with ASCII filtering. I don't want to enlarge everyone's kernel for just some rare cases where the DMI table is broken *and* debug code is enabled. If you want, I can write the code that does it, but I wouldn't enable it by default.
> As far as the length is concerned, the table length doesn't help, because we check the structure length against the remaining table length. The structure length does *not* include the string data, so we could pass the length test and still run of the table in dmi_string. What's more, the string index could be more that the string count for this structure and no check is done for this.
> I think we need a safer dmi_string function that knows about the table length (or, better indeed, the remaining length from this point), and checks for both string index being too large and string index leading outside the table. Then, the other checks (white space and null byte) will be obsolete.

Oh as a PS btw don't worry about code size for the dmi scanner as it is
all marked __init. The entire DMI code gets turned back into free memory
by the end of the boot of the kernel, so you can put complex checks in
there if it helps

