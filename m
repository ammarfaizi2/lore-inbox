Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVBZXlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVBZXlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 18:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVBZXlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 18:41:07 -0500
Received: from hera.cwi.nl ([192.16.191.8]:64725 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261295AbVBZXlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 18:41:03 -0500
Date: Sun, 27 Feb 2005 00:40:53 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
Message-ID: <20050226234053.GA14236@apps.cwi.nl>
References: <20050226213459.GA21137@apps.cwi.nl> <16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de> <Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org> <20050226225203.GA25217@apps.cwi.nl> <Pine.LNX.4.58.0502261510030.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502261510030.25732@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 03:12:28PM -0800, Linus Torvalds wrote:

> > The default fdisk will assign type 83 to a newly created partition.
> 
> Ok. Is that a "it has done so for the last 5 years" thing? 

The last twelve years.

> > (About type 0: DOS has used type 0 as definition of unused. It is not
> > bad if Linux uses DOS-conventions for a DOS-type partition table.)
> 
> Agreed. At the same time, I could well imagine that some people might use 
> such a type exactly to make DOS ignore it (but I assume the same is true 
> of the regular 0x83 type too, so maybe I'm just being difficult).
> 
> There's certainly a good argument for fixing a known problem (Uwe) and a 
> small enough risk of it breaking anything else.

Yes.

Andries


(Concerning the "size" version: it occurred to me that there is one
very minor objection: For extended partitions so far the size did
not normally play a role. Only the starting sector was significant.
If, at some moment we decide also to check the size, then a weaker
check, namely only checking for non-extended partitions, might be
better at first.)

(Yes, disk capacity is not always known - see e.g. ll_rw_blk.c:
 /* Test device or partition size, when known. */
See also sd.c, with the strange
                sdkp->capacity = 0x200000; /* 1 GB - random */
In such cases we just access the blocks user space tells us to access.)
