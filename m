Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266267AbUARIDh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 03:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266270AbUARIDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 03:03:37 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:62348
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S266267AbUARIDU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 03:03:20 -0500
Subject: Re: [RFC] kill sleep_on
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <400A396B.4090207@colorfullife.com>
References: <40098251.2040009@colorfullife.com>
	 <1074367701.9965.2.camel@imladris.demon.co.uk>
	 <20040117201000.GL21151@parcelfarce.linux.theplanet.co.uk>
	 <1074383111.9965.4.camel@imladris.demon.co.uk>
	 <20040117224139.5585fb9c.akpm@osdl.org>
	 <1074409074.1569.12.camel@nidelv.trondhjem.org>
	 <20040117233618.094c9d22.akpm@osdl.org> <400A396B.4090207@colorfullife.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074412980.1574.40.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 18 Jan 2004 03:03:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 18/01/2004 klokka 02:44, skreiv Manfred Spraul:
> Andrew Morton wrote:
> 
> >That's quite a lot of contention on the lock_kernel() in remote_llseek().
> >  
> >
> What about switching to generic_file_llseek, at least for files? The 
> only references to f_pos are in filldir/readdir.

I'm not sure that taking inode->i_sem would be much of an improvement.
Both th BKL and the inode semaphore seem superfluous to me in this
situation.
After all, the file size is now protected by neither of the above, but
rather by its own seqlock...

Cheers,
  Trond
