Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbWCAHze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWCAHze (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 02:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWCAHze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 02:55:34 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:59011 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932619AbWCAHzd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 02:55:33 -0500
Date: Tue, 28 Feb 2006 23:59:15 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Hauke Laging <mailinglisten@hauke-laging.de>, linux-kernel@vger.kernel.org
Subject: Re: VFS: Dynamic umask for the access rights of linked objects
Message-ID: <20060301075915.GD27645@sorel.sous-sol.org>
References: <200603010328.42008.mailinglisten@hauke-laging.de> <44050AB7.7020202@vilain.net> <200603010454.15223.mailinglisten@hauke-laging.de> <08AB14CC-2BB2-4923-BFDB-B1360B5EF405@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08AB14CC-2BB2-4923-BFDB-B1360B5EF405@mac.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kyle Moffett (mrmacman_g4@mac.com) wrote:
> On Feb 28, 2006, at 22:54:15, Hauke Laging wrote:
> >6) In my scenario the VFS would add a step after 4): It would check  
> >if the symlink has been created by someone different from the  
> >process's uid and from root. If so there is the risk of abuse and  
> >the access check would be repeated for the symlink owner.
> >
> >7) The VFS would find out that the symlink owner is not allowed to  
> >write to /etc/passwd. Thus the write access is prohibited, even for  
> >a process with superuser rights.
> 
> Feel free to write an LSM to do this, but it breaks POSIX specs a bit  
> and could cause problems with some programs, so it's not likely to  
> become the default behavior.

Solar Designer's Openwall Linux patch contains code for these types of
restrictions (at least since 2.2 if not earlier).  Idea was stolen and
made into an LSM smth like 4 or 5 years ago.  Neither of these have made
it upstream.  Attempts have also been made to codify such restrictions
in SELinux policy.  Polyinstantiation and per-process namespaces can be
done effectively with code that's now in mainline, and can mitigate much
of this risk.

thanks,
-chris
