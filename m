Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263843AbUEMHMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbUEMHMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 03:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbUEMHMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 03:12:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:22146 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263843AbUEMHMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 03:12:00 -0400
Subject: Re: More convenient way to grab hugepage memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       David Gibson <david@gibson.dropbear.id.au>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Adam Litke <agl@us.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>
In-Reply-To: <20040513065912.GR1397@holomorphy.com>
References: <20040513055520.GF27403@zax> <20040513060549.GA12695@mulix.org>
	 <20040513065912.GR1397@holomorphy.com>
Content-Type: text/plain
Message-Id: <1084432141.13731.99.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 13 May 2004 17:09:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-13 at 16:59, William Lee Irwin III wrote:
> On Thu, May 13, 2004 at 09:05:50AM +0300, Muli Ben-Yehuda wrote:
> > These two global variables do not appear to be used anywhere in this
> > patch?
> > > +static inline unsigned long __do_mmap_pgoff(struct file * file, unsigned long addr,
> > __do_mmap_pgoff seems rather long to be inline?
> 
> Atop my other patch to nuke the unused global variables, here is a patch
> to manually inline __do_mmap_pgoff(), removing the inline usage. Untested.
> Are you sure you want this? #ifdef'ing out the hugetlb case is somewhat
> more digestible with the inline in place, e.g.:

Well, I did the breakup in 2 pieces in the first place for 2 reasons:

 - the original patch had some subtle issues with accounting
 - do_mmap_pgoff is already such a mess, let's not make it worse

I mean, it's awful to get anything right in this function, especially
the cleanup/exit path, which is why I think it's more maintainable
cut in 2.

Ben.


