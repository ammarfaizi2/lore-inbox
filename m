Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318024AbSGLUzl>; Fri, 12 Jul 2002 16:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318025AbSGLUzk>; Fri, 12 Jul 2002 16:55:40 -0400
Received: from ns.suse.de ([213.95.15.193]:20239 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318024AbSGLUzj>;
	Fri, 12 Jul 2002 16:55:39 -0400
Date: Fri, 12 Jul 2002 22:58:28 +0200
From: Dave Jones <davej@suse.de>
To: Paul Menage <pmenage@ensim.com>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Rearranging struct dentry for cache affinity
Message-ID: <20020712225828.E18503@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Paul Menage <pmenage@ensim.com>, viro@math.psu.edu,
	linux-kernel@vger.kernel.org
References: <E17T7BT-0006zT-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E17T7BT-0006zT-00@pmenage-dt.ensim.com>; from pmenage@ensim.com on Fri, Jul 12, 2002 at 01:38:35PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 01:38:35PM -0700, Paul Menage wrote:

 > -		dentry->d_vfs_flags |= DCACHE_REFERENCED;
 > +#ifdef CONFIG_SMP
 > +		if(!(dentry->d_vfs_flags & DCACHE_REFERENCED))
 > +#endif
 > +			dentry->d_vfs_flags |= DCACHE_REFERENCED;

Yuck. Is doing this conditional on UP really a measurable effect?
Somehow I doubt it's worth this ugliness. If you must microoptimise
to this level, at least try and keep the code clean.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
