Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbTKKHrS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 02:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTKKHrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 02:47:18 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:25819
	"EHLO michonline.com") by vger.kernel.org with ESMTP
	id S264269AbTKKHrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 02:47:16 -0500
Date: Tue, 11 Nov 2003 02:47:15 -0500
From: Ryan Anderson <ryan@michonline.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Some thoughts about stable kernel development
Message-ID: <20031111074715.GH22850@michonline.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <m3u15de669.fsf@defiant.pm.waw.pl> <200311091950.hA9Jo01d002041@81-2-122-30.bradfords.org.uk> <200311091754.21619.rob@landley.net> <200311100850.hAA8oiIX000283@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311100850.hAA8oiIX000283@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 08:50:44AM +0000, John Bradford wrote:
> On the other hand, many users out there are _obviously_ under the
> illusion that 2.6.0-test has no known security issues, and that is
> false.  If their machine is internet-connected and compromised, it can
> cause annoyance to third parties.  Given that, I think a file in the
> root of the kernel tree, saying something like, "Don't use me on an
> internet connected machine unless you know what you're doing" would be
> worth considering.

Something vaguely like this might help the issue (with the obvious file
created having the appropriate note in it)

Untested, and I'm sure there are style problems, but the idea should be
obvious:

--- Makefile	2003-10-26 19:04:21.000000000 -0500
+++ Makefile.ryan	2003-11-11 02:45:01.000000000 -0500
@@ -81,7 +81,7 @@
 
 # That's our default target when none is given on the command line
 .PHONY: all
-all:
+all: check-beta
   
 ifneq ($(KBUILD_OUTPUT),)
 # Invoke a second make in the output directory, passing relevant variables
@@ -1027,3 +1027,12 @@
 endif	# skip-makefile
 
 FORCE:
+
+.PHONY: check-beta
+
+check-beta:
+	if [ -f README.Security && ! -f README.Security.IknowwhatImdoing ] ; then \
+		cat README.Security ; \
+		read ; \
+	fi
+


-- 

Ryan Anderson
  sometimes Pug Majere
