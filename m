Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273902AbRJYNdD>; Thu, 25 Oct 2001 09:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273912AbRJYNcy>; Thu, 25 Oct 2001 09:32:54 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:62736 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S273904AbRJYNce>; Thu, 25 Oct 2001 09:32:34 -0400
Message-ID: <3BD8154E.24511282@loewe-komp.de>
Date: Thu, 25 Oct 2001 15:36:14 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strtok --> strsep in framebuffer drivers (part 2)
In-Reply-To: <m15wXDA-007qbNC@smtp.web.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

René Scharfe wrote:
> 
> Hello,
> 
> I just noticed two framebuffer drivers with strtok calls that somehow
> passed below my radar (cscope). Patch below converts them, too. And it
> re-adds "ignore empty tokens" functionalty, which I forgot about the
> last time. Please apply.
> 
> René
> 
> diff -Nur ../linux-2.4.13-pre6/drivers/video/amifb.c ./drivers/video/amifb.c
> --- ../linux-2.4.13-pre6/drivers/video/amifb.c  Tue Oct 23 22:13:43 2001
> +++ ./drivers/video/amifb.c     Tue Oct 23 23:04:03 2001
> @@ -1193,6 +1193,8 @@
>                 return 0;
> 
>         while (this_opt = strsep(&options, ",")) {
> +               if (!*this_opt)
> +                       continue;
>                 if (!strcmp(this_opt, "inverse")) {
>                         amifb_inverse = 1;
>                         fb_invert_cmaps();
> diff -Nur ../linux-2.4.13-pre6/drivers/video/atafb.c ./drivers/video/atafb.c
> --- ../linux-2.4.13-pre6/drivers/video/atafb.c  Fri Sep 14 01:04:43 2001
> +++ ./drivers/video/atafb.c     Tue Oct 23 23:00:59 2001
> @@ -2899,7 +2899,7 @@
>      if (!options || !*options)
>                 return 0;
> 
> -    for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
> +    while (this_opt = strsep(&options, ",")) {
>         if (!*this_opt) continue;
>         if ((temp=get_video_mode(this_opt)))
>                 default_par=temp;
> diff -Nur ../linux-2.4.13-pre6/drivers/video/aty/atyfb_base.c ./drivers/video/aty/atyfb_base.c
> --- ../linux-2.4.13-pre6/drivers/video/aty/atyfb_base.c Tue Oct 23 22:13:43 2001
> +++ ./drivers/video/aty/atyfb_base.c    Tue Oct 23 23:05:24 2001
> @@ -2522,6 +2522,8 @@
>         return 0;
> 
>      while (this_opt = strsep(&options, ",")) {
> +       if (!*this_opt)
> +               continue;
>         if (!strncmp(this_opt, "font:", 5)) {
>                 char *p;
>                 int i;
> diff -Nur ../linux-2.4.13-pre6/drivers/video/aty128fb.c ./drivers/video/aty128fb.c
> --- ../linux-2.4.13-pre6/drivers/video/aty128fb.c       Tue Oct 23 22:13:43 2001
> +++ ./drivers/video/aty128fb.c  Tue Oct 23 23:06:17 2001
> @@ -1614,6 +1614,8 @@
>         return 0;
> 
>      while (this_opt = strsep(&options, ",")) {
> +       if (!*this_opt)
> +           continue;
>         if (!strncmp(this_opt, "font:", 5)) {
>             char *p;
>             int i;
> diff -Nur ../linux-2.4.13-pre6/drivers/video/clgenfb.c ./drivers/video/clgenfb.c
> --- ../linux-2.4.13-pre6/drivers/video/clgenfb.c        Wed Oct 10 00:13:02 2001
> +++ ./drivers/video/clgenfb.c   Tue Oct 23 22:59:38 2001
> @@ -2817,8 +2817,7 @@
>         if (!options || !*options)
>                 return 0;
> 
> -       for (this_opt = strtok (options, ","); this_opt != NULL;
> -            this_opt = strtok (NULL, ",")) {
> +       while (this_opt = strsep (&options, ",")) {
>                 if (!*this_opt) continue;
> 
>                 DPRINTK("clgenfb_setup: option '%s'\n", this_opt);
> diff -Nur ../linux-2.4.13-pre6/drivers/video/cyberfb.c ./drivers/video/cyberfb.c
> --- ../linux-2.4.13-pre6/drivers/video/cyberfb.c        Tue Oct 23 22:13:43 2001
> +++ ./drivers/video/cyberfb.c   Tue Oct 23 23:07:42 2001
> @@ -1023,6 +1023,8 @@
>         }
> 
>         while (this_opt = strsep(&options, ",")) {
> +               if (!*this_opt)
> +                       continue;
>                 if (!strcmp(this_opt, "inverse")) {
>                         Cyberfb_inverse = 1;
>                         fb_invert_cmaps();
> diff -Nur ../linux-2.4.13-pre6/drivers/video/radeonfb.c ./drivers/video/radeonfb.c
> --- ../linux-2.4.13-pre6/drivers/video/radeonfb.c       Tue Oct 23 22:13:43 2001
> +++ ./drivers/video/radeonfb.c  Tue Oct 23 23:09:58 2001
> @@ -538,6 +538,8 @@
>                  return 0;
> 
>         while (this_opt = strsep (&options, ",")) {
> +               if (!*this_opt)
> +                       continue;
>                  if (!strncmp (this_opt, "font:", 5)) {
>                          char *p;
>                          int i;
> diff -Nur ../linux-2.4.13-pre6/drivers/video/retz3fb.c ./drivers/video/retz3fb.c
> --- ../linux-2.4.13-pre6/drivers/video/retz3fb.c        Tue Oct 23 22:13:43 2001
> +++ ./drivers/video/retz3fb.c   Tue Oct 23 23:30:56 2001
> @@ -1349,6 +1349,8 @@
>                 return 0;
> 
>         while (this_opt = strsep(&options, ",")) {
> +               if (!*this_opt)
> +                       continue;
>                 if (!strcmp(this_opt, "inverse")) {
>                         z3fb_inverse = 1;
>                         fb_invert_cmaps();
> diff -Nur ../linux-2.4.13-pre6/drivers/video/riva/fbdev.c ./drivers/video/riva/fbdev.c
> --- ../linux-2.4.13-pre6/drivers/video/riva/fbdev.c     Tue Oct 23 22:13:43 2001
> +++ ./drivers/video/riva/fbdev.c        Tue Oct 23 23:31:33 2001
> @@ -2046,6 +2046,8 @@
>                 return 0;
> 
>         while (this_opt = strsep(&options, ",")) {
> +               if (!*this_opt)
> +                       continue;

NAME
       strsep - extract token from string
[...]
RETURN VALUE
       The strsep() function returns a pointer to the  token,  or
       NULL if delim is not found in stringp.

If strsep returns NULL, and you dereference it -> Oops.


! if (!this_opt)
	continue;
