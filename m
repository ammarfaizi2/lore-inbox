Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVGUP1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVGUP1b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 11:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVGUP1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 11:27:17 -0400
Received: from dsl3-63-249-67-69.cruzio.com ([63.249.67.69]:59011 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S261799AbVGUPZe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 11:25:34 -0400
Date: Thu, 21 Jul 2005 08:25:19 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200507211525.j6LFPJIA009192@cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: Re: a 15 GB file on tmpfs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2005 at 02:16:36PM +0200, Bastiaan Naber wrote:
> I have a 15 GB file which I want to place in memory via tmpfs. I want to do 
> this because I need to have this data accessible with a very low seek time.

You don't want tmpfs. You want either (1) ramfs and copy the data once at
boot time or (2) any filesystem and mmap and lock which will read the data
every time your app starts. 

Tmpfs is backed by swap so other system activity will potentially cause some of
the file to go to swap which kills your latency spec.

HTH

