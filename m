Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267747AbTBRJbl>; Tue, 18 Feb 2003 04:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267749AbTBRJbl>; Tue, 18 Feb 2003 04:31:41 -0500
Received: from [81.80.245.157] ([81.80.245.157]:23263 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S267747AbTBRJbg>; Tue, 18 Feb 2003 04:31:36 -0500
Date: Tue, 18 Feb 2003 10:37:47 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Jeff Garzik <jgarzik@pobox.com>, sam@ravnborg.org,
       kai@tp1.ruhr-uni-bochum.de, greg@kroah.com,
       linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [RFC] klibc for 2.5.59 bk
Message-ID: <20030218093747.GB3980@cedar.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Jeff Garzik <jgarzik@pobox.com>, sam@ravnborg.org,
	kai@tp1.ruhr-uni-bochum.de, greg@kroah.com,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030209125759.GA14981@kroah.com> <Pine.LNX.4.44.0302162057200.5217-100000@chaos.physics.uiowa.edu> <20030217180246.GA26112@mars.ravnborg.org> <1911.212.181.176.76.1045505249.squirrel@www.zytor.com> <3E512BCB.1010000@pobox.com> <1144.62.20.229.212.1045558700.squirrel@www.zytor.com> <3E51FA1C.7060807@pobox.com> <20030218093601.GA3980@cedar.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218093601.GA3980@cedar.alcove-fr>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 10:36:01AM +0100, Stelian Pop wrote:

> > H. Peter Anvin wrote:
> > >However, I can personally vouch for that it's *not* fixed for the main
> > >kernel build as of 2.5.61.
> > 
> > 
> > Well, if I had a Transmeta-powered laptop or handheld, I'm sure that 
> > would be fixed too ;-)
> > 
> > Can you give the attached patch a quick once-over?  It's obvious enough 
> > but I would rather the patch got tested nonetheless.

This is required for 2.4 too. Rediffed and tested, Marcelo please apply.

Stelian.

===== arch/i386/Makefile 1.5 vs edited =====
--- 1.5/arch/i386/Makefile	Sun Feb  2 08:50:07 2003
+++ edited/arch/i386/Makefile	Tue Feb 18 10:03:19 2003
@@ -61,15 +61,16 @@
 endif
 
 ifdef CONFIG_MK6
-CFLAGS += $(shell if $(CC) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6"; else echo "-march=i586"; fi)
+CFLAGS += $(call check_gcc,-march=k6,-march=i586)
 endif
 
 ifdef CONFIG_MK7
-CFLAGS += $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi) 
+CFLAGS += $(call check_gcc,-march=athlon,-march=i686 -malign-functions=4)
 endif
 
 ifdef CONFIG_MCRUSOE
-CFLAGS += -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0
+CFLAGS += -march=i686
+CFLAGS += $(call check_gcc,-falign-functions=0 -falign-jumps=0 -falign-loops=0,-malign-functions=0 -malign-jumps=0 -malign-loops=0)
 endif
 
 ifdef CONFIG_MWINCHIPC6
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
