Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVD3IfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVD3IfY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 04:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVD3IfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 04:35:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17838 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261158AbVD3IfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 04:35:17 -0400
Date: Sat, 30 Apr 2005 09:35:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050430083516.GC23253@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, bulb@ucw.cz,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <E1DPofK-0000Yu-00@localhost> <20050425071047.GA13975@vagabond> <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 11:58:50AM +0200, Miklos Szeredi wrote:
> > I can't write a script that reads your mind. But I sure can write
> > a script that finds out what you mounted in the other shells (with help
> > of a little wrapper around the mount command).
> 
> How do you bind mount it from a different namespace?  You _do_ need
> bind mount, since a new mount might require password input, etc...

Not nessecarily.  The filesystem gets called into ->get_sb for every mount,
and can then decided whether to return an existing superblock instance or
setup a new one.  If the credentials for the new mount match an old one
it can just reuse it.  (e.g. for block based filesystem it will always reuse
right now)

