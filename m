Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261556AbSJURg4>; Mon, 21 Oct 2002 13:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261569AbSJURgz>; Mon, 21 Oct 2002 13:36:55 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:35334 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261556AbSJURgV>;
	Mon, 21 Oct 2002 13:36:21 -0400
Date: Mon, 21 Oct 2002 19:42:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Khalid Aziz <khalid@fc.hp.com>
Cc: linux-kernel@vger.kernel.org, khalid@hp.com
Subject: Re: [PATCH] Retrieve configuration information from kernel
Message-ID: <20021021194221.A1817@mars.ravnborg.org>
Mail-Followup-To: Khalid Aziz <khalid@fc.hp.com>,
	linux-kernel@vger.kernel.org, khalid@hp.com
References: <E183g5n-0004dC-00@lyra.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E183g5n-0004dC-00@lyra.fc.hp.com>; from khalid@fc.hp.com on Mon, Oct 21, 2002 at 11:11:51AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 11:11:51AM -0600, Khalid Aziz wrote:

I like the concept.

Few comments:

Touching all defconfigs is not good. Try to limit the impact of the patch.
People just have to press return two more times when running oldconfig.

> diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/kernel/Makefile linux-2.5.44-ikconfig/kernel/Makefile
>  include $(TOPDIR)/Rules.make
> +
> +$(obj)/ikconfig.h: $(TOPDIR)/scripts/mkconfigs $(TOPDIR)/.config $(TOPDIR)/Makefile
> +	chmod 755 $(TOPDIR)/scripts/mkconfigs
> +	$(TOPDIR)/scripts/mkconfigs $(TOPDIR)/.config $(TOPDIR)/Makefile > $(obj)/ikconfig.h
> +
> +$(obj)/configs.o: $(obj)/ikconfig.h $(obj)/configs.c \
> +		$(TOPDIR)/include/linux/version.h \
> +		$(TOPDIR)/include/linux/compile.h
Please avoid using $(TOPDIR)
The build is running from root of the kernel tree anyway, so it is nor required.
Use $(CONFIG_SHELL) when executing scripts, to avoid the necessity to have the executable
bit set.

	Sam
