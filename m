Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267786AbTAMDjo>; Sun, 12 Jan 2003 22:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267791AbTAMDjo>; Sun, 12 Jan 2003 22:39:44 -0500
Received: from pcp01184434pcs.strl301.mi.comcast.net ([68.60.187.197]:27875
	"EHLO mythical") by vger.kernel.org with ESMTP id <S267786AbTAMDjm>;
	Sun, 12 Jan 2003 22:39:42 -0500
Date: Sun, 12 Jan 2003 22:48:13 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rob Wilkens <robw@optonline.net>, linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030113034813.GJ12020@michonline.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Rob Wilkens <robw@optonline.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <20030112211530.GP27709@mea-ext.zmailer.org> <1042406849.3162.121.camel@RobsPC.RobertWilkens.com> <20030112215949.GA2392@www.kroptech.com> <1042410059.1208.150.camel@RobsPC.RobertWilkens.com> <1850.4.64.197.173.1042420003.squirrel@www.osdl.org> <1042420910.3162.277.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042420910.3162.277.camel@RobsPC.RobertWilkens.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 08:21:50PM -0500, Rob Wilkens wrote:
> :/usr/src/linux-2.5.56/Documentation# grep -i return CodingStyle
> 
> Returned nothing..  

As annoying as this thread is, there are occassional valid points.

A first pass at an addition:

--- local/Documentation/CodingStyle.orig	2002-11-19 03:02:32.000000000 -0500
+++ local/Documentation/CodingStyle	2003-01-12 22:44:39.000000000 -0500
@@ -264,3 +264,27 @@
 
 Remember: if another thread can find your data structure, and you don't
 have a reference count on it, you almost certainly have a bug.
+
+		Chapter 9: Error handling
+
+Error handling in functions needs to follow a few simple rules.  If the
+function has allocated resources (irqs, memory), taken a reference, 
+grabbed locks, etc, all of those allocations must be reversed when 
+returning an error.
+
+In functions that depend on several allocations, the preferred way to 
+return the error is with with the use of a few "goto"s that point at an
+error block at the end of the function, after the normal, successful 
+return.
+
+Several consecutive lables can be used, reversing the order of the 
+allocations.  For example, if memory is allocated, a lock taken, and 
+an irq activated, the error labels might be labeled "err_noirq", 
+"err_nolock", "err_nomem", in order.  The final step would be to
+return the error.
+
+The reason for this style is very simple: Multiple return paths from
+the same block of code are extremely confusing, and make verification
+that locks are balanced, memory is properly freed, and that reference
+counts are not leaked very difficult.
+


-- 

Ryan Anderson
  sometimes Pug Majere
