Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWAOXWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWAOXWM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 18:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWAOXWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 18:22:12 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:37841 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750945AbWAOXWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 18:22:12 -0500
Date: Mon, 16 Jan 2006 00:22:51 +0100
From: Mattia Dongili <malattia@linux.it>
To: Nathan Scott <nathans@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, linux-xfs@oss.sgi.com
Subject: Re: 2.6.15-mm3 bisection: git-xfs.patch makes reiserfs oops
Message-ID: <20060115232250.GD3521@inferi.kami.home>
Mail-Followup-To: Nathan Scott <nathans@sgi.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	reiserfs-dev@namesys.com, linux-xfs@oss.sgi.com
References: <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060115221458.GA3521@inferi.kami.home> <20060116094817.A8425113@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116094817.A8425113@wobbly.melbourne.sgi.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.15-rc5-mm3-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 09:48:17AM +1100, Nathan Scott wrote:
> On Sun, Jan 15, 2006 at 11:14:58PM +0100, Mattia Dongili wrote:
[...]
> > you're right: git-xfs.patch is the bad guy.
> > 
> > Unfortunately netconsole isn't helpful in capturing the oops (no serial
> > ports here) but I have two more shots (more readable):
> > http://oioio.altervista.org/linux/dsc03148.jpg
> > http://oioio.altervista.org/linux/dsc03149.jpg
> 
> Hmm, thats odd.  It seems to be coming from:
> reiserfs_commit_page -> reiserfs_add_ordered_list -> __add_jh(inline)
> 
> I guess XFS may have left a buffer_head in an unusual state (with some
> private flag/b_private set), somehow, and perhaps that buffer_head has
> later been allocated for a page in a reiserfs write.  Does this patch,
> below, help at all?

I won't be able to test and report until tomorrow afternoon (CET),
please be patient.

> I see one BUG check in __add_jh for non-NULL b_private, but can't see
> the top of your console output from the photos - is there a preceding
> line with "kernel BUG at ..." in it?

this is another shot of the same oops caught some days ago
http://oioio.altervista.org/linux/dsc03133.jpg
unfortunately it happened while running X so that's all I currently
have... and I can't remember now about the BUG.

oh, and BTW I have / and /usr on reiserfs while /home is xfs and I can
easily reproduce the oops by starting X (with a simple user so fiddling
in /home) and then installing and removing software in /usr.

thanks.
-- 
mattia
:wq!
