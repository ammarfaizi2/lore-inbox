Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUHWSZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUHWSZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUHWSYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:24:52 -0400
Received: from mail.cs.umn.edu ([128.101.32.202]:26314 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S266391AbUHWSTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:19:05 -0400
Date: Mon, 23 Aug 2004 13:18:58 -0500
From: Dave C Boutcher <sleddog@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, paulus@samba.org, akpm@osdl.org,
       ipseries-list@redhat.com
Subject: Re: [PATCH] ppc64 mf_proc file position fix
Message-ID: <20040823181858.GA15598@cs.umn.edu>
Reply-To: boutcher@cs.umn.edu
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, paulus@samba.org,
	akpm@osdl.org, ipseries-list@redhat.com
References: <20040820201032.GA14005@cs.umn.edu> <20040823185423.A19476@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823185423.A19476@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 06:54:23PM +0100, Christoph Hellwig wrote:
> On Fri, Aug 20, 2004 at 03:10:32PM -0500, Dave C Boutcher wrote:
> > Andrew, 
> > 
> > arch/ppc64/kernel/mf_proc.c uses a bad interface for moving 
> > along file position in a proc_write routine.  This quit working
> > altogether in 2.6.8.  Patch to fix.  And I did a quick scan of the
> > kernel to see if anyone else was similarly broken...apparantly not :-)
> > 
> > Fixes a broken update of f_pos in a proc file write routine.
> 
> What about moving on to seq_file while you're at it?  Switching from
> one deprecated interface to another doesn't really sound like a worthwile
> effort.

The specific problem was on the write side, not the read side, so AFAIK,
seq_file wasn't going to help out.  I started re-writing the whole file
to use seq_file for all the read stuff, and after a few hours into it I
decided to just fix the broken bit rather than gratuitously rewriting
the whole thing.

-- 
Dave Boutcher
