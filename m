Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423590AbWJZRxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423590AbWJZRxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 13:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161395AbWJZRxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 13:53:44 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:34977 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1161387AbWJZRxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 13:53:43 -0400
Subject: Re: [PATCH] time_adjust cleared before use
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: Roman Zippel <zippel@linux-m68k.org>
Cc: John Stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux@horizon.com
In-Reply-To: <Pine.LNX.4.64.0610261919400.6761@scrub.home>
References: <1161876597.7885.9.camel@x2.site>
	 <Pine.LNX.4.64.0610261919400.6761@scrub.home>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 13:53:25 -0400
Message-Id: <1161885205.7885.15.camel@x2.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-26 at 19:22 +0200, Roman Zippel wrote:
> On Thu, 26 Oct 2006, Jim Houston wrote:
> > I notice that the code which implements adjtime clears
> > the time_adjust value before using it.  The attached 
> > patch makes the obvious fix.

> Acked-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Jim Houston <jim.houston@ccur.com>

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 47195fa..3afeaa3 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -161,9 +161,9 @@ void second_overflow(void)
 			time_adjust += MAX_TICKADJ;
 			tick_length -= MAX_TICKADJ_SCALED;
 		} else {
-			time_adjust = 0;
 			tick_length += (s64)(time_adjust * NSEC_PER_USEC /
 					     HZ) << TICK_LENGTH_SHIFT;
+			time_adjust = 0;
 		}
 	}
 }


