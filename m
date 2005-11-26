Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbVKZIRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbVKZIRh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 03:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbVKZIRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 03:17:37 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:6677 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422646AbVKZIRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 03:17:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=o83MzfuK/ZkcjcG5UNHA94dljmdLN6omXWKC8ETPwjR5MwchmOnc9awZNj2SMCwsoIsjtFQwRMf2W49wNE64pFokLk6a/6DwmS9Pa+m+x2wQv8pRN1Gl8GOiwFbdmG2lT+74KEHn3+nMilJFPvxREjm0vO3nGghZ2XrEabk7kAo=
Message-ID: <43881A1C.6040608@gmail.com>
Date: Sat, 26 Nov 2005 09:17:32 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       pavel@ucw.cz, shaohua.li@intel.com, akpm@osdl.org
Subject: Re: 2.6.15-rc2-git5 continues to fail suspending (USB issue)
References: <Pine.LNX.4.44L0.0511251519260.17257-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0511251519260.17257-100000@netrider.rowland.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern ha scritto:

>On Fri, 25 Nov 2005, Patrizio Bassi wrote:
>
>  
>
>>i tried today's git due to Greg's usb patches,
>>but they don't work.
>>
>>i wrote already twice the problem:
>>    
>>
>
>You wrote about it on lkml, not linux-usb-devel.  So it might not have 
>been noticed by the USB developers.
>
>  
>
o sorry you're right. i tought usb team followed the main ml too.

>>Stopping tasks: ==========================|
>>Freeing memory... done (13146 pages freed)
>>usbfs 2-2:1.0: no suspend?
>>Could not suspend device 2-2: error -16
>>Some devices failed to suspend
>>Restarting tasks... done
>>
>>If needed i'll reattach the patch i have (against 2.6.14-rc2 iirc)
>>
>>lsusb
>>Bus 004 Device 001: ID 0000:0000
>>Bus 003 Device 001: ID 0000:0000
>>Bus 002 Device 002: ID 0915:8000 GlobeSpan, Inc.
>>Bus 002 Device 001: ID 0000:0000
>>Bus 001 Device 001: ID 0000:0000
>>    
>>
>
>Looks like the vanilla kernel needs to add suspend/resume methods for
>usbfs bindings.  What is that GlobeSpan device?  Are you running a
>userspace program that controls it?  If you are, you can try quitting that 
>program before suspending.
>
>Also, if you haven't tried it, you might want to apply this patch:
>
>http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-all-2.6.15-rc2-git3.patch
>
>or whatever is the most current version when you download it.
>
>Alan Stern
>
>
>  
>

globespan device is a zyxel prestige 630 adsl modem using eciadsl
userspace drivers.
after killing the driver it suspended and resumed.

but i got a problem, trying to restart driver.

[EciAdsl 3/5] Synchronization...

 ERROR reading interrupts
*** glibc detected *** double free or corruption (fasttop): 0x0804f158 ***
/usr/bin/eciadsl-start: line 517: 11399 Abortito               
"$BIN_DIR/eciadsl-synch" $synch_options
ERROR: failed to get synchronization

usb 2-2: usbfs: USBDEVFS_CONTROL failed cmd eciadsl-synch rqt 192 rq 222
len 13 ret -110

tried 3 times, always the same.
so i manually unplugged modem and replugged.
works perfectly (as usual).

seems a problem on suspending and resuming attached device.


i've access to eciadsl cvs so i can patch it.
the first problem (no suspend) i think can be fixed binding some signals
in userspace, which?

the second seems an init problem, that i leave to you :)

Patrizio
