Return-Path: <linux-kernel-owner+w=401wt.eu-S965114AbXATDwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbXATDwH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 22:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbXATDwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 22:52:07 -0500
Received: from ns.suse.de ([195.135.220.2]:44679 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965129AbXATDwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 22:52:05 -0500
Date: Sat, 20 Jan 2007 04:52:04 +0100
From: Nick Piggin <npiggin@suse.de>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Filesystems <linux-fsdevel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 6/10] mm: be sure to trim blocks
Message-ID: <20070120035204.GB30774@wotan.suse.de>
References: <20070113011159.9449.4327.sendpatchset@linux.site> <20070113011255.9449.33228.sendpatchset@linux.site> <1168968985.5975.30.camel@lappy> <1168974857.5975.36.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168974857.5975.36.camel@lappy>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 08:14:16PM +0100, Peter Zijlstra wrote:
> On Tue, 2007-01-16 at 18:36 +0100, Peter Zijlstra wrote:
> >   							buf, bytes);
> > > @@ -1935,10 +1922,9 @@ generic_file_buffered_write(struct kiocb
> > >  						cur_iov, iov_offset, bytes);
> > >  		flush_dcache_page(page);
> > >  		status = a_ops->commit_write(file, page, offset, offset+bytes);
> > > -		if (status == AOP_TRUNCATED_PAGE) {
> > > -			page_cache_release(page);
> > > -			continue;
> > > -		}
> > > +		if (unlikely(status))
> > > +			goto fs_write_aop_error;
> > > +
> > 
> > I don't think this is correct, see how status >= 0 is used a few lines
> > downwards. Perhaps something along the lines of an
> > is_positive_aop_return() to test on?
> 
> Hmm, if commit_write() will never return non error positive values then
> this and 8/10 look sane.

It's really ugly, but it looks like at least some filesystems do. So
I'll fix up this.
