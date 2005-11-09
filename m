Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbVKIQdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVKIQdr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVKIQdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:33:46 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:34066 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751044AbVKIQdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:33:46 -0500
To: viro@ftp.linux.org.uk
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linuxram@us.ibm.com
In-reply-to: <20051109155634.GY7992@ftp.linux.org.uk> (message from Al Viro on
	Wed, 9 Nov 2005 15:56:34 +0000)
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <E1EZnbA-000190-00@dorka.pomaz.szeredi.hu> <20051109143107.GV7992@ftp.linux.org.uk> <E1EZrmJ-0001dI-00@dorka.pomaz.szeredi.hu> <20051109155634.GY7992@ftp.linux.org.uk>
Message-Id: <E1EZssv-0001lI-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 09 Nov 2005 17:33:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Before it gets freed it may end up being copied.  Example: vfsmounts
> A and B are peers, C is a slave of that peer group.  It happens to be
> on slave list of B.  B has root deeper than A, which, in turn is deeper
> than that of C (e.g. A and B had been created by binding subtrees of
> C, which had been made slave afterwards).  We bind on something in A,
> outside of the subtree mapped by B.
> 
> Alternatively, have A -> (B, D) -> C, with C on slave list of B.  Mountpoint
> is within subtrees for A, C and D, but not B.  And no, we can't say "skip B,
> just make a slave of tree on A and slap it on C" - correct result is to
> have T_A -> T_D -> T_C (i.e. tree on C gets propagation from tree on D).
> Which kills the variants with not creating that copy and making subsequent
> ones directly from the original tree.

OK, I see it now.  What confused me is that from patch 12 it's not yet
obvious, that the copied mount will be used for futher propagation.

Miklos
