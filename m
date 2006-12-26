Return-Path: <linux-kernel-owner+w=401wt.eu-S932851AbWLZXet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932851AbWLZXet (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 18:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932847AbWLZXet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 18:34:49 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:57271
	"EHLO grelber.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932851AbWLZXet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 18:34:49 -0500
X-Greylist: delayed 644 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 18:34:49 EST
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: Feature request: exec self for NOMMU.
Date: Tue, 26 Dec 2006 18:23:07 -0500
User-Agent: KMail/1.9.1
Cc: David McCullough <david_mccullough@au.securecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612261823.07927.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to make some nommu-friendly busybox-like tools, which means using 
vfork() instead of fork().  This means that after I fork I have to exec in 
the child to unblock the parent, and if I want to exec my current executable 
I have to find out where it lives so I can feed the path to exec().  This is 
nontrivial.

Worse, it's not always possible.  If chroot() has happened since the program 
started, there may not _be_ a path to my current executable available from 
this process's current or root directories.

What would be really nice is if I could feed a NULL path to exec on NOMMU 
systems, and have that mean "re-exec the current executable".  I can't think 
of a way to do this without kernel support.  Any opinions on whether this is 
worthwhile?

A nommu-friendly daemonize() is another use for this, by the way...

Rob
-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
