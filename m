Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269276AbTGJNn1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 09:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269278AbTGJNn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 09:43:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20953 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269276AbTGJNn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 09:43:26 -0400
Date: Thu, 10 Jul 2003 15:57:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Chris Mason <mason@suse.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030710135747.GT825@suse.de>
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08 2003, Marcelo Tosatti wrote:
> 
> Hello people,
> 
> To get better IO interactivity and to fix potential SMP IO hangs (due to
> missed wakeups) we, (Chris Mason integrated Andrea's work) added
> "io-stalls-10" patch in 2.4.22-pre3.
> 
> The "low-latency" patch (which is part of io-stalls-10) seemed to be a
> good approach to increase IO fairness. Some people (Alan, AFAIK) are a bit
> concerned about that, though.
> 
> Could you guys, Stephen, Andrew and maybe Viro (if interested :)) which
> havent been part of the discussions around the IO stalls issue take a look
> at the patch, please?
> 
> It seems safe and a good approach to me, but might not be. Or have small
> "glitches".

Well, I have one naive question. What prevents writes from eating the
entire request pool now? In the 2.2 and earlier days, we reserved the
last 3rd of the requests to writes. 2.4.1 and later used a split request
list to make that same guarentee.

I only did a quick read of the patch so maybe I'm missing the new
mechanism for this. Are we simply relying on fair (FIFO) request
allocation and oversized queue to do its job alone?

-- 
Jens Axboe

