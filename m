Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268443AbUHZNm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268443AbUHZNm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268378AbUHZNm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:42:26 -0400
Received: from verein.lst.de ([213.95.11.210]:27607 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268840AbUHZNkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:40:52 -0400
Date: Thu, 26 Aug 2004 15:40:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christophe Saout <christophe@saout.de>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
Message-ID: <20040826134034.GA1470@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
References: <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <1093527307.11694.23.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093527307.11694.23.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 03:35:07PM +0200, Christophe Saout wrote:
> > If you want your
> > filesystem core portable it does to a certain extent make sense to
> > abstract them out, but as someone who's worked on a few such 'portable'
> > filesystems I can tell you that it doesn't work out as expected.
> 
> That's your opinion. reiser4 seems to work very well.

So how many OSes is it ported to currently?  The problem is not that it
doesn't work but that it's really hard to maintain.  And remember that
this maintaince overhead is not just for Hans but for everyone that does
VFS-level work.  Unless of course we get a blanko permission to break it
as soon as fixing the mess becomes non-trivial.

> What I understood is that you can select exactly one plugin that e.g.
> handles the file data. The default plugin is optimized for normal files,
> another one could implement transparent compression or encryption. Some
> of these plugins also give the storage layer hints how to group files
> together to optimized performance. Neither of these things mess with the
> VFS.

compression or encryption must sit below the pagecache to work nicely,
and this hint things that usually sit at the pagecache level.  But let's
assume you have a valid use for different file_operations, why don't you
simply add in different file_operations instead of adding another
internal dispatch layer?  

