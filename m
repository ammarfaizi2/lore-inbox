Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290284AbSA3Rts>; Wed, 30 Jan 2002 12:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290253AbSA3Rst>; Wed, 30 Jan 2002 12:48:49 -0500
Received: from 200-VALL-X7.libre.retevision.es ([62.83.213.200]:56589 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S290270AbSA3RsG>; Wed, 30 Jan 2002 12:48:06 -0500
Date: Wed, 30 Jan 2002 04:13:22 +0100
From: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>
To: Vince Weaver <vince@deater.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops on 2.4.17 possibly UMS-DOS related
Message-ID: <20020130041322.A8929@ragnar-hojland.com>
In-Reply-To: <Pine.LNX.4.31.0201291728480.15872-100000@hal.deaternet.vmw>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0201291728480.15872-100000@hal.deaternet.vmw>; from vince@deater.net on Tue, Jan 29, 2002 at 05:36:37PM -0500
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 05:36:37PM -0500, Vince Weaver wrote:
> 
> X oopsed once on me after about a week of uptime, and now whenever I try
> to run "startx" I get the message
> 
> umsdos_lookup_x: tmp/..LINK256 negative after link
> 
> followed by the below oops.
> 
> System is slackware 8.0 with a hand-compiled stock 2.4.17 kernel,
> 64MB RAM, Pentium II 300Mhz, Matrox Millenium II graphics card.
> Filesystem is a 4GB vfat drive with umsdos running on top.  It worked fine
> until this happened... rebooting doesn't help, nor does "umssync" and I
> can't figure out which file is causing the problem (assuming it really is
> a UMS DOS problem, the decoded oops seems a bit odd, but I have made sure
> the system map file is the proper one).


Perhaps this helps?

--- linux-2.4.17/fs/umsdos/dir.c.O	Wed Jan 30 04:08:16 2002
+++ linux-2.4.17/fs/umsdos/dir.c	Wed Jan 30 04:08:43 2002
@@ -537,7 +537,7 @@ out_add:
 	ret = 0;
 
 out_dput:
-	if (dret && dret != dentry)
+	if (!IS_ERR(dret) && dret != dentry)
 		d_drop(dret);
 	dput(dret);
 out:


-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."
