Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUCUVWl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 16:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUCUVWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 16:22:41 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:5045 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261300AbUCUVWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 16:22:39 -0500
Message-ID: <405E07A1.9000609@free.fr>
Date: Sun, 21 Mar 2004 22:22:41 +0100
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-mm1 does not boot. 2.6.5-rc1-mm2 + small fix from axboe
 was fine
References: <405DFA02.8090504@free.fr> <Pine.LNX.4.58.0403211555110.28727@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0403211555110.28727@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

> How about the following patch?

Part of this does not apply...

> --- linux-2.6.5-rc2-mm1/init/main.c    21 Mar 2004 17:02:18 -0000    
> 1.1.1.1
> +++ linux-2.6.5-rc2-mm1/init/main.c    21 Mar 2004 20:54:19 -0000
> @@ -586,8 +586,8 @@ static int free_initmem_on_exec_helper(v
>     char c;
> 
>     sys_close(fd[1]);
> -    sys_read(fd[0], &c, 1);
> -    free_initmem();
> +    if (sys_read(fd[0], &c, 1) > 0)
> +        free_initmem();
>     return 0;
> }

This part does apply. I made it by hand...

> 
> @@ -596,7 +596,7 @@ static void free_initmem_on_exec(void)
>     int fd[2];
> 
>     do_pipe(fd);
> -       kernel_thread(free_initmem_on_exec_helper, &fd, SIGCHLD);
> +    kernel_thread(free_initmem_on_exec_helper, &fd, SIGCHLD);

Cosmetic change but yes...

> 
>     sys_dup2(fd[1], 255);   /* to get it out of the way */
>     sys_close(fd[0]);
> @@ -643,6 +643,7 @@ static int init(void * unused)
>     run_init_process("/init");
> 
>     prepare_namespace();
> +    free_initmem();

This is already done (plus a comment....)???

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



