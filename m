Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUIYGiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUIYGiz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 02:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269251AbUIYGiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 02:38:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9441 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266096AbUIYGix
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 02:38:53 -0400
Date: Sat, 25 Sep 2004 07:38:52 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 7/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation, cleanups and a bugfix
Message-ID: <20040925063852.GR23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 05:14:12PM +0100, Anton Altaparmakov wrote:
>   * Generic magic comparison macros. Finally found a use for the ## preprocessor
>   * operator! (-8
>   */
> -#define ntfs_is_magic(x, m)	(   (u32)(x) == magic_##m )
> -#define ntfs_is_magicp(p, m)	( *(u32*)(p) == magic_##m )
> +
> +static inline BOOL __ntfs_is_magic(le32 x, NTFS_RECORD_TYPES r)
> +{
> +	return (x == (__force le32)r);
> +}
> +#define ntfs_is_magic(x, m)	__ntfs_is_magic(x, magic_##m)
> +
> +static inline BOOL __ntfs_is_magicp(le32 *p, NTFS_RECORD_TYPES r)
> +{
> +	return (*p == (__force le32)r);
> +}
> +#define ntfs_is_magicp(p, m)	__ntfs_is_magicp(p, magic_##m)

*eeeeeek*

It looks badly wrong.  Why do you need these casts?
