Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUIPK5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUIPK5K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 06:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267901AbUIPK5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 06:57:10 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:17111 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267818AbUIPK5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 06:57:06 -0400
Subject: [PATCH] Suspend2 Merge: Driver model patches 0/2
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095332314.3855.157.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 20:58:35 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here are two patches for the driver model, which have been in use in
suspend2 for around a month.

The first provides support for keeping part of the device tree alive
while suspending the remainder. This is accomplished by abstracting the
dpm_active, dpm_off and dpm_irq lists into a new struct partial device
tree, and providing functions to create new device trees and move
devices and their parents between trees. The current API for suspending
and resuming devices is completely unchanged by this patch. New
functions provide the extra functionality and existing functions are
wrappers that work on the default tree. Suspend2 uses this to keep the
storage device and graphics driver alive while putting other devices to
sleep at the start of saving the image.

The second patch adds a helper for finding a device_class given it's
name. This is used to locate the frame buffer drivers and (in
combination with the above patch) keep them alive while suspending other
drivers.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

