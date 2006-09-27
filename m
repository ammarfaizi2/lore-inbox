Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWI0QTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWI0QTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWI0QTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:19:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:64653 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751208AbWI0QTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:19:08 -0400
Date: Wed, 27 Sep 2006 09:19:00 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andy Whitcroft <apw@shadowen.org>
cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] zone table removal miss merge
In-Reply-To: <20060927112315.GA8093@shadowen.org>
Message-ID: <Pine.LNX.4.64.0609270911060.9171@schroedinger.engr.sgi.com>
References: <20060927021934.9461b867.akpm@osdl.org> <20060927112315.GA8093@shadowen.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006, Andy Whitcroft wrote:

> The below should fix it.

Acked-by: Christoph Lameter <clameter@sgi.com>


Note that if ZONE_DMA is off then ZONES_WIDTH may become
0 and therefore also ZONES_PGSHIFT is zero.

If you then do

#define ZONEID_PGSHIFT ZONES_PGSHIFT

then ZONEID_PGSHIFT will be 0!

So this could be an issue for the optional ZONE_DMA patch.

Could you also make sure that ZONEID_PGSHIFT is set correctly even if 
ZONES_WIDTH is zero?

This affects the optional ZONE_DMA patch. zone table removal should be 
fine with just the above patch.


