Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293260AbSBWXXI>; Sat, 23 Feb 2002 18:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293263AbSBWXW5>; Sat, 23 Feb 2002 18:22:57 -0500
Received: from clavin.efn.org ([206.163.176.10]:30669 "EHLO clavin.efn.org")
	by vger.kernel.org with ESMTP id <S293260AbSBWXWp>;
	Sat, 23 Feb 2002 18:22:45 -0500
From: Steve VanDevender <stevev@efn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15480.9247.361123.52834@tzadkiel.efn.org>
Date: Sat, 23 Feb 2002 15:22:07 -0800
To: beh@icemark.net
Cc: linux-kernel@vger.kernel.org
Subject: Some problems on a ThinkPad A30P (again...)
In-Reply-To: <Pine.LNX.4.44.0202232340020.1435-100000@berenium.icemark.ch>
In-Reply-To: <Pine.LNX.4.44.0202232340020.1435-100000@berenium.icemark.ch>
X-Mailer: VM 7.01 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

beh@icemark.net writes:
 > First, a big thanks for the help I got so far  (reg. kapm-idled thread)...
 > 
 > Today I've experimented some more, and found the following:
 > 
 > 
 >  - even ALSA 0.90beta11 can't solve the suspend problem. I also noticed
 >    something rather strange, that I didn't realize before  (due to
 >    auto-loading of modules):
 > 	When I try to load "snd-card-intel8x0" for the first time,
 > 	modprobe complains about the card not being found or being
 > 	busy.
 > 	When I try to load the same module a second time,
 > 	everything works "fine"...
 >    But - WHY would linux at first say, the card isn't there, but
 >    find and initialize the card on the second run?

I had been running ALSA 0.9.0beta8a for some time, because whenever I
upgraded beyond that with either 2.2 or 2.4 kernels I would get similar
problems, in particular crashes when trying to suspend my laptop.

Eventually I decided to give ALSA 0.9.0beta11 a go with 2.4.17, and
then my machine would crash just trying to play sounds.

So I cursed for a while and then took another look at the ALSA
documentation.  They no longer say to modprobe "snd-card-foo", but just
"snd-foo" for your driver of choice.  In addition some other aspects of
the module hierarchy for ALSA seem to have changed, such that I gathered
trying to install a newer ALSA module stack over the old one would leave
some old modules around.

Once I had a from-scratch install of ALSA 0.9.0beta11 over a
from-scratch install of 2.4.18-rc1 and its modules, and modified
modules.conf to load snd-intel8x0 instead of snd-card-intel8x0,
everything started working fine.  In fact, I no longer have to have the
apmd suspend script to unload all the ALSA modules before a suspend and
reload them on resume -- the APM support in ALSA seems to have improved
significantly.
