Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVHXVGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVHXVGT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVHXVGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:06:19 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:64662 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932218AbVHXVGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:06:19 -0400
Message-Id: <200508242106.j7OL61QK010645@laptop11.inf.utfsm.cl>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 3/3] exterminate strtok - usr/gen_init_cpio.c 
In-Reply-To: Message from Jesper Juhl <jesper.juhl@gmail.com> 
   of "Wed, 24 Aug 2005 21:08:53 +0200." <200508242108.53198.jesper.juhl@gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 24 Aug 2005 17:06:01 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 24 Aug 2005 17:06:01 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Convert strtok() use to strsep() in usr/gen_init_cpio.c

This is userland code...

No, I'm not looking it over carfully, just a fast look over.

> I've compile tested this patch and it compiles fine.

You should be able ti test it then.

> I build a 2.6.13-rc6-mm2 kernel with the patch applied without problems, and
> the resulting kernel boots and runs just fine (using it right now).
> But despite this basic testing it would still be nice if someone would 
> double-check that I haven't made some silly mistake that would break some 
> other setup than mine.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  gen_init_cpio.c |   31 ++++++++++++++++++++++---------
>  1 files changed, 22 insertions(+), 9 deletions(-)
> 
> --- linux-2.6.13-rc6-mm2-orig/usr/gen_init_cpio.c	2005-06-17 21:48:29.000000000 +0200
> +++ linux-2.6.13-rc6-mm2/usr/gen_init_cpio.c	2005-08-24 18:58:21.000000000 +0200
> @@ -438,7 +438,7 @@ struct file_handler file_handler_table[]
>  int main (int argc, char *argv[])
>  {
>  	FILE *cpio_list;
> -	char line[LINE_SIZE];
> +	char *line, *ln;

No need for this, there is no particular stack frugality requirement with
user code.

>  	char *args, *type;
>  	int ec = 0;
>  	int line_nr = 0;
> @@ -455,7 +455,14 @@ int main (int argc, char *argv[])
>  		exit(1);
>  	}
>  
> -	while (fgets(line, LINE_SIZE, cpio_list)) {
> +	ln = malloc(LINE_SIZE);

Ditto.

[...]

> -		if ('\n' == *type) {
> +		if (!*type || '\n' == *type) {

Redundant. If *type == '\n', it is certainly != 0.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
