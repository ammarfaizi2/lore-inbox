Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbTGBKUg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 06:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbTGBKUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 06:20:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65450 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264897AbTGBKUe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 06:20:34 -0400
Date: Wed, 2 Jul 2003 11:34:57 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jan Kratochvil 
	<rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       chaffee@cs.berkeley.edu, zippel@linux-m68k.org
Subject: Re: [PATCH] vfat+affs case preservation
Message-ID: <20030702103457.GS27348@parcelfarce.linux.theplanet.co.uk>
References: <20030702102538.GA16711@exuhome.dyn.jankratochvil.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702102538.GA16711@exuhome.dyn.jankratochvil.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 12:25:38PM +0200, Jan Kratochvil wrote:
> +/* We have to always do the revalidate as after unlink (etc.) there still may
> + * exist other case-different dentries for the same inode. It would be also
> + * possible to discard such aliases by going through d_alias links during the
> + * unlink. "strictcase" does not have case-different dentries but "longna~1"
> + * style aliases still exist there.
> + */

> -	alias = d_find_alias(inode);
> -	if (alias) {
> -		if (d_invalidate(alias)==0)
> -			dput(alias);
> -		else {
> -			iput(inode);
> -			unlock_kernel();
> -			return alias;
> -		}
> -		
> -	}

Broken.   With that we can get two active dentries for the same directory.
There goes any cache coherency, with all usual results.
