Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbTIITa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbTIIT3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:29:39 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:25361 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264409AbTIIT32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:29:28 -0400
Date: Tue, 9 Sep 2003 21:29:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Multiple configuration support
Message-ID: <20030909192918.GA2933@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman.

Russell pointed out to me in private mail that the current way
to select individual configurations are broken with my latest
changes, where I moved *config targets to scripts/kconfig/Makefile.
The problem is that they use the target filename_config to
select the individual configuration (see arch/arm/Makefile).

This brought up an old idea I have had for some time.
With the current kconfig it should be doable to have something like
the following scheme:
arch/$(ARCH)/defconfig	<= As we know it
arch/$(ARCH)/configs/boardconfig

boardconfig should be very simple, only including delta to the
default configuration.
So boardconfig would only enable those drivers specific for that
board and other relevant config information. For example defconfig
selected the Opetron CPU, then boardconfig could change this to an 486 CPU.

Example boardconfig file:
CONFIG_M486=y

I cannot see how this would work with choice etc., would that be a problem?

This scheme would make it less cumbersome to maintain the dozen of
different configuration files as included by arm, ppc, ppc64 today.

Comments to that approach?

I tried to look into this, but was stuck in conf_read().
When the file has been opened conf_read() set all symbols back to
default values, so I could not call it twice.
And I didn't want to fiddle to much with the public interface of
kconfig for now.

	Sam
