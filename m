Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271844AbRIMQqk>; Thu, 13 Sep 2001 12:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271836AbRIMQq3>; Thu, 13 Sep 2001 12:46:29 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:14133 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271834AbRIMQqW>; Thu, 13 Sep 2001 12:46:22 -0400
Subject: Re: Linux-2.2.20pre10
From: Robert Love <rml@tech9.net>
To: Willy TARREAU <tarreau@aemiaif.lip6.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15hQTK-0002hd-00@aemiaif.lip6.fr>
In-Reply-To: <E15hQTK-0002hd-00@aemiaif.lip6.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.12.07.08 (Preview Release)
Date: 13 Sep 2001 12:46:39 -0400
Message-Id: <1000399606.23162.22.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-13 at 02:59, Willy TARREAU wrote:
> Robert M. Love pointed out that the command line parse could forget arguments
> if either MAX_INIT_ENVS or MAX_INIT_ARGS were reached, and his patch seems to
> fix it correctly :

I have posted posted this patch multiple times for 2.2 and 2.4, to no
avail -- in fact, it seems no one even thinks this is a bug.

to me, it is pretty clear that hitting MAX_INIT_ENVS _or_ MAX_INIT_ARGS
kills the parse_options loop, when that should not occur until both are
hit -- thus, this patch switches the breaks to continues.

thanks for noticing, I hope it is applied.

> --- linux-2.2.19-wt5-OE/init/main.c     Sat Sep  8 23:11:00 2001
> +++ linux-2.2.19-wt5-OF/init/main.c     Sat Sep  8 23:24:13 2001
> @@ -1292,11 +1292,11 @@
>                  */
>  		if (strchr(line,'=')) {
>  			if (envs >= MAX_INIT_ENVS)
> -                               break;
> +                               continue;
>  			envp_init[++envs] = line;
>   		} else {
>  			if (args >= MAX_INIT_ARGS)
> -                               break;
> +                               continue;
>   			argv_init[++args] = line;
>  		}
>  	}

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

