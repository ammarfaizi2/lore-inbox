Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbVI0MxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbVI0MxD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbVI0MxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:53:03 -0400
Received: from web51014.mail.yahoo.com ([206.190.39.79]:32133 "HELO
	web51014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964916AbVI0MxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:53:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=P/R2232hl93hQyBfKNxnbHsFydhtvZyBjt3gR6bhMbjl/oiBVggMeaZhzmbbyyk8BNcfGzmuPR/kPhHYjUtVW9dZoKbwdr6yR6Zzzu0CrWz5a+0XBDGQk2hta/5zLh16wlbOkw5tHNbiyV5TYb4bk9wKpe800cChOnh7CojyR8g=  ;
Message-ID: <20050927125300.24574.qmail@web51014.mail.yahoo.com>
Date: Tue, 27 Sep 2005 05:53:00 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: [ANNOUNCE] Framework for automatic Configuration of a Kernel
To: Emmanuel Fleury <fleury@cs.aau.dk>, linux-kernel@vger.kernel.org
In-Reply-To: <4339344C.9050305@cs.aau.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emmanuel

--- Emmanuel Fleury <fleury@cs.aau.dk> wrote:

> Hi,
> 
> First of all, I guess that the point of a script
> here is to decide
> whether or not the hardware device is here or not.
> So, the output should
> be something like "true" or "false", better than
> echoing some stupid
> characters, maybe a direct "exit 0" and "exit 1"
> would be much less
> troublesome.

Good idea! 

> 
> Then, I might be wrong but I think we can get a more
> stable detection of
> the PCI devices by grabbing directly the PCI vendor
> and device codes as
> numbers instead of looking them up in the PCI ID
> database.
> 
> lspci -n
> 
> Or even, ask for a specific device like this:
> lspci -d [<vendor>]:[<device>]
> 
> Which would give something like this:
> 
> [fleury@rade7 ~]$ lspci -d 8086:1a30
> 0000:00:01.0 PCI bridge: Intel Corporation 82845 845
> (Brookdale) Chipset
> AGP Bridge (rev 04)
> 
> Or if the device is not present:
> [fleury@rade7 ~]$ lspci -d 8087:1a30
> <no output>
> 
> This way just avoid to depend from the way the PCI
> database is written,
> because whenever there is a change in the spelling
> of one keyword, it
> might need quite a lot of updates in the Kconfigs.
> On the contrary, the
> vendor and device PCI code will never change
> (hopefully).
> So, the 'autorule' would look like this:
> 
> autorule pciscript.sh "8086:1a30"
> 
> And the script would be:
> #/bin/sh
> 
> if [ -z "`lspci -d $1`" ]
> then
>     exit 1
> else
>     exit 0
> fi
> 
> What do you think ?

Again another good Idea. Your right;-) Its better. 
But it better getting another way of detecting the
Hardware/Software etc. from the System without using
lspci or the proc-files...? Something that gets all
the Hardware Information directly from the I/O and not
from the Kernel. The good thing about lspci is that it
does both . But it doesnt say if there is  a CDROM or
floppy-disc... I tryed alot to search for something
like that but without any success. I heard about this
Otopia Project. I google after it but I didnt find
anything usefule. I think its dead. 

Regards

Ahmad Reza Cheraghi


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
