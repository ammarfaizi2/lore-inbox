Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261630AbSJMUPX>; Sun, 13 Oct 2002 16:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbSJMUPW>; Sun, 13 Oct 2002 16:15:22 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:15118 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261630AbSJMUPW>;
	Sun, 13 Oct 2002 16:15:22 -0400
Date: Sun, 13 Oct 2002 22:21:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.42 (-mm): AIC7XXX_BUILD_FIRMWARE=y NO go.
Message-ID: <20021013222102.A28354@mars.ravnborg.org>
Mail-Followup-To: =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <200210130001.47484.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210130001.47484.Dieter.Nuetzel@hamburg.de>; from Dieter.Nuetzel@hamburg.de on Sun, Oct 13, 2002 at 12:01:47AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 12:01:47AM +0200, Dieter Nützel wrote:
> make -f drivers/scsi/aic7xxx/Makefile
> drivers/scsi/aic7xxx/aicasm/aicasm -I. -r drivers/scsi/aic7xxx/aic7xxx_reg.h \
>                          -o drivers/scsi/aic7xxx/aic7xxx_seq.h 
> drivers/scsi/aic7xxx/aic7xxx.seq
> aic7xxx.reg: No such file or directory
> drivers/scsi/aic7xxx/aicasm/aicasm: Stopped at file 
> drivers/scsi/aic7xxx/aic7xxx.seq, line 89 - Unable to open input file
> drivers/scsi/aic7xxx/aicasm/aicasm: Removing 
> drivers/scsi/aic7xxx/aic7xxx_seq.h due to error
> drivers/scsi/aic7xxx/aicasm/aicasm: Removing 
> drivers/scsi/aic7xxx/aic7xxx_reg.h due to error
> make[3]: *** [drivers/scsi/aic7xxx/aic7xxx_seq.h] Error 70
> make[2]: *** [drivers/scsi/aic7xxx] Error 2
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2

aicasm is fooled now when the build is made from the top level directory.
This patch fixes the firmware build.

Justin - will you please forward to Linus

	Sam

===== drivers/scsi/aic7xxx/Makefile 1.12 vs edited =====
--- 1.12/drivers/scsi/aic7xxx/Makefile	Wed Jun 19 04:52:38 2002
+++ edited/drivers/scsi/aic7xxx/Makefile	Sun Oct 13 22:13:43 2002
@@ -33,7 +33,7 @@
 $(obj)/aic7xxx_seq.h $(obj)/aic7xxx_reg.h: $(src)/aic7xxx.seq \
 					   $(src)/aic7xxx.reg \
 					   $(obj)/aicasm/aicasm
-	$(obj)/aicasm/aicasm -I. -r $(obj)/aic7xxx_reg.h \
+	$(obj)/aicasm/aicasm -I$(src) -r $(obj)/aic7xxx_reg.h \
 				 -o $(obj)/aic7xxx_seq.h $(src)/aic7xxx.seq
 
 $(obj)/aicasm/aicasm: $(src)/aicasm/*.[chyl]
