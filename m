Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161475AbWHJRZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161475AbWHJRZS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161481AbWHJRZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:25:18 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:44944 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161475AbWHJRZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:25:16 -0400
Date: Thu, 10 Aug 2006 19:24:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: John Stoffel <john@stoffel.org>, Jeff Garzik <jeff@garzik.org>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
In-Reply-To: <20060810095413.3797b4a2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0608101907190.6761@scrub.home>
References: <1155172843.3161.81.camel@localhost.localdomain>
 <20060809234019.c8a730e3.akpm@osdl.org> <Pine.LNX.4.64.0608101302270.6762@scrub.home>
 <44DB203A.6050901@garzik.org> <Pine.LNX.4.64.0608101409350.6762@scrub.home>
 <44DB25C1.1020807@garzik.org> <Pine.LNX.4.64.0608101429510.6762@scrub.home>
 <44DB27A3.1040606@garzik.org> <Pine.LNX.4.64.0608101459260.6761@scrub.home>
 <44DB3151.8050904@garzik.org> <Pine.LNX.4.64.0608101519560.6762@scrub.home>
 <17627.23974.848640.278643@stoffel.org> <20060810095413.3797b4a2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Aug 2006, Andrew Morton wrote:

> For ext3 on x86:
> 
> CONFIG_LBD=y:
> 
> box:/usr/src/25> size fs/jbd/jbd.o fs/ext3/ext3.o
>    text    data     bss     dec     hex filename
>   51076       8      32   51116    c7ac fs/jbd/jbd.o
>   87466    1020       4   88490   159aa fs/ext3/ext3.o
> 
> CONFIG_LBD=n:
> 
> box:/usr/src/25> size fs/jbd/jbd.o fs/ext3/ext3.o
>    text    data     bss     dec     hex filename
>   51133       8      32   51173    c7e5 fs/jbd/jbd.o
>   87679    1020       4   88703   15a7f fs/ext3/ext3.o
> 
> That's a grand total of 270 bytes of text saved.  aka 0.19%.
> 
> We'll save four bytes in the inode (unlikely to save anything due to slab
> packing).

sector_t is used in multiple structures (bio/request/buffer_head), which 
quickly adds up.
ext3 is also currently not a very heavy sector_t user, if you try this 
with block/ you get a more than 3% difference.

bye, Roman
