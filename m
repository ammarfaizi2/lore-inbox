Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWBAKuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWBAKuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWBAKub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:50:31 -0500
Received: from khc.piap.pl ([195.187.100.11]:37126 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932175AbWBAKua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:50:30 -0500
To: <netdev@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [RFC] Backward compatibility and WAN netdev configuration
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 01 Feb 2006 11:50:28 +0100
Message-ID: <m3psm7tksr.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm considering some changes/additions to my generic HDLC (WAN) code.

What do you think about:
a) Currently it consists of mid-layer WAN protocols single module (Cisco
   HDLC, FR etc.) + low-level hardware HDLC card driver (C101, N2, PCI200SYN
   etc.). I'm thinking about splitting the protocol module into separate
   modules - it would make them independent, users would be able to
   load, say, FR without PPP or X.25 and underlying syncppp, lapb etc.
   From the technical POV it would be superior to current code but it
   would require sysadmins to change modprobe.conf, add another modprobe
   or something like that. Not a real problem but the upgrade can't be
   automatic.

b) I'm currently using a dedicated "sethdlc" tool for configuring WAN
   devices (both physical parameters like clocking, speeds etc. and
   protocol parameters/selection). It uses ioctl(). I'm thinking about
   switching configuration interface to sysfs. That would render the
   old ioctl interface obsolete.
   It would mean much better flexibility, and (when the HDLC ioctl
   interface is removed in a year or so) would simplify the code.

   I'm not sure about using sysfs for net device configuration, though.
   Of course, it would make sysfs mandatory for generic HDLC users.

I'd aim at making changes to ~ 2.6.18.

Opinions?
-- 
Krzysztof Halasa
