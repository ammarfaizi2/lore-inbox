Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264249AbTDXDYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 23:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbTDXDYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 23:24:45 -0400
Received: from to-telus.redhat.com ([207.219.125.105]:2548 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id S264249AbTDXDYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 23:24:44 -0400
Date: Wed, 23 Apr 2003 23:36:52 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.68-mm2
Message-ID: <20030423233652.C9036@redhat.com>
References: <20030423012046.0535e4fd.akpm@digeo.com> <18400000.1051109459@[10.10.2.4]> <20030423144648.5ce68d11.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030423144648.5ce68d11.akpm@digeo.com>; from akpm@digeo.com on Wed, Apr 23, 2003 at 02:46:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 02:46:48PM -0700, Andrew Morton wrote:
> Ingo-rmap seems a better solution to me.  It would be a fairly large change
> though - we'd have to hold the four atomic kmaps across an entire pte page
> in copy_page_range(), for example.  But it will then have good locality of
> reference between adjacent pages and may well be quicker than pte_chains.

Actually, Ingo's rmap style sounds very similar to what I first implemented 
in one of my stabs at rmap.  It has a nasty side effect of being worst case 
for cache organisation -- the sister page tends to map to the exact same 
cache line in some processors.  Whoops.  That said, I think that the rmap 
pte-chains can really stand a bit of optimization by means of discarding a 
couple of bits, as well as merging for adjacent pages, so I don't think 
the overhead is a lost cause yet.  And nobody has written the clone() patch 
for bash yet...

		-ben
-- 
Junk email?  <a href="mailto:aart@kvack.org">aart@kvack.org</a>
