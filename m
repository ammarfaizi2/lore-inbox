Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTHYTnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 15:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbTHYTnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 15:43:10 -0400
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:20127 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id S262177AbTHYTnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 15:43:06 -0400
Date: Mon, 25 Aug 2003 15:43:04 -0400
From: Arvind Sankar <arvinds@MIT.EDU>
To: linux-kernel@vger.kernel.org
Subject: vesafb mtrr setup question
Message-ID: <20030825194304.GA14893@m66-080-17.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following lines are pulled out of drivers/video/vesafb.c (2.4.20):
Line 646 onwards..

> if (mtrr) {
>         int temp_size = video_size;
>         /* Find the largest power-of-two */
>         while (temp_size & (temp_size - 1))
>                 temp_size &= (temp_size - 1);
>                 
In the first place, the power of two computation computes the largest
power of 2 that is _smaller_ than video_size, so it looks like an
off-by-1 bug.

>         /* Try and find a power of two to add */
>         while (temp_size && mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB, 1)==-EINVAL) {
>                 temp_size >>= 1;
>         }
> }

Secondly, what's the point of requesting a smaller write-combining
segment that won't cover all the video memory being used? If it fails
the first time round, shouldn't we either give up or attempt requesting
several contiguous segments?

-- arvind
