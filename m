Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319231AbSIFPvi>; Fri, 6 Sep 2002 11:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319229AbSIFPvi>; Fri, 6 Sep 2002 11:51:38 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:5644 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S319224AbSIFPvf>;
	Fri, 6 Sep 2002 11:51:35 -0400
Date: Fri, 6 Sep 2002 18:07:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stuart MacDonald <stuartm@connecttech.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Temporary menuconfig file not removed by make mrproper
Message-ID: <20020906180740.A1524@mars.ravnborg.org>
Mail-Followup-To: Stuart MacDonald <stuartm@connecttech.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <027901c255b8$d3029360$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <027901c255b8$d3029360$294b82ce@connecttech.com>; from stuartm@connecttech.com on Fri, Sep 06, 2002 at 11:19:42AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 11:19:42AM -0400, Stuart MacDonald wrote:
> linux/scripts/lxdialog/lxtemp.c was left behind after hitting <ctrl-c>
> during a make menuconfig. clean, distclean and mrproper all failed to
> remove it.
Attached patch fixes this.

> Not sure how this could be handled for the general case; is there a
> standard "this is a temporary file" tag that could be used so that
> clean/mrproper would catch arbitrary temporary files? ie lxtemp~~.c or
> similar.
In the top-level Makefile there is an ugly long list of generated files,
which is removed upon make clean & make mrproper.
I would like to get rid of that one, and build it up when the files are
generated. Later...

	Sam

===== Makefile 1.3 vs edited =====
--- 1.3/scripts/lxdialog/Makefile	Thu Aug 15 21:20:48 2002
+++ edited/Makefile	Fri Sep  6 18:04:11 2002
@@ -40,4 +40,4 @@
 	fi
 
 mrproper:
-	@rm -f core $(host-progs) $(lxdialog-objs) ncurses
+	@rm -f core $(host-progs) $(lxdialog-objs) lxtemp.c a.out
