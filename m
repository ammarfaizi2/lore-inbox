Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTFILnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 07:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTFILnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 07:43:31 -0400
Received: from gate.perex.cz ([194.212.165.105]:53509 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S263273AbTFILna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 07:43:30 -0400
Date: Mon, 9 Jun 2003 13:56:59 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: LKML <linux-kernel@vger.kernel.org>
Cc: ALSA development <alsa-devel@alsa-project.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: 2.5 kbuild: use of '-z muldefs' for LD?
Message-ID: <Pine.LNX.4.44.0306091342400.1323-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

	I am trying to figure the best solution for our problem. We reuse
one object file for more targets. Example:

------
snd-ice1712-objs := ice1712.o delta.o hoontech.o ews.o ak4xxx.o
snd-ice1724-objs := ice1724.o amp.o revo.o aureon.o ak4xxx.o

# Toplevel Module Dependency
obj-$(CONFIG_SND_ICE1712) += snd-ice1712.o
obj-$(CONFIG_SND_ICE1724) += snd-ice1724.o
------

The ak4xxx.o module is shared and has defined a few public functions.
Unfortunately, the default build-in.o rule fails when targets are 
requested to be included into the solid kernel because the public 
functions are duplicated in snd-ice1712.o and snd-ice17124.o.

I can instruct the ld compiler to ignore the multiple definitions using 
'-z muldefs':

EXTRA_LDFLAGS = -z muldefs

But it seems like a hack for me.
Does anybody have another idea to solve my problem?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

