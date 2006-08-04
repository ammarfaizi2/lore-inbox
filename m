Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWHDNJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWHDNJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 09:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWHDNJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 09:09:33 -0400
Received: from e-nvb.com ([69.27.17.200]:5257 "EHLO e-nvb.com")
	by vger.kernel.org with ESMTP id S1030217AbWHDNJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 09:09:33 -0400
Subject: Re: [patch 12/23] invalidate_bdev() speedup
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       jmforbes@linuxtx.org, zwane@arm.linux.org.uk, tytso@mit.edu,
       rdunlap@xenotime.net, davej@redhat.com, chuckw@quantumlinux.com,
       reviews@ml.cw.f00f.org, alan@lxorguk.ukuu.org.uk,
       jes@trained-monkey.org, jes@sgi.com
In-Reply-To: <20060804020422.09b32164.akpm@osdl.org>
References: <20060804053258.391158155@quad.kroah.org>
	 <20060804053942.GM769@kroah.com> <20060804085012.GA20026@infradead.org>
	 <20060804020422.09b32164.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 04 Aug 2006 15:08:49 +0200
Message-Id: <1154696949.2996.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 02:04 -0700, Andrew Morton wrote:
> On Fri, 4 Aug 2006 09:50:13 +0100
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Thu, Aug 03, 2006 at 10:39:42PM -0700, Greg KH wrote:
> > > -stable review patch.  If anyone has any objections, please let us know.
> > 
> > This is a feature.  Definitly not -stable material.
> 
> Apparently that regular IPI storm is causing the SGI machines some
> significant problems. 

a tiny performance drop :) If that meets the stable policy.. open
question :)

> It's not the biggest problem we've ever had, but if this patch is wrong,
> the pagecache/buffer_head layer is utterly busted.  And it isn't.


are you sure?

+       struct address_space *mapping = bdev->bd_inode->i_mapping;
+
+       if (mapping->nrpages == 0)
+               return;
+
        invalidate_bh_lrus();

what happens if a bdev used to have pagecache and at some point stops
having that due to page reclaim... will that page reclaim call
invalidate_bh_lrus() ? If not, who will ? If the answer is "nobody", is
that really the right answer?



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

