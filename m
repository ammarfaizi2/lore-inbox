Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbULPQKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbULPQKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbULPQKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:10:18 -0500
Received: from [213.146.154.40] ([213.146.154.40]:12989 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261438AbULPQIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:08:22 -0500
Date: Thu, 16 Dec 2004 16:08:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, mingo@elte.hu,
       rlrevell@joe-job.com, tiwai@suse.de, linux-kernel@vger.kernel.org,
       pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [PATCH] unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041216160811.GA9641@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
	mingo@elte.hu, rlrevell@joe-job.com, tiwai@suse.de,
	linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
	gordon.jin@intel.com, alsa-devel@lists.sourceforge.net,
	greg@kroah.com
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217014345.GA11926@mellanox.co.il>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	long (*ioctl_native) (struct inode *, struct file *, unsigned int,
> +			unsigned long);
> +	long (*ioctl_compat) (struct inode *, struct file *, unsigned int,
> +			unsigned long);

Please remove the struct inode * argument, it's easily retrievable
from file->f_dentry->d_inode.  The ioctl prototype is a leftover from
really old days where that wasn't true.

