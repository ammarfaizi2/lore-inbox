Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266203AbUFPHLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266203AbUFPHLZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 03:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbUFPHLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 03:11:25 -0400
Received: from ipx-98-250-190-80.ipxserver.de ([80.190.250.98]:19212 "EHLO
	taytron.net") by vger.kernel.org with ESMTP id S266201AbUFPHLP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 03:11:15 -0400
From: Florian Schirmer <jolt@tuxbox.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] [STACK] >3k call path in ide
Date: Wed, 16 Jun 2004 09:11:11 +0200
User-Agent: KMail/1.6.1
Cc: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       akpm <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20040609122921.GG21168@wohnheim.fh-wedel.de> <20040615163445.6b886383.rddunlap@osdl.org>
In-Reply-To: <20040615163445.6b886383.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406160911.11985.jolt@tuxbox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>  failed:
>      ide_release(link);
>      link->state &= ~DEV_CONFIG_PENDING;
>
> +    /* memory allocation errors */
> +err_cisparse:
> +    kfree(cfginfo);
> +err_cfginfo:
> +    kfree(def_cte);
> +err_def_cte:
> +    kfree(tbuf);
> +err_tbuf:
> +    printk(KERN_NOTICE "ide-cs: ide_config failed memory allocation\n");
> +    goto failed;
>  } /* ide_config */

Huh? This will either leak memory (non alloc error case) or deadlock (mem 
alloc error case). I'm missing something?

Best,
   Florian
