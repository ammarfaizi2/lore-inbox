Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWDVVG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWDVVG5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWDVVG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:06:56 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:62680 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751212AbWDVVGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:06:55 -0400
Message-ID: <444991EF.3080708@watson.ibm.com>
Date: Fri, 21 Apr 2006 22:16:15 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LSE <lse-tech@lists.sourceforge.net>, Jes Sorensen <jes@sgi.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>,
       Erich Focht <efocht@ess.nec.de>, Levent Serinol <lserinol@gmail.com>,
       Jay Lan <jlan@engr.sgi.com>
Subject: [Patch 0/8] per-task delay accounting
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here are the delay accounting patches again. I'm not using the
earlier email thread due to code being refactored a bit.

The previous posting
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0603.3/1776.html
of these patches elicited several review comments from Andrew Morton
all of which have been addressed.

The other main thread of the comments was whether other accounting
stakeholders would be ok with this interface. Towards this end,
I'd posted an overview of what the other packages do (which didn't seem
to make the archives) and some of the stakeholders responded.

I'll repost the analysis as a reply to this post. Meanwhile, here's
the list of the stakeholders identified by Andrew and a summary of status
of their comments.


1. CSA accounting/PAGG/JOB: Jay Lan <jlan@engr.sgi.com>

Raised several points
       http://www.uwsg.indiana.edu/hypermail/linux/kernel/0604.1/0397.html
all of which have been addressed in this set of patches.

2. per-process IO statistics: Levent Serinol <lserinol@gmail.com>

No reponse.
I'd ascertained that its needs are a subset of CSA.

3. per-cpu time statistics: Erich Focht <efocht@ess.nec.de>

No response.
I'd ascertained that its needs can be met by taskstats
interface whenever these statistics are submitted for inclusion.

4. Microstate accounting: Peter Chubb <peterc@gelato.unsw.edu.au>

Mentioned overlap of patches with delay accounting
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0603.3/2286.html

and also that a /proc interface was preferable due to convenience.
My position is that the netlink interface is a superset of /proc due to
former's ability to supply exit-time data.


5. ELSA:  Guillaume Thouvenin <guillaume.thouvenin@bull.net>

Confirmed that ELSA is not a direct user of a new kernel statistics
interface since it is a consumer of CSA or BSD accounting's statistics.


6. pnotify: Jes Sorensen <jes@sgi.com>
(taken over pnotify from Erik Jacobson)

Informed over private email that pnotify replacement is
being worked on.

I'd ascertained that pnotify (or its replacemenent) will not be
concerned with exporting data to userspace or collecting any stats.
Thats left to the kernel module that uses pnotify to get
notifications. CSA is one expected user of pnotify.
Hence CSA's concerns are the only ones relevant to pnotify as well.


7. Scalable statistics counters with /proc reporting:
 Ravikiran G Thirumalai, Dipankar Sarma <dipankar@in.ibm.com>

Confirmed these counters aren't relevant to this discussion.



--Shailabh


Series

delayacct-setup.patch
delayacct-blkio-swapin.patch
delayacct-schedstats.patch
genetlink-utils.patch
taskstats-setup.patch
delayacct-taskstats.patch
delayacct-doc.patch
delayacct-procfs.patch
