Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268726AbUIBRLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268726AbUIBRLw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 13:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268738AbUIBRLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 13:11:52 -0400
Received: from mailgate.urz.tu-dresden.de ([141.30.66.154]:56758 "EHLO
	mailgate.urz.tu-dresden.de") by vger.kernel.org with ESMTP
	id S268726AbUIBRLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 13:11:46 -0400
Message-ID: <1094145103.4137544f97e2a@rmc60-231.urz.tu-dresden.de>
Date: Thu,  2 Sep 2004 19:11:43 +0200
From: Hendrik Fehr <s4248297@rcs.urz.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Full CPU-usage on sis5513-chipset disc input/output-operations
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 217.238.216.13
X-TUD-Virus-Scanned: by amavisd-new at rks24.urz.tu-dresden.de
X-TUD-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on rks24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
I was busying myself with this for about two weeks, and today i am likely to
say
that this is a bug in the kernel.

The symptoms for short:
On 2.4.x (actually 2.4.27) kernel, disk i/o operations perform well (no
noticable cpu overhead). But: on kernel 2.6.9-rc1-bk8 (and all the other
2.6.x that i tested), disk i/o operations perform bad: full cpu usage
(sys) when copying files or doing other i/o operations.

And to make sure that the new scheduling interface is not the "bad guy" i
tried different schedulers with elevator=<something>. The bug was still
there.

That is what i was doing to resolve the problem:
I wrote to Lionel (the sis5513.c author found in MAINTAINERS) on 20040831:
----8<-----
I am using linux-2.6.x kernel with sis5513 support enabled. I discovered a
strange performance problem that was mentioned on bugzilla.kernel.org some time
before [1.]. For a full and details report you may have a look at [2.].

[1.] http://bugzilla.kernel.org/show_bug.cgi?id=2983
[2.] http://rcswww.urz.tu-dresden.de/~s4248297/gubed/report.html

I dont know if it is a problem of the sis5513.c code, but i hope you may be
helpful in finding the right person to whom i should send this bug.
----8<-----

He tried to figure out, if this behaviour may be a problem of his driver,
and it seems that this is not the case. He sugested that i may post this
problem to this list, that is, what i am doing here. You can see the full
conversation with Linonel at the web page at [2.]

IMHO it must have to do with the Uniform Multi-Platform E-IDE driver. The
2.4 kernel uses revision 7.00beta4-2.4 and the 2.6 uses revision
7.00alpha2. If this sugestion is wrong excuse me, i am not a C programer.

Everyone who is keen on solving this problem should have a look at the very
detailed description of the bug on the web page [2.]. I kept it as close as
possible to the rules in the REPORTING-BUGS file (hey i even made some
screenshots).
The question is: why would the same hardware combination on the 2.4 kernel
perform well, and not so well on 2.6.

PS: please CC me, i am not on the list ;-)

Best regards,
Hendrik Fehr.
