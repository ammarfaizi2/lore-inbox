Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267603AbUH2KHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267603AbUH2KHM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 06:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUH2KHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 06:07:11 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:6099 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S267587AbUH2KHC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 06:07:02 -0400
Message-ID: <1093774021.4131aac52743b@imp4-q.free.fr>
Date: Sun, 29 Aug 2004 12:07:01 +0200
From: castet.matthieu@free.fr
To: linux-kernel@vger.kernel.org
Subject: pnp and manual choose of resource : bug ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 213.228.47.30
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
due to a bug in pnpbios parser [1] I wanted to choose my configuration.
So I looked in Documentation/pnp.txt and tried to changed it with echo "manual
<depnum> <mode>" > resources, but it didn't work.
After looking in drivers/pnp/interface.c, I saw that is not implemented :(
So I try to modify the driver in order it use a good configuration. But for
using pnp_assign_resources that let you choose an other config, the device must
be disable, but when you activate a device with pnp_activate_dev, it call
pnp_auto_config_dev that change the config you choose before.

So you can't choose another configuration, without an ugly hack (dev->active =
0; to your change; dev->active = 1;)

Is that normal ?

Matthieu

[1] : http://bugzilla.kernel.org/show_bug.cgi?id=3295

PS : please CC me since I'm not subscribed to lkml.
