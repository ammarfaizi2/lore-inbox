Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWFAREd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWFAREd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbWFAREd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:04:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:33393 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964908AbWFAREd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:04:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=QtCbASjC4Kn2xeDY/XwHHTitSE6R14T8TLSJyz1OwaHbJLZB7WwV7DZCOLlEh4glyr9Orc6b1yOL/mE2geTif40v8Ixb2cne7RjQtsP1l2XX5mz9LWwCPmt5WJU0qDOmzSOt12r6ZSjOP0DiYrfD5G3wYRMuSjKH9AZlfyCqLgc=
Date: Thu, 1 Jun 2006 21:04:45 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org, mm@caldera.de
Subject: Re: [Patch] Check sound_alloc_mixerdev() failure in sound/oss/nm256_audio.c
Message-ID: <20060601170445.GA7265@martell.zuzino.mipt.ru>
References: <1149155608.9452.1.camel@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149155608.9452.1.camel@alice>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 11:53:28AM +0200, Eric Sesterhenn wrote:
> When sound_alloc_mixerdev() fails it returns a
> negative value, which the driver fails to check.

That's true.

> --- linux-2.6.17-rc5/sound/oss/nm256_audio.c.orig
> +++ linux-2.6.17-rc5/sound/oss/nm256_audio.c
> @@ -974,7 +974,7 @@ nm256_install_mixer (struct nm256_info *
>  	return -1;
>  
>      mixer = sound_alloc_mixerdev();
       ^^^^^
> -    if (num_mixers >= MAX_MIXER_DEV) {
> +    if ((num_mixers >= MAX_MIXER_DEV) || (num_mixers < 0)) {
					     ^^^^^^^^^^
>  	printk ("NM256 mixer: Unable to alloc mixerdev\n");
>  	return -1;
>      }

But it is _still_ fails to check it.

