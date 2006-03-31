Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWCaS3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWCaS3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWCaS3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:29:13 -0500
Received: from oola.is.scarlet.be ([193.74.71.23]:43754 "EHLO
	oola.is.scarlet.be") by vger.kernel.org with ESMTP id S932236AbWCaS3N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:29:13 -0500
Date: Fri, 31 Mar 2006 20:29:00 +0200
From: maartendeprez@scarlet.be, maartendeprez@scarlet.be,
       maartendeprez@scarlet.be, maartendeprez@scarlet.be,
       maartendeprez@scarlet.be
To: linux-kernel@vger.kernel.org
Subject: nvidiafb and Aladdin TNT2 card
Message-ID: <20060331182858.GA2656@deprez-aerts.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
X-DCC-scarlet.be-Metrics: oola 2020; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

To make nvidiafb work with an Aladdin TNT2 card, i need to add "case
0x00a0:" on line 1541 to let it detect the architecture type (the card
says it's NV5 instead of NV4 but that's no problem i think). In
nv_hw.c and nv_setup.c, sometimes "(par->Chipset & 0x0ff0) == 0x0020"
is checked, which should probably be changed to "par->Architecture ==
NV_ARCH_04".  That way it works, but crashes after a while, unless
acceleration is disabled. When i run "while n in $(seq 100000); do
echo \"$n\"; done", it works fine in unaccelerated modes, but locks up
when accelerated.  Any ideas why? Something i noticed is that
depending on the mode, the pixclock can be faster than the system ram
which it uses (it's integrated in the motherboard and uses a part of
system memory). Then some random "snow" (usuakky not moving till
something on the screen is changed) appears, and this doesn't happen
in slower modes. Maybe that could cause lockups?

Thanks,
Maarten Deprez
