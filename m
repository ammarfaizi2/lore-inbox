Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbTI2KQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 06:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTI2KQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 06:16:47 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:29359 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S262970AbTI2KQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 06:16:45 -0400
Date: Mon, 29 Sep 2003 12:16:41 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
Cc: mochel@osdl.org
Subject: 2.6.0-test6: pm callbacks broken?
Message-ID: <20030929101641.GA21127@rhlx01.fht-esslingen.de>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I did some experimenting with the power management capabilities of
2.6.0-test6 and realized that psmouse-base.c didn't have its
pm callback psmouse_pm_callback() called upon echo 3 >/proc/acpi/sleep
and upon resume.
Result: the newly changed synaptics driver (MUCHO thanks!!!) complains
about

Synaptics driver lost sync at 1st byte

after resume.
pm_register did get called sucessfully, however (the pm_dev returned was
non-NULL).

After having traced psmouse_pm_callback(), I traced pm_send_all(),
and no log output (no invocation) there either.

Correct me if I'm completely and totally wrong, but isn't a rather "fatal"
echo 3 >/proc/acpi/sleep supposed to resurrect any and all devices
in the system upon resume??

Sorry that I didn't nail the exact place where the callback "screwup" happens
yet, but right now I don't have much time to pursue this.

(or maybe I just did something very stupid like not enabling some option) 

Thanks for all your hard work!!

Andreas Mohr
