Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVABWnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVABWnc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 17:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVABWnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 17:43:32 -0500
Received: from imf21aec.mail.bellsouth.net ([205.152.59.69]:43727 "EHLO
	imf21aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261309AbVABWnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 17:43:24 -0500
Date: Sun, 2 Jan 2005 17:36:50 -0500
From: David Meybohm <dmeybohmlkml@bellsouth.net>
To: Andi Kleen <ak@muc.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disallow modular capabilities
Message-ID: <20050102223650.GA5818@localhost>
Mail-Followup-To: Andi Kleen <ak@muc.de>, Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org
References: <20050102200032.GA8623@lst.de> <m1mzvry3sf.fsf@muc.de> <20050102203005.GA9491@lst.de> <m1is6fy2vm.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1is6fy2vm.fsf@muc.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 09:47:41PM +0100, Andi Kleen wrote:
> Christoph Hellwig <hch@lst.de> writes:
> >
> > At least Debian currently inserts the capabilities module on boot.
> 
> That is fine as long as they control all code executed before
> that module loading.  And if they do not it is their own fault
> and they have to fix that in user space or compile the capability in.
> Unix policy is to not stop root from doing stupid things because
> that would also stop him from doing clever things.

But if the module system creates security holes in the security system,
shouldn't that be avoided?  Isn't this is a fundamental problem because
the new security module that is being loaded has no idea what state all
processes are in when the module gets loaded?

What do you think about only allowing init to load LSM modules i.e.
check in {mod,}register_security that current->pid == 1.  Then init can
load the policy from some file in /etc changeable by the administrator
before starting any other processes.  Then you don't have to recompile
the kernel to change policies, but you still need to reboot and can't
get into funky states.

Dave
