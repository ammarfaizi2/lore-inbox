Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbUAHMF4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 07:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbUAHMF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 07:05:56 -0500
Received: from mail1.drkw.com ([62.129.121.35]:7879 "EHLO mail1.drkw.com")
	by vger.kernel.org with ESMTP id S264372AbUAHMFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 07:05:53 -0500
From: "Heilmann, Oliver" <Oliver.Heilmann@drkw.com>
To: linux-kernel@vger.kernel.org
Subject: SIS 648FX AGP fixed - but clarification needed
Content-Type: text/plain
Message-Id: <1073563512.502.66.camel@cobra>
Mime-Version: 1.0
Date: Thu, 08 Jan 2004 12:05:12 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: Oliver.Heilmann@drkw.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an SIS 648FX in a notebook computer with an ATI Radeon9600 (M10)
AGP card. AGP did not work so I had a look and found that ATTBASE had
moved to caps + 0x18, AGPCTRL needed to be set and that there was a
weird delay after the bridge has been enabled(see below). Things work
now.

I would like to put my fix into a proper patch but am still unclear on
the following points:

1. According to sis_agp_device_ids the 648 chipset is supported. Does
this mean that the "plain" 648 is actually supported and my "FX"
iteration is so fundamentally different (even thought is has the same
device id).

2. Once the agpEnable bit is set in the bridge's cmd register the config
space of the master is completely screwed up for a while. Trying to
configure/enable the master during that period mostly crashes the
system. Waiting does the trick. (Annoyingly, simply waiting for the
master to become readable again is not good enough, one still needs to
wait longer for things to become stable). None of the other chipsets
seem to need this. Can anybody explain? Perhaps I missed something? If
there is no other way and I do have to stick with the delay, then I
suppose it would not be a good idea to polute the generic agp_enable
with it?!

Oliver


-- 
Oliver Heilmann <oliver.heilmann@drkw.com>


--------------------------------------------------------------------------------
The information contained herein is confidential and is intended solely for the
addressee. Access by any other party is unauthorised without the express 
written permission of the sender. If you are not the intended recipient, please 
contact the sender either via the company switchboard on +44 (0)20 7623 8000, or
via e-mail return. If you have received this e-mail in error or wish to read our
e-mail disclaimer statement and monitoring policy, please refer to 
http://www.drkw.com/disc/email/ or contact the sender.
--------------------------------------------------------------------------------

