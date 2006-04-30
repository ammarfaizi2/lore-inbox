Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWD3XH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWD3XH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 19:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWD3XH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 19:07:56 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:2785 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP
	id S1750756AbWD3XHz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 19:07:55 -0400
Date: Mon, 01 May 2006 01:07:14 +0200
Message-Id: <1095249048@web.de>
MIME-Version: 1.0
From: devzero@web.de
To: Arjan van de Ven <arjan@infradead.org>, Nix <nix@esperi.org.uk>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: =?iso-8859-15?Q?Re:_another_kconfig_target_for_building_monolithic_ker?=
 =?iso-8859-15?Q?nel_(for_security)_=3F?=
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello !

thanks for help -  i found that there seems another way for securing /dev/{k}mem (at least in recent kernels) - the docomentation for the "BSD Secure Levels Linux Security Module" (at  Documentation/seclvl.txt) tells:

Level 1 (Default):
- /dev/mem and /dev/kmem are read-only
- IMMUTABLE and APPEND extended attributes, if set, may not be unset
- Cannot load or unload kernel modules
- Cannot write directly to a mounted block device
- Cannot perform raw I/O operations
- Cannot perform network administrative tasks
- Cannot setuid any file

so - no need for compiling a static/monolithic kernel anymore !?

regards
roland





> -----Ursprüngliche Nachricht-----
> Von: Nix <nix@esperi.org.uk>
> Gesendet: 30.04.06 12:57:49
> An: Arjan van de Ven <arjan@infradead.org>
> CC: davej@redhat.com, linux-kernel@vger.kernel.org
> Betreff: Re: another kconfig target for building monolithic kernel (for security) ?


> On 29 Apr 2006, Arjan van de Ven prattled cheerily:
> > On Sat, 2006-04-29 at 12:43 -0400, Dave Jones wrote:
> >> On Sat, Apr 29, 2006 at 03:03:55PM +0200, devzero@web.de wrote:
> >> 
> >>  > i want to harden a linux system (dedicated root server on the internet) by recompiling the kernel without support for lkm (to prevent installation of lkm based rootkits etc)
> >> 
> >> Loading modules via /dev/kmem is trivial thanks to a bunch of tutorials and
> >> examples on the web, so this alone doesn't make life that much more difficult for attackers.
> > 
> > /dev/kmem should be a config option too though
> 
> Yeah, but in practice this should work (somewhat old patch, should still
> apply):
> 
> diff -durN 2.6.14-seal-orig/include/linux/capability.h 2.6.14-seal/include/linux/capability.h
> --- 2.6.14-seal-orig/include/linux/capability.h	2005-10-29 15:15:00.000000000 +0100
> +++ 2.6.14-seal/include/linux/capability.h	2005-10-29 15:25:48.000000000 +0100
> @@ -311,7 +311,7 @@
>  
>  #define CAP_EMPTY_SET       to_cap_t(0)
>  #define CAP_FULL_SET        to_cap_t(~0)
> -#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
> +#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP) & ~CAP_TO_MASK(CAP_SYS_RAWIO))
>  #define CAP_INIT_INH_SET    to_cap_t(0)
>  
>  #define CAP_TO_MASK(x) (1 << (x))
> 
> > (and /dev/mem should get the filter patch that fedora has ;-) 
> 
> Agreed.
> 
> -- 
> `On a scale of 1-10, X's "brokenness rating" is 1.1, but that's only
>  because bringing Windows into the picture rescaled "brokenness" by
>  a factor of 10.' --- Peter da Silva


_______________________________________________________________
SMS schreiben mit WEB.DE FreeMail - einfach, schnell und
kostenguenstig. Jetzt gleich testen! http://f.web.de/?mc=021192

