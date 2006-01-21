Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWAUPsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWAUPsH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 10:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWAUPsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 10:48:07 -0500
Received: from gherkin.frus.com ([192.158.254.49]:39645 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S1750828AbWAUPsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 10:48:06 -0500
Subject: PNP vs. sound/isa/cs423x/cs4236.c in 2.6.16-rc1
To: linux-kernel@vger.kernel.org
Date: Sat, 21 Jan 2006 09:48:05 -0600 (CST)
CC: alsa-devel@alsa-project.org, perex@suse.cz
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20060121154805.4D3DADBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The rework of various ALSA drivers between 2.6.15 and 2.6.16-rc1 has
apparently introduced a dependency on CONFIG_PNP.  Unfortunately, PNP
has been problematic on my old Toshiba notebook (Tecra 730XCDT), so I
have CONFIG_PNP undefined in my kernel configuration.  This is the
result, because the define for CS423X_DRIVER doesn't happen without
CONFIG_PNP:

  CC [M]  sound/isa/cs423x/cs4232.o
  In file included from sound/isa/cs423x/cs4232.c:2:
  sound/isa/cs423x/cs4236.c:612: error: `CS423X_DRIVER' undeclared here (not in a function)
  sound/isa/cs423x/cs4236.c:612: error: initializer element is not constant
  sound/isa/cs423x/cs4236.c:612: error: (near initialization for `cs423x_nonpnp_driver.driver.name')
  sound/isa/cs423x/cs4236.c:612: error: initializer element is not constant
  sound/isa/cs423x/cs4236.c:612: error: (near initialization for `cs423x_nonpnp_driver.driver')
  sound/isa/cs423x/cs4236.c: In function `snd_cs423x_unregister_all':
  sound/isa/cs423x/cs4236.c:751: error: `cs423x_pnpc_driver' undeclared (first use in this function)
  sound/isa/cs423x/cs4236.c:751: error: (Each undeclared identifier is reported only once
  sound/isa/cs423x/cs4236.c:751: error: for each function it appears in.)
  sound/isa/cs423x/cs4236.c:754: error: `cs4232_pnp_driver' undeclared (first use in this function)
  sound/isa/cs423x/cs4236.c: In function `alsa_card_cs423x_init':
  sound/isa/cs423x/cs4236.c:772: error: `CS423X_DRIVER' undeclared (first use in this function)
  sound/isa/cs423x/cs4236.c:782: error: `cs4232_pnp_driver' undeclared (first use in this function)
  sound/isa/cs423x/cs4236.c:788: error: `cs423x_pnpc_driver' undeclared (first use in this function)
  make[3]: *** [sound/isa/cs423x/cs4232.o] Error 1
  make[2]: *** [sound/isa/cs423x] Error 2
  make[1]: *** [sound/isa] Error 2
  make: *** [sound] Error 2

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
