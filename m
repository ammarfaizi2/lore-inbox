Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbTF1BUW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 21:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbTF1BUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 21:20:22 -0400
Received: from aneto.able.es ([212.97.163.22]:23733 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S265001AbTF1BUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 21:20:21 -0400
Date: Sat, 28 Jun 2003 03:34:35 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21rc8aa1
Message-ID: <20030628013435.GG9706@werewolf.able.es>
References: <20030612032021.GB1571@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030612032021.GB1571@dualathlon.random>; from andrea@suse.de on Thu, Jun 12, 2003 at 05:20:21 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 06.12, Andrea Arcangeli wrote:
> This version has some experimental change to the blkdev layer (latency
> fixes from Chris and Nick too plus the backout of the rc6 latency change
> to see if we can fix it w/o generating overscheduling, especially
> because it doesn't sound the right fix), so I would recommend some
> beating before doing anything critical with it. I would expect it as
> worse to deadlock with some task in D state. It worked fine for me so
> far but I didn't run big stress yet. In theory it should be better, but
> I just wanted to give a warning until it is better tested ;).
> 
> URL:
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1.gz
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1/
> 

In sg.c, gcc shouts on:

    PRINT_PROC("%u\t%hu\t%hd\t%hu\t%d\t%d\n",
           shp->unique_id, shp->host_busy, shp->cmd_per_lun,
           shp->sg_tablesize, (int)shp->unchecked_isa_dma,
           (int)shp->hostt->emulated);

shp->host_busy should be accessed through atomic_read(), I think.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
