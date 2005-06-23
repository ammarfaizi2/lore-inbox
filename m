Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVFWP1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVFWP1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 11:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbVFWP1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 11:27:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27108 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262563AbVFWP1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 11:27:10 -0400
Date: Thu, 23 Jun 2005 08:29:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
In-Reply-To: <42BA5F6F.9090406@pobox.com>
Message-ID: <Pine.LNX.4.58.0506230822370.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
 <42B9FF3A.4010700@pobox.com> <Pine.LNX.4.58.0506221850030.11175@ppc970.osdl.org>
 <42BA5F6F.9090406@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Jun 2005, Jeff Garzik wrote:
>
> Linus Torvalds wrote:
> > (Of course, since the rsync protocol doesn't know anything about git
> > consistency, if the mirroring is half-way, you'll end up with something
> > less than wonderful, and confusing. Details, details)
> 
> Would it make sense to add an fsck step to git-clone-script?

Well, it's going to be slow. Of course, it's not as slow as pulling the 
stuff over a DSL line or whatever, but still..

I think I need to make something that just verifies the top <n> commits or
whatever - I need that for "pull" anyway, so that you can do a 

	git fsck ORIG_HEAD..

and it will fsck only the new stuff that arrived as a result of the pull.

And we need to improve the git-ssh-pull/git-http-pull scripts so that they
do pipelined requests: right now it's usually a lot faster to do "rsync"  
than it is to do git-ssh-pull (unless you do a small pull), because even
though the rsync ends up needing to compare the full directory contents,
it then transfers the data much faster.

		Linus
