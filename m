Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWCWBQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWCWBQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 20:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWCWBQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 20:16:08 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:41690 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932222AbWCWBQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 20:16:06 -0500
Message-ID: <4421F6AB.5030207@cfl.rr.com>
Date: Wed, 22 Mar 2006 20:15:23 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
References: <1142890822.5007.18.camel@localhost.localdomain> <20060320134533.febb0155.rdunlap@xenotime.net> <dvn835$lvo$1@terminus.zytor.com> <Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr> <44203B86.5000003@zytor.com> <Pine.LNX.4.61.0603211854150.21376@yvahk01. <Pine.LNX.4.61.0603221705510.1531@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0603221705510.1531@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> Under win/2000 "aux" can't be created either by using C/C++ or
> any of the usual utilities like `ftp`. The returned error-code
> is "Permission denied", even from an administrator account.
> 

For the third time this thread, yes, you can, you just have to escape 
the path name to prevent the win32 api from translating the name to the 
non existent AUX device.  From a command line you can do:

echo foo > \\?\c:\aux

And it will work just fine.  The only place the name "AUX" has any 
meaning is in the win32 api layers that translate certain device names 
to the real kernel path.  The kernel and filesystem will store whatever 
name you choose for compatibility with the posix subsystem.

> I have a dual-boot lap-top so I tried to create a file called
> "AUX" using `echo "">AUX`, under Linux-2.4.26. The error-code
> was "Invalid argument". This is a "vfat" file-system. I was
> able to create the device-name "CLOCK$", which is reserved in
> DOS. I'm now rebooting the laptop, it should be interesting
> to see if it still works! .... Yep. It's not a reserved name
> in Win/2000.
> 

