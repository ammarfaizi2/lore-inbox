Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVEWI7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVEWI7P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 04:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVEWI7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 04:59:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35739 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261865AbVEWI7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 04:59:09 -0400
Date: Mon, 23 May 2005 10:58:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Reiner Sailer <sailer@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@mail.wirex.com,
       Kylene@us.ibm.com, Emilyr@us.ibm.com, Toml@us.ibm.com
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and Readme
Message-ID: <20050523085852.GA1942@elf.ucw.cz>
References: <Pine.WNT.4.63.0505221821520.4896@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.63.0505221821520.4896@laptop>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +Limitations: IMA does not detect corruption of software once it is
> > > +loaded into main memory. Instead, it indicates known vulnerabilities
> > > +in such software (e.g., buffer overflow) by securely identifying the
> > > +software at load-time. Only executable files (binaries, libraries,
> > > +kernel modules) are measured by default. However, IMA offers a
> > > +sysfs-interface that allows applications to instruct the kernel to
> > > +measure files that they have opened.
> > 
> > What is it good for, then? So I have to put my backdoor into script,
> > not into an executable...
> 
> Scripts can be measured as well (from the user space).
>  
> For example, equipping the bash shell with 5-10 lines of code, bash 
> initiates IMA measurements on scripts and files that are sourced into bash before 
> they are "executed" by bash. This way, startup scripts and executed scripts can 
> be logged as measurements and the measuremnt list will include
> them. 

Well, for this to be usefull, you'd have to split files into two
categories:

1) files that do not change

2) files that can not compromise your security.

I guess that /etc/shadow *has to change*, and it still can compromise
your system security.

Same with basch scripts; you can make bash checksum its script, but
when user modifies his first script, you'll detect system as
"compromised".

I guess it can work... but I don't see how it can work in Linux.

								Pavel
