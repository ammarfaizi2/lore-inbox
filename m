Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279556AbRKGKCR>; Wed, 7 Nov 2001 05:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279615AbRKGKCJ>; Wed, 7 Nov 2001 05:02:09 -0500
Received: from gate.mesa.nl ([194.151.5.70]:20238 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S279556AbRKGKB5>;
	Wed, 7 Nov 2001 05:01:57 -0500
Date: Wed, 7 Nov 2001 11:01:41 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Stephane Jourdois <stephane@tuxfinder.org>
Cc: Massimo Dal Zotto <dz@cs.unitn.it>, LKLM <linux-kernel@vger.kernel.org>,
        Juri Haberland <juri@koschikode.com>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
Message-ID: <20011107110141.C29983@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <20011105231759.02B541195E@a.mx.spoiled.org> <200111061645.RAA02115@fandango.cs.unitn.it> <20011107104405.A3168@emeraude.kwisatz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011107104405.A3168@emeraude.kwisatz.net>; from stephane@tuxfinder.org on Wed, Nov 07, 2001 at 10:44:05AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe this is better:

diff -u i8kutils-1.2.orig/i8kbuttons.c i8kutils-1.2/i8kbuttons.c
--- i8kutils-1.2.orig/i8kbuttons.c      Tue Nov  6 20:07:27 2001
+++ i8kutils-1.2/i8kbuttons.c   Tue Nov  6 20:11:19 2001
@@ -53,15 +53,17 @@

     DPRINTF("exec_cmd: %s\n", cmd);

     if ((rc=fork()) < 0) {
        perror("fork failed");
        return;
     }
 
     if (rc == 0) {
        execl("/bin/sh", "sh", "-c", cmd, NULL);
        exit(0);
     }
+    else
+       wait(&rc);
 }
 
It get rid of the zombies and allows only one setmixer/auimix command to be
active at a time...


On Wed, Nov 07, 2001 at 10:44:05AM +0100, Stephane Jourdois wrote:
> On Tue, Nov 06, 2001 at 05:45:13PM +0100, Massimo Dal Zotto wrote:
> > I have released version 1.2 of the driver. It contains Stephane's patches
> > for the I8100, a new i8kmon and some documentation. You can download from:
> >     http://www.debian.org/~dz/i8k/
> 
> Hello,
> 
> Here is my patch to i8kutils-1.2 :
> 
> ======
> diff -u i8kutils-1.2.orig/i8kbuttons.c i8kutils-1.2/i8kbuttons.c
> --- i8kutils-1.2.orig/i8kbuttons.c      Tue Nov  6 20:07:27 2001
> +++ i8kutils-1.2/i8kbuttons.c   Tue Nov  6 20:11:19 2001
> @@ -53,15 +53,7 @@
> 
>      DPRINTF("exec_cmd: %s\n", cmd);
> 
> -    if ((rc=fork()) < 0) {
> -       perror("fork failed");
> -       return;
> -    }
> -
> -    if (rc == 0) {
> -       execl("/bin/sh", "sh", "-c", cmd, NULL);
> -       exit(0);
> -    }
> +    system(cmd);
>  }
>  
>  static int
> ======
> 
> Without that, I get as much zombies processes as I have pressed the
> volume buttons :-) I know system() is not great, but as security is not
> a problem here...
> I use debian/sid, and aumix as the mixer.
> 
> 
> Now a fundamental question :
> Does the load of the i8k module inhibits the fans start ? I can see my
> processor temp increasing (I saw 80°C ...) without the fans start. Then
> I started i8kmon to avoid an explosion. If the modules inhibits material
> protections, then if that can be modified, it would be great ; if not,
> i8kmon needs to get included in the kernel as a daemon. The i8kmon
> should be a funny tool, not a system critical tool.
> 
> Also, I couldn't understand why sometimes the left fan is printed on red
> color in i8kmon...
> 
> 
> Thank you,
> 
> 	Stephane
> 
> 
> -- 
>  ///  Stephane Jourdois        	/"\  ASCII RIBBON CAMPAIGN \\\
> (((    Ingénieur développement 	\ /    AGAINST HTML MAIL    )))
>  \\\   6, av. de la Belle Image	 X                         ///
>   \\\  94440 Marolles en Brie  	/ \    +33 6 8643 3085    ///



-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
