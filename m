Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268088AbTBRW7e>; Tue, 18 Feb 2003 17:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268090AbTBRW7d>; Tue, 18 Feb 2003 17:59:33 -0500
Received: from 117.catv45.aar01.lan.ch ([212.60.45.117]:28179 "EHLO
	bolli.homeip.net") by vger.kernel.org with ESMTP id <S268088AbTBRW7b> convert rfc822-to-8bit;
	Tue, 18 Feb 2003 17:59:31 -0500
Cc: Beat Bolli <bbolli@ymail.ch>, linux-kernel@vger.kernel.org
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=iso-8859-1
Date: Wed, 19 Feb 2003 00:09:17 +0100
From: bbolli@ymail.ch (Beat Bolli)
In-Reply-To: <Pine.LNX.4.44.0302181141470.24975-100000@chaos.physics.uiowa.edu>
Message-ID: <20030218230917.GA29938@bolli.homeip.net>
Mime-Version: 1.0
References: <20030218081203.GA20989@bolli.homeip.net> <Pine.LNX.4.44.0302181141470.24975-100000@chaos.physics.uiowa.edu>
Subject: Re: kbuild: error with parallel make and modules
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
User-Agent: Mutt/1.5.3i
X-AntiVirus: OK! AntiVir MailGate Version 2.0.0.6
	 at gw.bolli.homeip.net has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 11:43:25AM -0600, Kai Germaschewski wrote:
> On Tue, 18 Feb 2003, Beat Bolli wrote:
> 
> > It seems like scripts/Makefile.modpost starts before vmlinux has finished linking.
> 
> Right, that's because for the non modversions case, I don't want to force 
> people to build a vmlinux first when they only want modules. So I'm using 
> vmlinux if it's there, otherwise not. That goes wrong when vmlinux is just 
> being built ;-(
> 
> This should fix it - could you test it?
> 
> --Kai
> 
> ===== Makefile 1.378 vs edited =====
> --- 1.378/Makefile	Sun Feb 16 09:18:01 2003
> +++ edited/Makefile	Tue Feb 18 11:37:19 2003
> @@ -506,7 +506,7 @@
>  #	Build modules
>  
>  .PHONY: modules
> -modules: $(SUBDIRS) $(if $(CONFIG_MODVERSIONS),vmlinux)
> +modules: $(SUBDIRS) $(if $(KBUILD_BUILTIN),vmlinux)
>  	@echo '  Building modules, stage 2.';
>  	$(Q)$(MAKE) -rR -f scripts/Makefile.modpost
>  

OK, that did it. Now the link step finished before modpost is called.

Thanks!

Beat Bolli

-- 
mail: `echo '<bNObolli@ymaSPilAM.ch>' | sed -e 's/[A-S]//g'`
pgp:  0x506A903A; 49D5 794A EA77 F907 764F D89E 304B 93CF 506A 903A
icbm: 47° 02' 43.0" N, 07° 16' 17.5" E (WGS84)
