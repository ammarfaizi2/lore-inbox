Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVJYNUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVJYNUP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 09:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVJYNUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 09:20:14 -0400
Received: from goliath.siemens.de ([192.35.17.28]:33072 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP id S1751188AbVJYNUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 09:20:13 -0400
Message-ID: <0AD07C7729CA42458B22AFA9C72E7011C8EF@mhha22kc.mchh.siemens.de>
From: "Schupp Roderich (extern) BenQ MD PD SWP 2 CM MCH" 
	<Roderich.Schupp.extern@mch.siemens.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Race between "mount" uevent and /proc/mounts?
Date: Tue, 25 Oct 2005 15:20:10 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the 2.6.13 and 2.6.14-* kernels seem susceptible to a race condition
between the sending of a "mount" uevent and the actual mount becoming
visible thru /proc/mounts, at least when the kernel is configured
with voluntary preemption. 

The following scenario: 
- system is using the HAL daemon, configured to monitor kernel uvents
- someone (usually some kind of volume manager in response to
  a device hotplug, but could also a manual mount) mounts a filesystem
- "mount" uevent is emitted
- HAL daemon reads the event, then opens and reads /proc/mounts
  (in order to determine the corresponding mount point, since the uevent
  contains only the sysfs device name), but /proc/mounts does not
  (yet) contain the corresponding line

There has been one previous post about this:
http://marc.theaimsgroup.com/?l=linux-kernel&m=112670567427154

Cheers, Roderich
