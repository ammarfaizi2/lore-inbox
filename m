Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVA3Tfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVA3Tfy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 14:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVA3Tfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 14:35:54 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:54122 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261770AbVA3Tfr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 14:35:47 -0500
Date: Sun, 30 Jan 2005 20:37:33 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: kbuild: shorthand ym2y, ym2m etc
Message-ID: <20050130193733.GA8984@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have in several cases the need to transpose a i'm' to 'y' in the Kbuild
files.
One example is the following snippet from sound/Makefile:
ifeq ($(CONFIG_SND),y)
  obj-y += last.o
endif

Alternative syntax could be:
obj-$(call y2y,CONFIG_SND) += last.o


y2y takes one parameter and return y unly if parameter is y, otherwise
return nothing.


>From drivers/vidoe/Makfile:
ifeq ($(CONFIG_FB),y)
  obj-$(CONFIG_PPC)                 += macmodes.o
endif

Altetnative syntax:
obj-$(call yx2x,CONFIG_FB,CONFIG_PPC) += mcmodes.o

yx2x return second parameter (x) if first parameter is y. Otherwise
nothing is returned.

To be complete the full set would be:

ym2y
ym2m
empty2y
empty2m
y2y
m2y
y2m
m2m
yx2x
mx2x

Would that be considered usefull?

	Sam
