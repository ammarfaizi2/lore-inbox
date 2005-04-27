Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVD0R4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVD0R4r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVD0RzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:55:18 -0400
Received: from albireo.ucw.cz ([84.242.65.67]:15746 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261867AbVD0RyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:54:23 -0400
Date: Wed, 27 Apr 2005 19:54:25 +0200
From: Martin Mares <mj@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lmb@suse.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050427175425.GA4241@ucw.cz>
References: <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427143126.GB1957@mail.shareable.org> <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu> <20050427153320.GA19065@atrey.karlin.mff.cuni.cz> <20050427155022.GR4431@marowsky-bree.de> <20050427164652.GA3129@ucw.cz> <E1DQqUi-0002Pt-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQqUi-0002Pt-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklos!

> Is it possible to limit all these from kernelspace?  Probably yes,
> although a timeout for operations is something that cuts either way.
> And the compexity of these checks would probably be orders of
> magnitude higher then the check we are currently discussing.

Yes ... but does the check we are discussing really solve the problem?

Let's say that you attempt to export home directories of users by a user-space
NFS daemon. This daemon probably changes its fsuid to match the remote user,
so the check happily accepts the access and the user is able to lock up the
daemon.

It doesn't seem that there is any simple and universal cure -- root programs
or setuid programs altering their fsuid are just too similar to the real user
programs to separate them cleanly.

I see a lot of similarities with symlinks -- many programs also need to take
extra care of symlinks to be safe. However, symlinks are already senior
citizens of Unix systems and programs know how to cope with them since ages.

Maybe this could be taken advantage of by keeping all user mounts in a separate
directory like /mnt/usr (and /mnt is very likely to be avoided by all programs
traversing directory structure automatically) and symlinking from the requested
mount points there (with symlinks naturally not followed by automatic traversals).

I agree it isn't a neat solution, but it seems to be the first one which is
close to working.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Lisp Users: Due to the holiday, there will be no garbage collection on Monday.
