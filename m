Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVANNzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVANNzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 08:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVANNzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 08:55:46 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:3256 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261985AbVANNzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 08:55:35 -0500
Date: Fri, 14 Jan 2005 14:55:27 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: swapspace layout improvements advocacy
In-Reply-To: <20050112105315.2ac21173.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0501141433000.7044@gockel.physik3.uni-rostock.de>
References: <20050112123524.GA12843@lnx-holt.americas.sgi.com>
 <Pine.LNX.4.44.0501121758180.2765-100000@localhost.localdomain>
 <20050112105315.2ac21173.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005, Andrew Morton wrote:

> Our current way of allocating swap can cause us to end up with little
> correlation between adjacent pages on-disk.  But this can be improved.  THe
> old swapspace-layout-improvements patch was designed to fix that up, but
> needs more testing and tuning.
> 
> It clusters pages on-disk via their virtual address.

2.6 seems in due need of such a patch.

I recently found out that 2.6 kernels degrade horribly when going into 
swap. On my dual PIII-850 with as little as 256 mb ram, I can easily 
demonstrate that by opening about 40-50 instances of konquerer with large 
tables, many images and such things. When the machine is into 80-120 mb of 
the 256 mb swap partition, it becomes almost unusable. Even the desktop 
background picture needs ~20sec to update, not to talk about any windows' 
contents. And you can literally hear the reason for it: the harddisk is 
seeking like crazy.

I've applied Ingo Molnars swapspace-layout-improvements-2.6.9-rc1-bk12-A1
port of the patch to a 2.6.11-rc1 kernel, and it handles the same workload 
much smoother. It's slow, but you can work with it.

I just wonder why noone else complained yet. Are systems with tight memory 
constraints so uncommon these days?

Tim
