Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWD3Mcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWD3Mcm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 08:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWD3Mcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 08:32:42 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:22929 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP
	id S1750796AbWD3Mcl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 08:32:41 -0400
Date: Sun, 30 Apr 2006 14:31:11 +0200
Message-Id: <1094806367@web.de>
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

"Unfortunately, disabling /dev/mem will break many things, including X and potentially many other user-space programs"
(-> http://lwn.net/2001/0419/security.php3 )

"The /dev/mem and /dev/kmem character special files provide access to a pseudo device driver that allows read and write access to system memory or I/O address space. Typically, these special files are used by operating system utilities and commands (such as sar, iostat, and vmstat) to obtain status and statistical information about the system" (ok, this is for AIX, does this apply for linux, too? -> http://publib.boulder.ibm.com/infocenter/pseries/v5r3/index.jsp?topic=/com.ibm.aix.doc/files/aixfiles/mem.htm )


mhhh - while studying this i`m getting unsure if disabling /dev/mem and /dev/kmem is a really good idea - i can live without X 
on my server, but what else also gets broken? i think i cannot live without important monitoring utilities like vmstat or sar on my server(s).

there is a nice article at LWN at http://lwn.net/Articles/147901/

maybe there is a more comprehensive list of applications which need /dev/{k}mem for proper operation or there is a method  to determine this in a reliable way (e.g. by scanning all binaries on mystem somehow) ?

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

