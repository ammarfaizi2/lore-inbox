Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751673AbWGZRMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWGZRMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWGZRMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:12:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45701 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751659AbWGZRMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:12:36 -0400
Message-ID: <44C7A272.8030401@sandeen.net>
Date: Wed, 26 Jul 2006 12:12:18 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>, jack@suse.cz,
       20@madingley.org, marcel@holtmann.org, linux-kernel@vger.kernel.org,
       sct@redhat.com, adilger@clusterfs.com
Subject: Re: Bad ext3/nfs DoS bug
References: <20060718145614.GA27788@circe.esc.cam.ac.uk>	<1153236136.10006.5.camel@localhost>	<20060718152341.GB27788@circe.esc.cam.ac.uk>	<1153253907.21024.25.camel@localhost>	<20060719092810.GA4347@circe.esc.cam.ac.uk>	<20060719155502.GD3270@atrey.karlin.mff.cuni.cz>	<17599.2754.962927.627515@cse.unsw.edu.au>	<20060720160639.GF25111@atrey.karlin.mff.cuni.cz>	<17600.30372.397971.955987@cse.unsw.edu.au>	<20060721170627.4cbea27d.akpm@osdl.org>	<20060722131759.GC7321@thunk.org>	<20060724185604.9181714c.akpm@osdl.org> <17605.32781.909741.310735@cse.unsw.edu.au>
In-Reply-To: <17605.32781.909741.310735@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +EXPORT_SYMBOL_GPL(export_iget);
...
> +static struct dentry *ext3_get_dentry(struct super_block *sb, void *vobjp)
> +{
> +	__u32 *objp = vobjp;
> +	unsigned long ino = objp[0];
> +	__u32 generation = objp[1];
> +
> +	if (ino != EXT3_ROOT_INO && ino < EXT3_FIRST_INO(sb))
> +		return ERR_PTR(-ESTALE);
> +
> +	return export_iget(sb, ino, generation);
> +}

Hm, with this, ext3.ko has a new dependency on exportfs.ko.  Is that 
desirable/acceptable?
-Eric
