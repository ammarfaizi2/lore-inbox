Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbTLIJmn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTLIJml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:42:41 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:51328 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S264241AbTLIJl3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:41:29 -0500
To: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
References: <200312081536.26022.andrew@walrond.org>
	<20031208154256.GV19856@holomorphy.com>
	<3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com>
	<20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
	<20031209075619.GA1698@kroah.com> <1070960433.869.77.camel@nomade>
	<yw1xhe0aibpw.fsf@kth.se>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 09 Dec 2003 18:41:20 +0900
In-Reply-To: <yw1xhe0aibpw.fsf@kth.se>
Message-ID: <buoekvefhvj.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) writes:
> Let me give an example.  Hotplug will automatically load the ALSA
> drivers for my sound card, and /dev/snd/* are created (by devfs or
> udev, it doesn't matter for now).  Suppose that, some time, I run a
> program that tries to use OSS for sound.  Now, the ALSA OSS emulation
> is not loaded by hotplug, and I don't want it to.  It's nice to have
> snd-pcm-oss automatically loaded when some legacy application tries to
> use /dev/dsp.

For this sort of case it seems like it would be much cleaner to have
some sort of proxy device that would load the module upon open -- so the
also drivers would end up creating both alsa entries in /dev, and also
proxy entries for the supported oss devices.  

That way, you could have the explicit device entry (which I think is all
around saner), but not the overhead of rarely used modules.

-Miles
-- 
In New York, most people don't have cars, so if you want to kill a person, you
have to take the subway to their house.  And sometimes on the way, the train
is delayed and you get impatient, so you have to kill someone on the subway.
  [George Carlin]
