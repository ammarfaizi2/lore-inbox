Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262948AbVEGKQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbVEGKQH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 06:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVEGKQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 06:16:07 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:54537 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262948AbVEGKQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 06:16:01 -0400
Date: Sat, 7 May 2005 12:06:51 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>,
       openafs-info@openafs.org, linux-kernel@vger.kernel.org
Subject: Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same for 2.4.30 and openafs 1.3.82
Message-ID: <20050507100651.GA18380@alpha.home.local>
References: <Pine.LNX.4.62.0505060209040.31479@tassadar.physics.auth.gr> <20050506052803.GE777@alpha.home.local> <20050506165033.GA2105@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506165033.GA2105@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 01:50:33PM -0300, Marcelo Tosatti wrote:
> > > Oopses on an openafs client system using openafs 1.3.78 and kernel 2.4.29.
> > > Oopses also occur afer moving to kernel 2.4.30 and openafs 1.3.82
> > 
> > The problem you encounter on 2.4.30 is not the same as on 2.4.29. The problem
> > in 2.4.29 is related to link_path_walk, which has been fixed in 2.4.30.
> 
> Willy,
> 
> The link_path_walk fix in v2.4.30 is related to a reference counting
> bug triggered by "umount"...

Hmmm... you're right Marcelo, sorry for the confusion. When I saw
'link_path_walk' in Dimitris' trace, it recalled me something, and I saw
the recent fix for an oops which I thought related, but apparently not.

> As Christoph noted OpenAFS seems to be doing nasty things...  it seems 
> to play with dentries inode i_state directly? If that is the case, 
> maybe it should define d_iput? 

I don't know, but clearly if it's doing dirty tricks, it's not surprizing
that even small changes from 2.4.29 to 2.4.30 can trigger or hide the bugs.
He should try to decorellate openafs and kernel versions. Trying 1.3.82 on
top of 2.4.29 (or even -hf) would probably show that he gets the same bugs
as on 2.4.30, thus leading to the conclusion that the difference lies in
the openafs upgrade.

Cheers,
Willy

