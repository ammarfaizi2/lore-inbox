Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWEAQt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWEAQt0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 12:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWEAQtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 12:49:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:45543 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932150AbWEAQtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 12:49:24 -0400
Date: Mon, 1 May 2006 09:47:40 -0700
From: Greg KH <greg@kroah.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Arjan van de Ven <arjan@infradead.org>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4a/4] MultiAdmin LSM (LKCS'ed)
Message-ID: <20060501164740.GA8995@kroah.com>
References: <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr> <1145462454.3085.62.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr> <20060419201154.GB20545@kroah.com> <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr> <20060421150529.GA15811@kroah.com> <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr> <Pine.LNX.4.61.0605011801400.32172@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605011801400.32172@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 06:03:09PM +0200, Jan Engelhardt wrote:
> 
> 
> Does Lindented suffice?

It's a good start, but you still need to fix things like:

> +#include <asm/siginfo.h>
> +#include <linux/binfmts.h>
> +#include <linux/capability.h>
> +#include <linux/config.h>
> +#include <linux/dcache.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/ipc.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/namei.h>
> +#include <linux/sched.h>
> +#include <linux/securebits.h>
> +#include <linux/security.h>
> +#include <linux/sem.h>
> +#include <linux/types.h>

asm #include goes last.

> +static inline void chg2_superadm(kernel_cap_t *);
> +static inline void chg2_subadm(kernel_cap_t *);
> +static inline void chg2_netadm(kernel_cap_t *);
> +static inline int is_any_superadm(uid_t, gid_t);
> +static inline int is_uid_superadm(uid_t);
> +static inline int is_gid_superadm(gid_t);
> +static inline int is_any_subadm(uid_t, gid_t);
> +static inline int is_uid_subadm(uid_t);
> +static inline int is_gid_subadm(gid_t);
> +static inline int is_uid_netadm(uid_t);
> +static inline int is_uid_user(uid_t);
> +static inline int is_task1_user(const task_t *);
> +static inline int is_task_user(const task_t *);
> +static inline int range_intersect(uid_t, uid_t, uid_t, uid_t);
> +static inline int range_intersect_wrt(uid_t, uid_t, uid_t, uid_t);

inline functions don't need definitions like this.

> +static gid_t Supergid = -1, Subgid = -1;
> +static uid_t Superuid_start = 0, Superuid_end = 0,
> +    Subuid_start = -1, Subuid_end = -1,
> +    Netuid = -1, Wrtuid_start = -1, Wrtuid_end = -1;
> +static int Secondary = 0;

Variables do not have capital letters.

thanks,

greg k-h
