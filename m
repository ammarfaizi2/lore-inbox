Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTDIRSH (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 13:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263641AbTDIRSH (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 13:18:07 -0400
Received: from franka.aracnet.com ([216.99.193.44]:47580 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263642AbTDIRSF (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 13:18:05 -0400
Date: Wed, 09 Apr 2003 10:29:38 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: CONFIG_INPUT problems
Message-ID: <193480000.1049909378@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So we seem to have a problem with the way the config stuff deals
with CONFIG_INPUT, and I'd like some advice on the best way to
fix it.

The problem:

CONFIG_INPUT was commonly set to "n" in 2.4 kernels (and hence the
configs that upgrading people pick up). Even though it defaults to
"y" under the 2.5 subsystem, the old config overrides it, which I
guess is correct for most things, but it didn't govern keyboard
and (by cascade) CONFIG_VT_CONSOLE under 2.4 (I think).

The result:

Lots of people just get a really screwed up 2.5 kernel that does
nothing useful for them.

What to do ...

I thought about inverting the logic, and creating CONFIG_HEADLESS
which is !CONFIG_INPUT basically ... but changing all the stuff
depending on CONFIG_INPUT is rather invasive. So I was thinking of
something like

CONFIG_HEADLESS
	bool "headless console support
	default "n"

if HEADLESS = y
	define_bool CONFIG_INPUT = n
else
	define_bool CONFIG_INPUT = y
endif

or something vaguely along those lines ... except there doesn't
seem to be a way I can see to force a config option on from the
new config system? So that's actually a more general question, I guess ;-)

However, if someone has a better idea on how to not shoot the poor 
users over CONFIG_INPUT / CONFIG_VT_CONSOLE, I'd be very interested ...

M.

