Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268892AbUJPVlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268892AbUJPVlq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 17:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268899AbUJPVlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 17:41:45 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:50246 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268894AbUJPVlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 17:41:18 -0400
Date: Sun, 17 Oct 2004 01:41:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
Message-ID: <20041016234117.GC15006@mars.ravnborg.org>
Mail-Followup-To: Esben Nielsen <simlo@phys.au.dk>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20041016210231.GA14939@elte.hu> <Pine.OSF.4.05.10410162305590.11899-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10410162305590.11899-100000@da410.ifa.au.dk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 11:15:33PM +0200, Esben Nielsen wrote:
> Hi,
>  I have compile error when I use the make O= option: usr/initramfs_list
> doesn't exist. This doesn't occur in pure 2.6.8.1 or 2.6.9-rc4 but does  
> occur in 2.6.9-rc4-mm1.
> 
> Esben
> 
> Here is a fix (the build seems not to be broken with or without O=)
> 
> --- linux-2.6.9-rc4-mm1-RT-U4/usr/Makefile.orig 2004-10-16
> 19:39:46.000000000 +0200
> +++ linux-2.6.9-rc4-mm1-RT-U4/usr/Makefile      2004-10-16
> 23:04:13.661382082 +0200
> @@ -35,7 +35,10 @@
>           echo 'scripts/gen_initramfs_list.sh $(CONFIG_INITRAMFS_SOURCE) > $@'; \
>         else \
>           echo 'echo Using shipped $@'; \
> -       fi)
> +          if [ $(KBUILD_SRC)!="" ]; then \
> +            cp -f $(KBUILD_SRC)/usr/initramfs_list ./usr/initramfs_list; \
> +          fi; \
> +        fi)

The above error is from -mm and not part of Ingo's patch.
The better fix is to prefix $(CONFIG_INITRAMFS_SOURCE) with $(srctree)/

	Sam
