Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267712AbTGTTCx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 15:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267770AbTGTTCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 15:02:53 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:7610 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S267712AbTGTTCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 15:02:50 -0400
Date: Sun, 20 Jul 2003 21:17:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org, torvalds@osdl.com
Subject: Re: [PATCH] Compile fix for suspend.c
Message-ID: <20030720191733.GA292@elf.ucw.cz>
References: <20030720092314.GA11395@himi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030720092314.GA11395@himi.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> kernel/suspend.c fails to build as of a bk pull at about 08:00 UTC,
> with redefinitions of _text.

You were right; I can see the error, too. And your fix is right, since
current suspend.c no longer uses these sections. (It still uses
__nosave_begin/_end, through).
								Pavel

> ===== kernel/suspend.c 1.42 vs edited =====
> --- 1.42/kernel/suspend.c       Sat May  3 04:16:11 2003
> +++ edited/kernel/suspend.c     Sun Jul 20 19:14:48 2003
> @@ -83,7 +83,6 @@
>  #define ADDRESS2(x) __ADDRESS(__pa(x))         /* Needed for x86-64 where some pages are in m
> emory twice */
>  
>  /* References to section boundaries */
> -extern char _text, _etext, _edata, __bss_start, _end;
>  extern char __nosave_begin, __nosave_end;
>  
>  extern int is_head_of_free_region(struct page *);
> 



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
