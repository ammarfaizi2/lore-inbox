Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbTDTVqV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 17:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263720AbTDTVqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 17:46:21 -0400
Received: from hera.cwi.nl ([192.16.191.8]:37853 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263718AbTDTVqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 17:46:18 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 20 Apr 2003 23:58:18 +0200 (MEST)
Message-Id: <UTC200304202158.h3KLwIu10935.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [CFT] more kdev_t-ectomy
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> MKDEV(<constant>,<constant>) is a valid thing, as far as I'm concerned.

Yes. I was tempted to change the first argument of blk_register_region
into a pair, killing some MKDEV occurrences, but then I noticed that
almost all are of the form MKDEV(<constant>,<constant>), and that
is not so bad.

Still, the fact that every single call of blk_register_region
has a first argument MKDEV(ma,mi) suggests that one might
consider leaving these parameters separate.

Andries


[Now that we are talking anyway, let me ask about something.
You wrote blk_register_region so that subregions override
superregions. At the bottom there is the full region.
Was this just a general good idea, or do you have definite
applications in mind? I ask this mostly because the hash
lookup becomes more complicated in the general case.
You may have noticed that I wrote

static inline int major_to_index(int major)
{
        return major % MAX_PROBE_HASH;
}
static inline int dev_to_index(dev_t dev)
{
        return major_to_index(MAJOR(dev));
}

and that is OK for regions with constant major.
For multimajor regions a hash does not work very well, and
a tree looks better.]
