Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbVINBxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbVINBxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 21:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVINBxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 21:53:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:11990 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932577AbVINBxA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 21:53:00 -0400
Date: Wed, 14 Sep 2005 02:52:53 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Sripathi Kodi <sripathik@in.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, patrics@interia.pl,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
Message-ID: <20050914015253.GX25261@ZenIV.linux.org.uk>
References: <4325BEF3.2070901@in.ibm.com> <20050912134954.7bbd15b2.akpm@osdl.org> <4326CFE2.6000908@in.ibm.com> <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org> <20050913165102.GR25261@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org> <20050913171215.GS25261@ZenIV.linux.org.uk> <43274503.7090303@in.ibm.com> <Pine.LNX.4.58.0509131601400.26803@g5.osdl.org> <43278116.8020403@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43278116.8020403@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 08:47:02PM -0500, Sripathi Kodi wrote:
> Linus Torvalds wrote:
> 
> >I don't think this is wrong per se, but you shouldn't take the tasklist 
> >lock normally. You're better off just doing
> 
> Linus,
> 
> I incarporated the path that doesn't hold tasklist lock unnecessarily. The 
> patch is below. This seems to work without any problems for me.
> 
> If the decision is to remove ->permission, I can send a small patch I have 
> that removes .permission entry from proc_task_inode_operations. Either way 
> fixes the problem I found.

NAK.  Even if equivalent of that kludge might be tolerable for our purposes,
it does _not_ belong on any of the normal codepaths.
