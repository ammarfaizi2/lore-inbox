Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWIZUmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWIZUmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWIZUmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:42:39 -0400
Received: from khc.piap.pl ([195.187.100.11]:33439 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932297AbWIZUmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:42:39 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       PC300 Maintainer <pc300@cyclades.com>
Subject: Generic HDLC update
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 26 Sep 2006 22:42:34 +0200
Message-ID: <m3odt21hs5.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jeff,
in this thread I'm posting two patches:
- 1/2: modularizes generic HDLC code - WAN protocols (FR, Cisco HDLC
  etc.) can now be separate modules. We can now have multiple module
  versions for a protocol (something like syncppp-based PPP or based
  on generic PPP). Also we don't have to load things like syncppp or
  lapb if we don't need it.

  "Core" generic HDLC code doesn't now know anything about the
  WAN protocols - all protocol-related information has been moved from
  hdlc.h to the protocol drivers.


- 2/2: while both user-space and low-level driver interfaces are not
  changed by the first patch, it has to change data structures
  internal to the generic HDLC. Unfortunately, there is one particular
  driver - pc300 - abusing those internal structures. There are few
  ways to fix this driver but it's not trivial. PC300 maintainer has
  been notified about the problem and possible solutions, and has
  been sent a copy of the modularizing patch two+ months ago.

  This patch removes accesses to the HDLC-internal data structures
  from pc300 driver, thus enabling it to compile but breaking part
  of its functionality.

Please apply both patches to Linux 2.6.
Thanks.
-- 
Krzysztof Halasa
