Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262441AbSJKNg1>; Fri, 11 Oct 2002 09:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262444AbSJKNg1>; Fri, 11 Oct 2002 09:36:27 -0400
Received: from holomorphy.com ([66.224.33.161]:62080 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262441AbSJKNg0>;
	Fri, 11 Oct 2002 09:36:26 -0400
Date: Fri, 11 Oct 2002 06:38:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.41-mm3
Message-ID: <20021011133842.GX10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>
References: <3DA699AA.BBA05716@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA699AA.BBA05716@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 02:28:10AM -0700, Andrew Morton wrote:
> url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.41/2.5.41-mm3/

This paride driver seems to have been missed with all the sector_t
and sector_div() business.

--- akpm-2.5.41-3/drivers/block/paride/pf.c	2002-10-11 06:09:31.000000000 -0700
+++ wli-2.5.41-3/drivers/block/paride/pf.c	2002-10-11 06:38:16.000000000 -0700
@@ -369,11 +369,11 @@
 		return -EINVAL;
 	capacity = get_capacity(pf->disk);
 	if (capacity < PF_FD_MAX) {
-		g.cylinders = capacity / (PF_FD_HDS * PF_FD_SPT);
+		g.cylinders = sector_div(capacity, PF_FD_HDS * PF_FD_SPT);
 		g.heads = PF_FD_HDS;
 		g.sectors = PF_FD_SPT;
 	} else {
-		g.cylinders = capacity / (PF_HD_HDS * PF_HD_SPT);
+		g.cylinders = sector_div(capacity, PF_HD_HDS * PF_HD_SPT);
 		g.heads = PF_HD_HDS;
 		g.sectors = PF_HD_SPT;
 	}
