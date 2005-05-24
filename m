Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVEXNpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVEXNpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVEXNpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:45:44 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:59018 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261156AbVEXNpc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:45:32 -0400
Date: Tue, 24 May 2005 09:45:18 -0400 (Eastern Daylight Time)
From: Reiner Sailer <sailer@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Emilyr@us.ibm.com, James Morris <jmorris@redhat.com>, Kylene@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       Toml@us.ibm.com, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and
 Readme
Message-ID: <Pine.WNT.4.63.0505240841220.3152@laptop>
X-Warning: UNAuthenticated Sender
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote on 05/23/2005 07:44:54 PM:
> 
> To make this usefull, you need to:
> 
> * have TPM chip

TPM chips are becoming broadly available in many new
desktop and laptop systems. Drivers are open-source, see tpmdd
and TrouSerS projects on sourceforge.

> * remove all the buffer overflows. I.e. if grub contains buffer
>    overflow in parsing menu.conf... that is not a security hole
>    (as of now) because only administrator can modify menu.conf.
>    With IMA enabled, it would make your certification useless...

Taking your example: Even if you run a buffer-overflow grub, IMA will 
enable remote parties to differentiate between systems that run
the vulnerable grub and systems that don't. IMA in this case actually
can put value to running better software.

Additionally, you can see whether the operating system implements 
'useful' measures against buffer overflows. Information you don't easily 
get otherwise when communicating with /logging into a  
remote system. So you can determine if buffer-overflow-vulnerable 
applications run in operating environments that actually allow attackers 
to exploit such vulnerabilities.

> [probably something more].
> 
> ...seems to me you need to do quite a lot of work to make this
> usefull...

Things can be useful even though they don't solve all security problems. 
Think of IPSEC,  SSL, firewalls, tripwire. I find them useful even though 
they are not  offering total security. The experiments are aimed at 
finding useful trade-offs for different usage pattern (e.g., remote 
access) that raise the bar for attackers.
 
> [And now, remote-buffer-overrun in inetd probably breaks your
> attestation, no? I'll just load my evil code over the network, without
> changing any on-disk executables, then install my evil rootkit into
> kernel by writing into /dev/kmem. How do you prevent that one?]
>                         Pavel

We have IMA kernel configuration options to detect direct writes onto 
/dev/kmem and some other devices. If /dev/kmem is directly opened for 
writing, the aggregate in the TPM is invalidated. This system will not be 
able to deliver a measurement list with a fitting TPM aggregate signature 
until next reboot and clearing of all state.

Thanks 
Reiner

