Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTJFHPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 03:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTJFHPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 03:15:41 -0400
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:59154 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S261820AbTJFHPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 03:15:38 -0400
Subject: Security Auditing subsystem for Linux - request for
	advice/assistance
From: Leigh Purdie <spammagnet@intersectalliance.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1065424389.7059.90.camel@inferno>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 06 Oct 2003 17:13:10 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regular readers of the lkml may have picked up a few references to the
'snare' auditing subsystem previously on this list (There's a link at
end of this post for those who want to click through to search).

Snare has been in low-priority development for a fairly long time now,
first as a kernel module that intercepted system calls via
sys_call_table (I know, the 7th deadly sin.. we've repented), and more
recently, as a kernel patch / audit daemon combo.

However, the requirement for an operational auditing subsystem seems to
be ramping up pretty quickly, as government departments, and big
organisations that need to meet government standards relating to
computer security, start to adopt Linux in a big way.

We now have a bunch of organisations implementing snare internally
(various banks and health-care providers, quite a few universities, most
of the big defence/aerospace organisations, a fair number of govt
departments, etc..). A few distribution vendors (RHAS/SLES) have also
aparently received requests from some of their big customers to
integrate snare into their releases.

As such, recognising that there are MANY people out there with a heck of
a lot more kernel coding experience than the two core snare developers,
we were hoping that some kind souls would offer a bit of assistance in
cleaning up the code with a view to making things more streamlined /
robust. If the code makes it up to spec, and enough people think it's
worthwhile, kernel integration later on down the track may be an option
also (2.7? Sooner? Suggestions welcome).

So, down to the specifics:

Snare provides an auditing subsystem for Linux, attempting to follow the
general intent of C2/CAPP to provide a (hopefully) REASONABLE level of
security, without impacting too significantly on either system
performance, or security administrator resources.

The two developers of Snare have a fair bit of experience on the other
end of logging / audit trails / forensics (Solaris BSM, AIX, Unicos,
ACF2/RACF, Win EventLog, Firewalls too numerous to name, and so on), and
can hopefully bring this experience to developing an audit subsystem
that finds a reasonable middle-ground between "technically perfect but
functionally useless", and "great information, but untrustworthy data".

The current implementation has a few areas that would really benefit
from a bit of care-and-feeding from an experienced kernel hacker. In
particular:
* Filenames
  - Grabbing the REAL source / destination path for file-related events,
regardless of:
  a) Whether the system call succeeds or fails
  b) Symlinks, links, mountpoints, chroot's

* Opportunities for the user to shift paths between the auditapi copy
from userpace, and the kernel copy from userspace, implying that the
user may chmod /etc/passwd, whilst the auditapi reports a chmod of
/tmp/goo (for example).

* Memory
  - snare currently uses a 'rubber-band' linked list which soaks up
memory when the user-space audit daemon isn't fast enough to read
events. Although there's a high-water mark, personalising it to each
system (ie: memory availability) isn't happening.

* Potentially many other areas.
  - LSM integration for some calls, if viable?
  - General 'gotchas' - stuff that might be pretty clear to a
experienced kernel coder, that we haven't picked up.

So, if you're willing to take a peek at the code, and contribute a few
code changes, please take a look at the following URL for a patch
against stock 2.4.22 (url provided due to size of patch - about 93k).
http://www.intersectalliance.com/projects/Snare/Download/kernel-patch/SNARE-0.9.5b.diff

Audit daemon for this version of the patch, if you would like to test
snare (includes audit.conf):
http://www.intersectalliance.com/projects/Snare/Download/kernel-patch/auditd-0.9.5b.tar.gz

More general info:
http://www.intersectalliance.com/projects/Snare/index.html

Alternatively, if any existing maintainer is interested in adopting
snare, leaving us to play with the userspace audit daemon / GUI, please
let me know!

Regards,

Leigh.
- - -
Search for snare on lkml:
http://www.google.com/u/iuussg?as_oq=snare&sa=Google+Search&domains=uwsg.iu.edu&sitesearch=uwsg.iu.edu&as_epq=hypermail%2Flinux%2Fkernel

Note: This email address is valid, but temporary only; it will probably
dissapear approximately a month after this post. More permanent contact
details available from http://www.intersectalliance.com/contact.html
-- 
Leigh Purdie, Director - InterSect Alliance Pty Ltd
http://www.intersectalliance.com/

