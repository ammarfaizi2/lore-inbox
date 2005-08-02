Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVHBGKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVHBGKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 02:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVHBGKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 02:10:23 -0400
Received: from koto.vergenet.net ([210.128.90.7]:49549 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S261387AbVHBGKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 02:10:06 -0400
Date: Tue, 2 Aug 2005 16:20:00 +0900
From: Horms <horms@verge.net.au>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Chris Wright <chrisw@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: [Patch] v4l cx88 hue offset fix
Message-ID: <20050802071959.GB22793@verge.net.au>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Michael Krufky <mkrufky@m1k.net>,
	Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
	Chris Wright <chrisw@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
	debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, 

Another fix from 2.6.12.3 that seems approprite for 2.4.
Should apply cleanly to your tree.

Signed-off-by: Horms <horms@verge.net.au>

From: Michael Krufky <mkrufky@m1k.net>
Date: Thu, 30 Jun 2005 20:06:41 +0000 (-0400)
Subject: [PATCH] v4l cx88 hue offset fix
X-Git-Tag: v2.6.12.3
X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/gregkh/linux-2.6.12.y.git;a=commitdiff;h=aebaaf4060dd0db163694da8e4ab7ba86add57b9

  [PATCH] v4l cx88 hue offset fix
  
  Changed hue offset to 128 to correct behavior in cx88 cards.  Previously,
  setting 0% or 100% hue was required to avoid blue/green people on screen.
  Now, 50% Hue means no offset, just like bt878 stuff.
  
  Signed-off-by: Michael Krufky <mkrufky@m1k.net>
  Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
  Signed-off-by: Chris Wright <chrisw@osdl.org>
  Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

Backported to Debian's kernel-source-2.6.8 by dann frazier <dannf@debian.org>

--- a/drivers/media/video/cx88/cx88-video.c
+++ b/drivers/media/video/cx88/cx88-video.c
@@ -261,7 +261,7 @@ static struct cx88_ctrl cx8800_ctls[] = 
 			.default_value = 0,
 			.type          = V4L2_CTRL_TYPE_INTEGER,
 		},
-		.off                   = 0,
+		.off                   = 128,
 		.reg                   = MO_HUE,
 		.mask                  = 0x00ff,
 		.shift                 = 0,
