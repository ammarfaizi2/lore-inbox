Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTKYVQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 16:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTKYVQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 16:16:32 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:17367 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263244AbTKYVQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 16:16:31 -0500
Date: Tue, 25 Nov 2003 13:14:25 -0800
To: Andrew Morton <akpm@osdl.org>
Cc: Jack Steiner <steiner@sgi.com>, jes@trained-monkey.org, viro@math.psu.edu,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: hash table sizes
Message-ID: <20031125211424.GA32636@sgi.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jack Steiner <steiner@sgi.com>, jes@trained-monkey.org,
	viro@math.psu.edu, wli@holomorphy.com, linux-kernel@vger.kernel.org
References: <16323.23221.835676.999857@gargle.gargle.HOWL> <20031125204814.GA19397@sgi.com> <20031125130741.108bf57c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125130741.108bf57c.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 01:07:41PM -0800, Andrew Morton wrote:
> the size of these tables dependent upon the number of dentries/inodes/etc
> which the system is likely to support.  And that does depend upon the
> amount of direct-addressible memory.
> 
> 
> So hum.  As a starting point, what happens if we do:
> 
> -	vfs_caches_init(num_physpages);
> +	vfs_caches_init(min(num_physpages, pages_in_ZONE_NORMAL));
> 
> ?

Something like that might be ok, but on our system, all memory is in
ZONE_DMA...

Jesse
