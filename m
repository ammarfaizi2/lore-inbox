Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbUKXGRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUKXGRd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 01:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUKXGRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 01:17:33 -0500
Received: from smtp.istop.com ([66.11.167.126]:15849 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261877AbUKXGRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 01:17:30 -0500
From: Daniel Phillips <phillips@istop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Date: Wed, 24 Nov 2004 01:20:40 -0500
User-Agent: KMail/1.7
Cc: Linus Torvalds <torvalds@osdl.org>, alan@lxorguk.ukuu.org.uk,
       miklos@szeredi.hu, hbryan@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <Pine.LNX.4.58.0411181047590.2222@ppc970.osdl.org> <20041118125734.32ec8e88.akpm@osdl.org>
In-Reply-To: <20041118125734.32ec8e88.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411240120.40820.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thursday 18 November 2004 15:57, Andrew Morton wrote:
> I've seen one 2.4-based project which had essentially a userspace
> blockdevice driver.  Marking that special, trusted process PF_MEMALLOC did
> indeed fix low-on-memory deadlocks.  Obviously it's something one does with
> caution, but there are times when it makes sense.

Like the cluster stack, unless we're happy with inhaling all the membership, 
failover, fencing and etc code into the kernel.

> I think there are codepaths which unconditionally turn off PF_MEMALLOC, so
> they need to be tweaked to do a save/set/restore operation for it all to
> work.

The only one I spotted is in dm-ioctl.c.  We get away with the one in 
page_alloc.c by branching around it in PF_MEMALLOC mode.

Regards,

Daniel
