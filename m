Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWGMSru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWGMSru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWGMSru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:47:50 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:4012 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030286AbWGMSru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:47:50 -0400
Date: Thu, 13 Jul 2006 20:47:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: Matthew Wilcox <matthew@wil.cx>, wookey@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support DOS line endings
In-Reply-To: <20060713181825.GA22895@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0607132039560.12900@scrub.home>
References: <20060707173458.GB1605@parisc-linux.org>
 <Pine.LNX.4.64.0607080513280.17704@scrub.home> <20060713181825.GA22895@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 13 Jul 2006, Sam Ravnborg wrote:

> >       if (p2[-1] == '\r')
> >               p2[-1] = 0;
> Negative index'es always make me supsicious.

Opencoding of the strchr is not much better, you can change the above also 
to (*--p2 == '\r').

> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 2ee48c3..a30b1bb 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -192,9 +192,14 @@ load:
>  			if (!p)
>  				continue;
>  			*p++ = 0;
> -			p2 = strchr(p, '\n');
> -			if (p2)
> -				*p2 = 0;
> +			p2 = p;
> +		        while (*p2) {
> +				if (*p2 == '\r' || *p2 == '\n') {
> +					*p2 = 0;
> +					break;
> +				}
> +				p2++;
> +			}

IMO that's still too complicated, a '\n' is always the last character 
(unless the line was too long), with an optional '\r' in front of it.

bye, Roman
