Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbUDBVe2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbUDBVdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:33:22 -0500
Received: from gprs214-45.eurotel.cz ([160.218.214.45]:6528 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264179AbUDBVcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:32:08 -0500
Date: Fri, 2 Apr 2004 22:48:55 +0200
From: Pavel Machek <pavel@suse.cz>
To: "La Monte H.P. Yarroll" <piggy@timesys.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Fix sys_time() to get subtick correction from the new xtim
Message-ID: <20040402204855.GH195@elf.ucw.cz>
References: <405ED918.2010803@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405ED918.2010803@timesys.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> --- lkml/arch/ia64/ia32/sys_ia32.c~fix-all-time-sys_time        
> 2004-03-16 10:01:23.000000000 -0500
> +++ lkml-piggy/arch/ia64/ia32/sys_ia32.c        2004-03-16 
> 10:01:23.000000000 -0500
> @@ -1678,10 +1678,11 @@ asmlinkage long
> sys32_time (int *tloc)
> {
>        int i;
> +       struct timeval tv;
> +
> +       do_gettimeofday(&tv);
> +       i = tv.tv_sec;
> 
> -       /* SMP: This is fairly trivial. We grab CURRENT_TIME and
> -          stuff it to user space. No side effects */
> -       i = get_seconds();
>        if (tloc) {
>                if (put_user(i, tloc))
>                        i = -EFAULT;

This patch likely suffered some whitespace damage, and you probably
want to correct tabs vs. spacing in indentation.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
