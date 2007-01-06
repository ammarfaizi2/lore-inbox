Return-Path: <linux-kernel-owner+w=401wt.eu-S932098AbXAFTUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbXAFTUe (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbXAFTUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:20:34 -0500
Received: from moutng.kundenserver.de ([212.227.126.179]:60175 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbXAFTUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:20:33 -0500
From: Torsten Kaiser <tk13@bardioc.dyndns.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] sysrq: showBlockedTasks is sysrq-W
Date: Sat, 6 Jan 2007 20:19:29 +0100
User-Agent: KMail/1.9.5
Cc: Olaf Hering <olaf@aepfle.de>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
References: <20070105110628.5f1e487d.rdunlap@xenotime.net> <20070105193605.GA14592@aepfle.de> <20070106102531.29ce662c.randy.dunlap@oracle.com>
In-Reply-To: <20070106102531.29ce662c.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701062019.29974.tk13@bardioc.dyndns.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:22445e7a21522a805aae47a273aa1695
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 January 2007 19:25, Randy Dunlap wrote:
> On Fri, 5 Jan 2007 20:36:05 +0100 Olaf Hering wrote:
> >
> > Weird, who failed to run this command before adding new stuff?!
> > find * -type f -print0 | xargs -0 env -i grep -nw register_sysrq_key
> >
> > sysrq x is for xmon, see arch/powerpc/xmon/xmon.c
> > Better switch the new stuff to 'z' or 'w'

Also used: 
* c for kexec/crashdump and emac (drivers/net/ibm_emac/ibm_emac_debug.c)
* g for KGDB on ppc

> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> SysRq showBlockedTasks is not done via B or T, it's done via W,
> so put that in the Help message.
>
> It was previously done via X, but X is already used for Xmon
> on powerpc platforms and this collision needs to be avoided.

> @@ -342,8 +342,8 @@ static struct sysrq_key_op *sysrq_key_ta
>  	&sysrq_mountro_op,		/* u */
>  	/* May be assigned at init time by SMP VOYAGER */
>  	NULL,				/* v */

Nice marker that v is in use.

> -	NULL,				/* w */
> -	&sysrq_showstate_blocked_op,	/* x */
> +	&sysrq_showstate_blocked_op,	/* w */
> +	NULL,				/* x */

Wouldn't it be better to also put an marker for xmon here?
And marker for 'c' and 'g' (maybe even 'h')?

>  	NULL,				/* y */
>  	NULL				/* z */
>  };

Also Documentation/sysrq.txt is not uptodate.

It is missing c (emac meaning), d (lockdep), n (un-RT), q (timer), w 
(blocked) and x (xmon), but is documenting 'l' with no longer seems to be 
implemented.

Torsten
