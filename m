Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270812AbRHNU2x>; Tue, 14 Aug 2001 16:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270808AbRHNU2q>; Tue, 14 Aug 2001 16:28:46 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:12018 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S270820AbRHNU2S>; Tue, 14 Aug 2001 16:28:18 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108142025.f7EKPXKa027784@webber.adilger.int>
Subject: Re: [PATCH] LVM snapshot support for reiserfs and others
In-Reply-To: <992230000.997472946@tiny> "from Chris Mason at Aug 10, 2001 03:49:06
 pm"
To: Chris Mason <mason@suse.com>
Date: Tue, 14 Aug 2001 14:25:33 -0600 (MDT)
CC: Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, lvm-devel@sistina.com
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris writes:
> +static inline void write_super_lockfs(struct super_block *sb)
> +{
> +	lock_super(sb);
> +	if (sb->s_root) {
> +		if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
> +			sb->s_op->write_super(sb);
> +		if (sb->s_op && sb->s_op->write_super_lockfs)
> +			sb->s_op->write_super_lockfs(sb);
> +	}
> +	unlock_super(sb);
> +}

Minor nit, could it be:
	if (sb->s_root && sb->s_op) {
		if (sb->s_dirt && sb->s_op->write_super)
			sb->s_op->write_super(sb);
		if (sb->s_op->write_super_lockfs)
			sb->s_op->write_super_lockfs(sb);
	}

I'm just going to do some testing...

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

