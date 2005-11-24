Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVKXSoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVKXSoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 13:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbVKXSod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 13:44:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750733AbVKXSoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 13:44:32 -0500
Date: Thu, 24 Nov 2005 10:44:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Ericsson <ae@op5.se>
cc: Ed Tomlinson <tomlins@cam.org>, Junio C Hamano <junkio@cox.net>,
       git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc2
In-Reply-To: <4385BAFC.7070906@op5.se>
Message-ID: <Pine.LNX.4.64.0511241037400.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511240737.59153.tomlins@cam.org> <4385BAFC.7070906@op5.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Nov 2005, Andreas Ericsson wrote:
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 2.6
> 
> which works flawlessly for me although it takes quite some time to transfer
> all the data.

The initial clone is very expensive for the native git protocol: the 
protocol is designed to scale well for incremental updates (ie you have a 
_huge_ repository that has changed just a bit, and the protocol should 
work well for that), and that makes the initial clone quite expensive as 
it marshalls the whole damn repository into this nice packed format.

So it's often nicer (certainly on the remote server) to use "rsync" for 
the initial clone, and then only after that start using the git protocol.

(This is in no way really fundamental, and the server could cache the 
packs it generates for initial clones, but that isn't implemented yet, and 
probably won't be for some times).

Of course, especially if you're mostly bandwidth-constrained and the 
server side is not under a big load, using the native git protocol may 
actually be faster anyway. Because it's always going to generate the 
nicest packing, while rsync:// will just use whatever packing that the 
server happens to have at that point (but I do repack every few weeks, so 
rsync for the initial clone should never be horribly bad - and since I 
just repacked, it should get that "perfect" pack too).

		Linus
