Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129457AbRBSWJ7>; Mon, 19 Feb 2001 17:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130052AbRBSWJt>; Mon, 19 Feb 2001 17:09:49 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:18292
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129457AbRBSWJm>; Mon, 19 Feb 2001 17:09:42 -0500
Date: Mon, 19 Feb 2001 23:09:33 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Cc: ms@citd.de
Subject: rsync on newer kernel does not quite work?
Message-ID: <20010219230933.A823@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

For some time up through the testX kernels I used rsync to
update my "dirty" tree after applying the latest patches to the
clean tree. At some point this stopped working (more about that
later) but as new kernels were coming fast at that time I did
not think much of it, assuming that cleverer folk than me would
fix it soon. They did not, however, and I got kinda used to
working around the "bug".

The problem manifests itself in that rsync will complete syncing
two directories but will then hang (soft). It can be killed
with ^C and rerun with success. The amount of work that rsync
needs to do seems to be the trigger: rsyncing the drivers
directory (to a non-existent dir) will trigger the hang for
me, but drivers/[a-r]* will not.

Since Matthias Schniedermeyer reported the same problem in
http://marc.theaimsgroup.com/?l=linux-kernel&m=98157768131423&w=2
I have tried on and off to locate the kernel version where
the shift in behaviour happened, but after recompiling all
kernels down to test1 I have not gotten a successfull rsync
run yet. And I am sure that it worked once, well after test1.
I have upgraded my build environment from RH6.2 to RH7.0
in the meanwhile, but I even remembered to change 'gcc' to
'kgcc' in the makefile without luck :/ However, rsync behaves as
expected under 2.2.18 (compiled locally) and the 2.2.16-22
that comes with RH7.0. But not under any of the 2.4.X kernels
that I have tried (most of them incl. -acX).

rsyncs tried: 2.4.4-1 (rpm), 2.4.6 (local compile) and 2.4.1 
  (ditto).
kernels tried (not working) (partial list): 241, 241ac9, 
  242p4, 240-testX (1<=X<=12).
gccs tried (rsync and kernel compiles): kgcc (gcc version 
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)), gcc
(gcc version 2.96 20000731 (Red Hat Linux 7.0)) (2.96-69)

If you need further information please let me know.


-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

First snow, then silence.
This thousand dollar screen dies
so beautifully.           --- Error messages in haiku
