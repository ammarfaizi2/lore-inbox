Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280307AbRJaRJM>; Wed, 31 Oct 2001 12:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280306AbRJaRJC>; Wed, 31 Oct 2001 12:09:02 -0500
Received: from 158-VALL-X6.libre.retevision.es ([62.83.214.158]:1920 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S280309AbRJaRIo>; Wed, 31 Oct 2001 12:08:44 -0500
Date: Wed, 31 Oct 2001 18:12:13 +0100
From: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>
To: Robert Love <rml@tech9.net>
Cc: Sven Vermeulen <sven.vermeulen@rug.ac.be>, torvalds@transmeta.com,
        Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre3: some compilerwarnings...
Message-ID: <20011031181213.A411@ragnar-hojland.com>
In-Reply-To: <20011027185158.A5848@Zenith.starcenter> <1004202984.3274.53.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <1004202984.3274.53.camel@phantasy>; from rml@tech9.net on Sat, Oct 27, 2001 at 01:16:23PM -0400
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2001 at 01:16:23PM -0400, Robert Love wrote:
> On Sat, 2001-10-27 at 12:51, Sven Vermeulen wrote:
> > A little grep on the stdout/stderr of "make bzImage":
> 
> You can't do much about unused variables because, as you suggested, they

May I suggest the following?

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."


--- linux-2.4.13/arch/i386/kernel/dmi_scan.c.O	Wed Oct 31 18:03:20 2001
+++ linux-2.4.13/arch/i386/kernel/dmi_scan.c	Wed Oct 31 18:06:21 2001
@@ -190,6 +190,7 @@ struct dmi_blacklist
  *	corruption problems
  */ 
  
+static __init int disable_ide_dma(struct dmi_blacklist *d) __attribute__ ((unused));
 static __init int disable_ide_dma(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_BLK_DEV_IDE
--- linux-2.4.13/drivers/parport/parport_pc.c.O	Wed Oct 31 17:59:16 2001
+++ linux-2.4.13/drivers/parport/parport_pc.c	Wed Oct 31 18:09:14 2001
@@ -91,7 +91,7 @@ static struct superio_struct {	/* For Su
 } superios[NR_SUPERIOS] __devinitdata = { {0,},};
 
 static int user_specified __devinitdata = 0;
-static int verbose_probing;
+static int verbose_probing __attribute__ ((unused));
 static int registered_parport;
 
 /* frob_control, but for ECR */
@@ -1756,6 +1756,7 @@ static int __devinit parport_PS2_support
 	return ok;
 }
 
+static int __devinit parport_ECP_supported(struct parport *pb) __attribute__ ((unused));
 static int __devinit parport_ECP_supported(struct parport *pb)
 {
 	int i;
--- linux-2.4.13/fs/super.c.O	Wed Oct 31 18:00:57 2001
+++ linux-2.4.13/fs/super.c	Wed Oct 31 18:01:18 2001
@@ -1060,7 +1060,7 @@ mount_it:
 	vfsmnt->mnt_root = dget(sb->s_root);
 	bdput(bdev); /* sb holds a reference */
 
-attach_it:
+attach_it:  __attribute__ ((unused))
 	root_nd.mnt = root_vfsmnt;
 	root_nd.dentry = root_vfsmnt->mnt_sb->s_root;
 	graft_tree(vfsmnt, &root_nd);
--- linux-2.4.13/kernel/exec_domain.c.O	Wed Oct 31 17:58:03 2001
+++ linux-2.4.13/kernel/exec_domain.c	Wed Oct 31 17:58:48 2001
@@ -77,7 +77,7 @@ static struct exec_domain *
 lookup_exec_domain(u_long personality)
 {
 	struct exec_domain *	ep;
-	char			buffer[30];
+	char			buffer[30] __attribute__ ((unused));
 	u_long			pers = personality(personality);
 		
 	read_lock(&exec_domains_lock);
