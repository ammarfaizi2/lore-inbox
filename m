Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSKHSa6>; Fri, 8 Nov 2002 13:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSKHSa6>; Fri, 8 Nov 2002 13:30:58 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:13833 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261847AbSKHSa5>;
	Fri, 8 Nov 2002 13:30:57 -0500
Date: Fri, 8 Nov 2002 19:36:44 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: kconfig: Generate prerequisites
Message-ID: <20021108183644.GA2992@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman.

During the 2.5.3x versions of the kernel there were a check
that checked all Config.in files, and if anyone were newer than
.config then the user were requested to run make oldconfig.

Could we achieve something similar with kconfig?
The most simple form would be that kconfig when run like "conf -p"
would spit out all Kconfig files used by the current configuration.

Example:
conf -p arch/i386/Kconfig
arch/i386/Kconfig \
net/Kconfig \
drivers/Kconfig

The check could be made in kconfig as well which should speed up
things. No need for make to stat the same file as Kconfig already
have stat'ed. From a speed persepctive I like this version best.

The reason why the check were removed in 2.5.4x was that it took several
seconds on a fresh tree before make started doing something useful.

I do not expect kconfig to be as slow as a find over the full tree with
cold caches.

	Sam
