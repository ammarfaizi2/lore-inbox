Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUBDPRB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 10:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUBDPRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 10:17:01 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:23556 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262913AbUBDPQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 10:16:58 -0500
Date: Wed, 4 Feb 2004 15:16:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Steve Lord <lord@xfs.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040204151647.A19158@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steve Lord <lord@xfs.org>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <bv8qr7$m2v$1@news.cistron.nl> <20040129063009.GD2474@frodo> <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org> <20040129063009.GD2474@frodo> <20040129232033.GA10541@cistron.nl> <20040204000315.A12127@infradead.org> <401FAC70.8070104@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <401FAC70.8070104@xfs.org>; from lord@xfs.org on Tue, Feb 03, 2004 at 08:13:04AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 08:13:04AM -0600, Steve Lord wrote:
> >  			ip->i_rdev = rdev;
> > -		else if (S_ISDIR(mode))
> > -			validate_fields(ip);
> > +		validate_fields(ip);
> 
> There was some reason this was only necessary on directories, but I
> cannot remember why just now.

Well, it is nessecary now to update i_size.  Or rather it was, I think
I can get rid of it again after taking care of initialize_vnode.

> I think this should work, it just leaves the extending O_DIRECT write
> case.

And initialize_vnode.  I have a working patch for the latter, but I still
need to take a look at O_DIRECT.

> Keeping the revalidate call out of the path for creating regular
> files would be nice though, why did you deem that necessary?

I thought I need it for i_size udates, but we should be able to take
care of it in initialize_vnode.

