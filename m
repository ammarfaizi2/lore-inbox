Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbWF1IkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbWF1IkH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbWF1IkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:40:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55782 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030481AbWF1IkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:40:03 -0400
Subject: Re: [PATCH] ia64: change usermode HZ to 250
From: Arjan van de Ven <arjan@infradead.org>
To: hawkes@sgi.com
Cc: Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       Jeremy Higdon <jeremy@sgi.com>
In-Reply-To: <20060627220139.3168.69409.sendpatchset@tomahawk.engr.sgi.com>
References: <20060627220139.3168.69409.sendpatchset@tomahawk.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 10:39:54 +0200
Message-Id: <1151483994.3153.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 15:01 -0700, hawkes@sgi.com wrote:
> include/asm-ia64/param.h defines HZ to be 1024 for usermode use, i.e.,
> when the file gets installed as /usr/include/asm/param.h.
> As the comment says:
>     Technically, this is wrong, but some old apps still refer to it.  
>     The proper way to get the HZ value is via sysconf(_SC_CLK_TCK).
> At the very least, this technically wrong #define ought to reflect the
> current default value (250) used by all arch/ia64 platforms.  No one uses
> 1024 anymore.  This makes those "old apps" (e.g., usr/bin/iostat) behave
> properly for with a default kernel.  (And at some point, the define ought
> to be removed altogether, which would expose all the applications that
> erroneously expect HZ to be a compile-time constant.)
> 
> Signed-off-by: John Hawkes <hawkes@sgi.com>
> 
> Index: linux/include/asm-ia64/param.h
> ===================================================================
> --- linux.orig/include/asm-ia64/param.h	2006-06-17 18:49:35.000000000 -0700
> +++ linux/include/asm-ia64/param.h	2006-06-27 14:46:53.119407077 -0700
> @@ -36,7 +36,7 @@
>      * Technically, this is wrong, but some old apps still refer to it.  The proper way to
>      * get the HZ value is via sysconf(_SC_CLK_TCK).
>      */
> -# define HZ 1024
> +# define HZ 250
>  #endif

ok why not define the userspace HZ to 

#define HZ sysconf(_SC_CLK_TCK)

?


