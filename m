Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270431AbTGRXPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 19:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271936AbTGRXPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 19:15:11 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:41943 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S271933AbTGRXPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 19:15:05 -0400
Date: Sat, 19 Jul 2003 01:30:00 +0200 (MEST)
Message-Id: <200307182330.h6INU0YJ029869@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: chas@cmf.nrl.navy.mil
Subject: [BUG] 2.4.22-pre7 ATM config breakage
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When configuring 2.4.22-pre7 I get the drivers/atm/Config.in
questions even though I haven't enabled CONFIG_ATM.

This is because net/Config.in has

if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
   tristate 'Asynchronous Transfer Mode (ATM) (EXPERIMENTAL)' CONFIG_ATM

while arch/i386/config.in has

      source drivers/net/Config.in
      if [ "$CONFIG_ATM" != "n" ]; then
         source drivers/atm/Config.in

With CONFIG_EXPERIMENTAL disabled, CONFIG_ATM is unset, and the
test "$CONFIG_ATM" != "n" becomes true ("" != "n").

Either CONFIG_ATM shouldn't depend on CONFIG_EXPERIMENTAL, or the test
should be "$CONFIG_EXPERIMENTAL" = "y" -a "$CONFIG_ATM" != "n".

/Mikael
