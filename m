Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWBWQhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWBWQhO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWBWQhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:37:14 -0500
Received: from kanga.kvack.org ([66.96.29.28]:31213 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751435AbWBWQhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:37:12 -0500
Date: Thu, 23 Feb 2006 11:32:04 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       christoph <hch@lst.de>, mcao@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] change b_size to size_t
Message-ID: <20060223163204.GA27682@kvack.org>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com> <20060222151216.GA22946@lst.de> <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com> <20060222165942.GA25167@lst.de> <20060223014004.GA900@frodo> <20060222175923.784ce5de.akpm@osdl.org> <1140712093.22756.106.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140712093.22756.106.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 08:28:12AM -0800, Badari Pulavarty wrote:
> Here is the updated version of the patch, which changes
> buffer_head.b_size to size_t to support mapping large
> amount of disk blocks (for large IOs).

Your patch doesn't seem to be inline, so I can't quote it.  Several 
problems: on 64 bit platforms you introduced 4 bytes of padding into 
buffer_head.  atomic_t only takes up 4 byte, while size_t is 8 byte 
aligned.  This is a waste of memory, imo, seeing as the vast majority 
of systems out there will not be doing 4GB+ ios any time soon.

Also, the cast to unsigned long long for size_t is pretty atrocious.  
Cast to unsigned long if anything, as size_t is unsigned long on all 
platforms linux runs on.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
