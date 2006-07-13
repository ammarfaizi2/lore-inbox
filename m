Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWGMUC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWGMUC0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWGMUC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:02:26 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:40862 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1030342AbWGMUCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:02:25 -0400
Date: Thu, 13 Jul 2006 14:02:23 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, wookey@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support DOS line endings
Message-ID: <20060713200223.GL1629@parisc-linux.org>
References: <20060707173458.GB1605@parisc-linux.org> <Pine.LNX.4.64.0607080513280.17704@scrub.home> <20060713181825.GA22895@mars.ravnborg.org> <Pine.LNX.4.64.0607132039560.12900@scrub.home> <20060713193543.GB312@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713193543.GB312@mars.ravnborg.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 09:35:43PM +0200, Sam Ravnborg wrote:
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -195,6 +195,8 @@ load:
>  			p2 = strchr(p, '\n');
>  			if (p2)
>  				*p2 = 0;
> +			if (*--p2 == '\r')
> +				*p2 = 0;

... but if p2 is NULL ... 

so:
			if (p2) {
				*p2 = 0;
				if (*--p2 == '\r')
					*p2 = 0;
			}

but maybe it'd be better to do ...

			if (p2) {
				*p2-- = 0;
				if (*p2 == '\r')
					*p2 = 0;
			}
