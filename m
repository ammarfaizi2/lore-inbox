Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVCYTij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVCYTij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 14:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVCYTij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 14:38:39 -0500
Received: from smtpout.mac.com ([17.250.248.46]:53742 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261762AbVCYTih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 14:38:37 -0500
In-Reply-To: <20050325183534.GB4192@linux-sh.org>
References: <1110414879646@kroah.com> <11104148792069@kroah.com> <20050325180136.GA4192@linux-sh.org> <20050325181014.GA13436@kroah.com> <20050325183534.GB4192@linux-sh.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5c0804da3486a6e735a46220d73c9637@mac.com>
Content-Transfer-Encoding: 7bit
Cc: rmk+lkml@arm.linux.org.uk, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] driver core: Separate platform device name from platform device number
Date: Fri, 25 Mar 2005 14:38:22 -0500
To: Paul Mundt <lethal@linux-sh.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 25, 2005, at 13:35, Paul Mundt wrote:
> Anything that expects that it can open a 
> /sys/devices/platform/<device><id>
> path. I have a few applications like this, I have no reason to doubt 
> that
> others do too. I don't see any reason to go out of the way to break 
> this
> convention if the end of the device name is not a number.

So how would you tell the difference between the following?
	device = "foobar0"
	id = -1
	path = "/sys/devices/platform/foobar0"
versus
	device = "foobar"
	id = 0
	path = "/sys/devices/platform/foobar0"

I'll agree that having two drivers named like this is bad, but how is a
userspace application given a path like "/sys/devices/platform/foobar0"
supposed to figure out which one it is.  It's not as nice to add the
extra period, but otherwise you end up with a lot of _extra_ special
cases in both the kernel _and_ applications, which helps nobody.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


