Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTEFU7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTEFU7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:59:11 -0400
Received: from netline-be1.netline.ch ([195.141.226.32]:63236 "EHLO
	netline-be1.netline.ch") by vger.kernel.org with ESMTP
	id S261754AbTEFU7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:59:05 -0400
Subject: Re: [PATCH] 2.5.69 drm/radeon_cp.c
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: dri-devel@lists.sf.net, linux-fbdev-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030504204901.20761942.randy.dunlap@verizon.net>
References: <20030504204901.20761942.randy.dunlap@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Debian, XFree86
Message-Id: <1052255493.15269.159.camel@thor>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.1.99 (Preview Release)
Date: 06 May 2003 23:11:33 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 05:49, Randy.Dunlap wrote:
> 
> This patch to 2.5.69 fixes this warning (gcc 3.2):
> drivers/char/drm/radeon_cp.c: In function `radeon_cp_init_ring_buffer':
> drivers/char/drm/radeon_cp.c:908: warning: unsigned int format, different type arg (arg 3)
> drivers/char/drm/radeon_cp.c:908: warning: unsigned int format, different type arg (arg 3)
> 
> 
> Is this obvious enough?  Want it to go thru someone?

[...]

> maintainer:	dunno: Ani Joshi (ajoshi@shell.unixbox.com),
> 		James Simmons (jsimmons@infradead.org),
> 		Gareth Hughes (gareth.hughes@acm.org),
> 		Rik Faith (faith@redhat.com)

Make that dri-devel@lists.sf.net .

> diff -Naur ./drivers/char/drm/radeon_cp.c%VID ./drivers/char/drm/radeon_cp.c
> --- ./drivers/char/drm/radeon_cp.c%VID	2003-05-04 16:53:06.000000000 -0700
> +++ ./drivers/char/drm/radeon_cp.c	2003-05-04 20:30:30.000000000 -0700
> @@ -903,8 +903,8 @@
>  
>  		RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
>  			     entry->busaddr[page_ofs]);
> -		DRM_DEBUG( "ring rptr: offset=0x%08x handle=0x%08lx\n",
> -			   entry->busaddr[page_ofs],
> +		DRM_DEBUG( "ring rptr: offset=0x%08lx handle=0x%08lx\n",
> +			   (unsigned long) entry->busaddr[page_ofs],
>  			   entry->handle + tmp_ofs );
>  	}

Looks good to me, just committed it to the DRI CVS trunk. Thanks.


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

