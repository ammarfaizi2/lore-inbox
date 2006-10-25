Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423265AbWJYLEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423265AbWJYLEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 07:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423268AbWJYLEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 07:04:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:20181 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1423265AbWJYLEX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 07:04:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Vasily Tarasov <vtaras@openvz.org>
Subject: Re: [PATCH] diskquota: 32bit quota tools on 64bit architectures
Date: Wed, 25 Oct 2006 13:03:48 +0200
User-Agent: KMail/1.9.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jan Kara <jack@suse.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Kagan <rkagan@sw.ru>,
       Randy Dunlap <rdunlap@xenotime.net>, Dmitry Mishin <dim@openvz.org>,
       Andi Kleen <ak@suse.de>, Vasily Averin <vvs@sw.ru>,
       Christoph Hellwig <hch@infradead.org>, Kirill Korotaev <dev@openvz.org>,
       OpenVZ Developers List <devel@openvz.org>
References: <200610251003.k9PA38kD018604@vass.7ka.mipt.ru>
In-Reply-To: <200610251003.k9PA38kD018604@vass.7ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610251303.50551.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 October 2006 12:03, Vasily Tarasov wrote:
> + * This code works only for 32 bit quota tools over 64 bit OS (x86_64, ia64)
> + * and is necessary due to alignment problems.
> + */
> +struct compat_if_dqblk {
> +       compat_uint_t dqb_bhardlimit[2];
> +       compat_uint_t dqb_bsoftlimit[2];
> +       compat_uint_t dqb_curspace[2];
> +       compat_uint_t dqb_ihardlimit[2];
> +       compat_uint_t dqb_isoftlimit[2];
> +       compat_uint_t dqb_curinodes[2];
> +       compat_uint_t dqb_btime[2];
> +       compat_uint_t dqb_itime[2];
> +       compat_uint_t dqb_valid;
> +};
> +
> +/* XFS structures */
> +struct compat_fs_qfilestat {
> +       compat_uint_t dqb_bhardlimit[2];
> +       compat_uint_t   qfs_nblks[2];
> +       compat_uint_t   qfs_nextents;
> +};
> +

The patch looks technically correct, but you have defined the structures
in a somewhat unusual way. I'd have defined them with 
attribute((packed, aligned(4))) in the end.

Or even better, we should probably add a 

typedef unsigned long long __attribute__((aligned(4))) compat_u64;

for x86 compat and use that instead of compat_uint_t foo[2].

	Arnd <><
