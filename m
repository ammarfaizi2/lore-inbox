Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751820AbWGZXyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbWGZXyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 19:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWGZXyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 19:54:12 -0400
Received: from ns1.suse.de ([195.135.220.2]:33460 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751820AbWGZXyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 19:54:12 -0400
From: Neil Brown <neilb@suse.de>
To: Eric Sandeen <sandeen@sandeen.net>
Date: Thu, 27 Jul 2006 09:53:04 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17608.96.409298.126686@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>, jack@suse.cz,
       20@madingley.org, marcel@holtmann.org, linux-kernel@vger.kernel.org,
       sct@redhat.com, adilger@clusterfs.com
Subject: Re: Bad ext3/nfs DoS bug
In-Reply-To: message from Eric Sandeen on Wednesday July 26
References: <20060718145614.GA27788@circe.esc.cam.ac.uk>
	<1153236136.10006.5.camel@localhost>
	<20060718152341.GB27788@circe.esc.cam.ac.uk>
	<1153253907.21024.25.camel@localhost>
	<20060719092810.GA4347@circe.esc.cam.ac.uk>
	<20060719155502.GD3270@atrey.karlin.mff.cuni.cz>
	<17599.2754.962927.627515@cse.unsw.edu.au>
	<20060720160639.GF25111@atrey.karlin.mff.cuni.cz>
	<17600.30372.397971.955987@cse.unsw.edu.au>
	<20060721170627.4cbea27d.akpm@osdl.org>
	<20060722131759.GC7321@thunk.org>
	<20060724185604.9181714c.akpm@osdl.org>
	<17605.32781.909741.310735@cse.unsw.edu.au>
	<44C7A272.8030401@sandeen.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday July 26, sandeen@sandeen.net wrote:
> > +EXPORT_SYMBOL_GPL(export_iget);
> ...
> > +static struct dentry *ext3_get_dentry(struct super_block *sb, void *vobjp)
> > +{
> > +	__u32 *objp = vobjp;
> > +	unsigned long ino = objp[0];
> > +	__u32 generation = objp[1];
> > +
> > +	if (ino != EXT3_ROOT_INO && ino < EXT3_FIRST_INO(sb))
> > +		return ERR_PTR(-ESTALE);
> > +
> > +	return export_iget(sb, ino, generation);
> > +}
> 
> Hm, with this, ext3.ko has a new dependency on exportfs.ko.  Is that 
> desirable/acceptable?

Drat, you're right.
No, I don't think that is what we want.
I'll do it differently in a day or so.

Thanks,
NeilBrown
