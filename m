Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWARJQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWARJQE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 04:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWARJQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 04:16:04 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:40205 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030234AbWARJQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 04:16:02 -0500
Date: Wed, 18 Jan 2006 10:15:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
Message-ID: <20060118091543.GA8277@mars.ravnborg.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <43CD67AE.9030501@eyal.emu.id.au> <20060117232701.GA7606@mars.ravnborg.org> <20060118085936.4773dd77.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118085936.4773dd77.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean.

> I just tried this on a freshly unpacked and configured (but not
> compiled) 2.6.16-rc1, and I observe a similarly strange, though
> different, behavior:
> hyperion:/home/khali/src/linux-2.6.16-rc1 # ls -l /dev/null
> crw-rw-rw-  1 root root 1, 3 2006-01-18 09:30 /dev/null
> hyperion:/home/khali/src/linux-2.6.16-rc1 # make distclean V=1
...
> make -f scripts/Makefile.clean obj=scripts/kconfig
> make -f scripts/Makefile.clean obj=scripts/kconfig/lxdialog
When the above command is executed gcc is actually called two times due
to following lines:
scripts/kconfig/lxdialog/Makefile
HOST_EXTRACFLAGS:= $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags)
HOST_LOADLIBES  := $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags $(HOSTCC))

The shell script check-dialog.sh is called which again do:
echo "main() {}" | gcc -xc - -o /dev/null

And it seems that gcc will trash /dev/null in your setup when doing
this.
One fix would be to avoid the two lines during distclean,
but I may have to resort to a temporary file.

Could you please confirm that the above command is the one that trashes
/dev/null, then I will try to cook up something better.

	Sam
