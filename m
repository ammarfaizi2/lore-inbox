Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262365AbSKCT4v>; Sun, 3 Nov 2002 14:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262369AbSKCT4v>; Sun, 3 Nov 2002 14:56:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50187 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262365AbSKCT4u>; Sun, 3 Nov 2002 14:56:50 -0500
Date: Sun, 3 Nov 2002 21:03:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: make clean broken in 2.5.45
Message-ID: <20021103200320.GB21808@atrey.karlin.mff.cuni.cz>
References: <20021101211207.GA238@elf.ucw.cz> <20021102221605.GA14040@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102221605.GA14040@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > make clean; time make bzImage took one minute for me. That's *not*
> > right. rm `find . -name "*.o"` resulted in >5 minutes compilation
> > time.
> I have tried to reproduce this without luck.
> make defconfig
> make
> make clean
> find -name '*.o' did not show any .o files.
> 
> Could you please try to list the .o files that survive a make clean.
> If there are any then I would like to have a copy of .config as well.

Ahha, it was the old qt-detection-problem.

make clean did not clean much:

make -f scripts/Makefile.clean obj=scripts/kconfig
*
* Unable to find the QT installation. Please make sure that the
* QT development package is correctly installed and the QTDIR
* environment variable is set to the correct location.
*
make[2]: *** [scripts/kconfig/.tmp_qtcheck] Error 1
make[1]: *** [scripts/kconfig] Error 2
make: *** [_clean_scripts] Error 2
pavel@amd:/usr/src/linux-swsusp$

make -i clean makes it properly kill all *.o.

								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
