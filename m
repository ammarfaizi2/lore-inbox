Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWAQADg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWAQADg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 19:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWAQADf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 19:03:35 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:21949 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751305AbWAQADf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 19:03:35 -0500
Message-Id: <200601161916.k0GJGm7T002751@laptop11.inf.utfsm.cl>
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.15: Filesystem capabilities 0.16 
In-Reply-To: Message from Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de> 
   of "Sat, 14 Jan 2006 22:21:50 BST." <8764om8pzl.fsf@goat.bogus.local> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Mon, 16 Jan 2006 16:16:48 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 16 Jan 2006 21:03:31 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de> wrote:
> This patch implements filesystem capabilities. It allows to run
> privileged executables without the need for suid root.
> 
> Changes:
> - updated to 2.6.15
> 
> This patch is available at:
> <http://www.olafdietsche.de/linux/capability/>
> 
> Regards, Olaf.
> 
> diff -urN a/fs/Kconfig b/fs/Kconfig
> --- a/fs/Kconfig	Wed Jan  4 22:01:06 2006
> +++ b/fs/Kconfig	Sun Jan  8 15:12:25 2006
> @@ -1209,6 +1209,69 @@
>  	  It's currently broken, so for now:
>  	  answer N.
>  
> +config FS_CAPABILITIES
> +	bool "Filesystem capabilities (Experimental)"
> +	depends on EXPERIMENTAL
> +	default n
> +	help
> +	  This implementation is likely _not_ POSIX compatible.
> +
> +	  If you say Y here, you will be able to grant selective privileges to
> +	  executables on a needed basis. This means for some executables, there
> +	  is no need anymore to run as root or as a suid root binary.
> +
> +	  For example, you may drop the SUID bit from ping and grant the
> +	  CAP_NET_RAW capability:
> +	  # chmod u-s /bin/ping
> +	  # chcap cap_net_raw=ep /bin/ping

Why the cap_ part? It should be enough to say, e.g.

    chcap net-raw=ep /bin/ping

('_' has SHIFT, normally... '-' is easier to type)

> +
> +	  Another use would be to run system daemons with their own uid:
> +	  # chcap cap_net_bind_service=ei /usr/sbin/named
> +	  This sets the effective and inheritable capabilities of named.
> +
> +	  In your startup script:
> +	  inhcaps cap_net_bind_service=i bind:bind /usr/sbin/named

AFAIU, the =i implies inherited, why another command to set that?

Can't comment on the rest.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
