Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269256AbTGJMlG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 08:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269258AbTGJMlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 08:41:06 -0400
Received: from ns.suse.de ([213.95.15.193]:13584 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269256AbTGJMlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 08:41:03 -0400
Date: Thu, 10 Jul 2003 14:55:43 +0200
From: Andi Kleen <ak@suse.de>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] minor optimization for EXT3
Message-ID: <20030710125543.GB26892@wotan.suse.de>
References: <87smpeigio.fsf@gw.home.net.suse.lists.linux.kernel> <20030710042016.1b12113b.akpm@osdl.org.suse.lists.linux.kernel> <87y8z6gyt3.fsf@gw.home.net.suse.lists.linux.kernel> <p73of02pn6s.fsf@oldwotan.suse.de> <87vfuagwa5.fsf@gw.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vfuagwa5.fsf@gw.home.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 04:51:30PM +0000, Alex Tomas wrote:
>  AK> Also dtimes in free inodes  can be now lost, can't they? Did you check 
>  AK> if that causes problems in fsck?  [my understanding was that ext2/3 fsck relies on the 
>  AK> dtime to make some heuristics when recovering files work better]
> 
> freed inodes will be lost. I've checked filesystem by fsck after lots of creations/removals.
> it seems OK.

iirc the dtime is used so that fsck can relink all non deleted inodes to lost+found
when a directory is corrupted. Without dtime there is no way to distingush
deleted and non deleted files, and just relinking everything would be quite
nasty.

With your patch this heuristic would lose some files.

That's more important for ext2 than ext3 of course, but even on ext3 
you could get a corrupted directory when you're unlucky (e.g. io error or similar)

-Andi
