Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTERWzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 18:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTERWzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 18:55:09 -0400
Received: from codepoet.org ([166.70.99.138]:21654 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S262253AbTERWzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 18:55:08 -0400
Date: Sun, 18 May 2003 17:08:04 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, alan@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>, trivial@rustcorp.com.au
Subject: Re: [2.5 patch] 2.4.21-rc1 pointless IDE noise reduction
Message-ID: <20030518230804.GA26631@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andre Hedrick <andre@linux-ide.org>, Adrian Bunk <bunk@fs.tum.de>,
	alan@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
	trivial@rustcorp.com.au
References: <20030518130627.GC12766@fs.tum.de> <Pine.LNX.4.10.10305181510170.32050-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10305181510170.32050-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun May 18, 2003 at 03:13:48PM -0700, Andre Hedrick wrote:
> 
> Just maybe people would like to know if there is a secret OS on the tail
> of their drive, or the potential for one being there.
> 
> Go research EDDS BEER PARTIES and you will find out this is not a joke.

Real world to Andre: idedisk_supports_host_protected_area() does not
tell people any such thing.

> If the noise pisses you off turn down your kernel printk noise makers.
> Better yet stub it out in your own kernel.
> 
> Do not remove items that have meaning or valid tests.

I wouldn't dream of removing things which have meaning.  Which is
why removing this is the Right Thing(tm).  It is useless noise. 

The test, as implemented, merely tells us whether a drive is
capable of supporting the Host Protected Area feature set.  Well,
who cares about that?  The only time anyone cares, is when
something, such as the BIOS, has done a SET MAX ADDRESS [EXT], in
which case CONFIG_IDEDISK_STROKE already addresses the problem
(unless the drive was transitioned to Set_Max_Frozen state SM3,
in which case there is nothing to be done) and whines
appropriately to let people know.  This is a good thing.  No
complaints there.

But the Host Protected Area feature is not equal to DCO.  If you
want to detect and display when an drive has been modified via
DCO to appear smaller thereby concealing stuff, then by all means
go far it.  You won't hear me compain one bit.

> Erik, get over it and just live with a stub out.

As usual, I have no idea what you are talking about.  

Submit a patch to make idedisk_supports_host_protected_area() do
something useful, then fine we can keep it.  As is, it is
completely useless, it prints confusing messages, and it erroneously
suggests that there is already something hidden on people's drives.

As such, this stuff is useless cruft.  I suggested removing this
stuff and submitted an initial patch to silence it.  Adrian then
noticed that in addition to being noisy, the driver never uses
the info, and it could be dropped entirely.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
