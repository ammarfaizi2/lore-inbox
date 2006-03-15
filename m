Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWCOOzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWCOOzt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 09:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWCOOzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 09:55:49 -0500
Received: from ns.firmix.at ([62.141.48.66]:37042 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750922AbWCOOzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 09:55:48 -0500
Subject: Re: [PATCH] modpost: fix buffer overflow
From: Bernd Petrovitsch <bernd@firmix.at>
To: Jiri Benc <jbenc@suse.cz>
Cc: rusty@rustcorp.com.au, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060315154436.4286d2ab@griffin.suse.cz>
References: <20060315154436.4286d2ab@griffin.suse.cz>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 15 Mar 2006 15:55:29 +0100
Message-Id: <1142434529.17627.2.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 15:44 +0100, Jiri Benc wrote:
> I got SIGABRT in modpost when building a module really deeply nested in
> a filesystem (path > 100 chars):
> 
> >   Building modules, stage 2.
> >   MODPOST
> > *** glibc detected *** scripts/mod/modpost: realloc(): invalid next size: 0x0809f588 ***
> > [...]
> 
> This patch fixes that problem.
> 
> Signed-off-by: Jiri Benc <jbenc@suse.cz>
> 
> --- linux-2.6.16-rc6.orig/scripts/mod/modpost.c
> +++ linux-2.6.16-rc6/scripts/mod/modpost.c
> @@ -552,7 +552,7 @@ void __attribute__((format(printf, 2, 3)
>  	
>  	va_start(ap, fmt);
>  	len = vsnprintf(tmp, SZ, fmt, ap);
> -	if (buf->size - buf->pos < len + 1) {
> +	while (buf->size - buf->pos < len + 1) {
>  		buf->size += 128;
>  		buf->p = realloc(buf->p, buf->size);
>  	}

Are you sure you won't pull the line with realloc() out of the loop and
do it once afterwards?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

