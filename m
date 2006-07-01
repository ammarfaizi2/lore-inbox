Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWGADiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWGADiw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 23:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWGADiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 23:38:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36327 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932402AbWGADiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 23:38:46 -0400
Date: Fri, 30 Jun 2006 20:35:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mm/mmzone.c: EXPORT_UNUSED_SYMBOL
Message-Id: <20060630203533.71c3fdf1.akpm@osdl.org>
In-Reply-To: <20060630113248.GQ19712@stusta.de>
References: <20060630113248.GQ19712@stusta.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 13:32:48 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> -EXPORT_SYMBOL(first_online_pgdat);
> +EXPORT_UNUSED_SYMBOL(first_online_pgdat);  /*  June 2006  */

for_each_zone() and for_each_online_pgdat() need this.  So the export is an
internal implementation detail to support those macros.  Those macros are
reasonable(ish) things to be doing from modules - could be that people
are using for_each_zone() already.

> -EXPORT_SYMBOL(next_online_pgdat);
> +EXPORT_UNUSED_SYMBOL(next_online_pgdat);  /*  June 2006  */

Ditto

> -EXPORT_SYMBOL(next_zone);
> +EXPORT_UNUSED_SYMBOL(next_zone);  /*  June 2006  */
>  

Tritto.

We could give it a whizz, but I'd expect that we'll end up dropping it. 
But then again, zones are fairly low-level things.  Let's give it a try.
