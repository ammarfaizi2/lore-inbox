Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316847AbSFVG5v>; Sat, 22 Jun 2002 02:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316846AbSFVG5u>; Sat, 22 Jun 2002 02:57:50 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:15790 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316844AbSFVG5u>; Sat, 22 Jun 2002 02:57:50 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 21 Jun 2002 23:57:38 -0700
Message-Id: <200206220657.XAA21563@adam.yggdrasil.com>
To: bug-make@gnu.org
Subject: make-3.79.1 bug breaks linux-2.5.24/drivers/net/hamradio/soundmodem
Cc: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
       sailer@ife.ee.ethz.ch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.5.24/drivers/net/hamradio/soundmodem/Makefile contains
the following rule:

$(obj)/sm_tbl_%: $(obj)/gentbl
        $<

	obj was set to "." /usr/src/linux/Rules.make, which was included
earlier in the Makefile.

	The problem is that when make executes this rule it executes
"gentbl" rather than "./gentbl".  This causes the command to fail if
you do not have "." in your path.  Make-3.79.1 is apparently being too
clever in expanding file names.  I think this is a make bug.

	Until the make bug is fixed, I have worked around the problem
by replacing the rule with:

$(obj)/sm_tbl_%: $(obj)/gentbl
        PATH=$(obj):$$PATH $<


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
