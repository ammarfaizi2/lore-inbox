Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWGGKBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWGGKBm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWGGKBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:01:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35530 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932105AbWGGKBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:01:41 -0400
Date: Fri, 7 Jul 2006 11:01:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
Message-ID: <20060707100137.GA29011@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Halcrow <mhalcrow@us.ibm.com>,
	Phillip Hellewell <phillip@hellewell.homeip.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20060513033742.GA18598@hellewell.homeip.net> <20060520095740.GA12237@infradead.org> <20060601204756.GB10942@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601204756.GB10942@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 03:47:56PM -0500, Michael Halcrow wrote:
> On Sat, May 20, 2006 at 10:57:40AM +0100, Christoph Hellwig wrote:
> >  - please split all the generic stackable filesystem passthorugh routines
> >    into a separated stackfs layer, in a few files in fs/stackfs/ that
> >    you depend on.  They'll get _GPL exported to all possible stackable
> >    filesystem.  They'll need their own store underlying object helpers,
> >    but that can be made to work by embedding the generic stackfs data
> >    as first thing in the ecryptfs object.
> 
> We are looking into ways to do this in a way that makes sense, since
> there are so many varieties of stackable filesystems out there (e.g.,
> gzipfs, unionfs, ecryptfs, etc.), each filesystem having its own
> unique characteristics that affect how the ``stackable'' components
> take form. This is something we are investigating for the future, but
> in the meantime, we would like to have eCryptfs merged in as it is
> currently implemented.

All the namespace operations are the same for any stackable filesystem
that only changes data.  So just rename them, and split the private data
with the generic one always beeing the first memeber of the ecryptfs one.
It's prettyy trivial and I think fair to do before we put ecryptfs in.
