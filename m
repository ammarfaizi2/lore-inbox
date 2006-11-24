Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966203AbWKXVxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966203AbWKXVxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966206AbWKXVxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:53:45 -0500
Received: from tomts36.bellnexxia.net ([209.226.175.93]:38598 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S966203AbWKXVxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:53:44 -0500
Date: Fri, 24 Nov 2006 16:48:31 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: [PATCH] LTTng 0.6.36 for 2.6.18 (now with markers)
Message-ID: <20061124214831.GA25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:45:04 up 93 days, 18:53,  4 users,  load average: 0.49, 0.38, 0.25
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have, since a few weeks, moved LTTng to the markers infrastructure. I
left the ltt-dev users and contributors test the markers and LTTng on various
architectures (i386, x86_64, PowerPC, -ppc, ARM, MIPS) before posting it on
LKML.

The most important new features since the my post :

- Use DebugFS
- Use the "Markers" infrastructure (updated since the last post on LKML).
- Dynamically loadable "probes" that connects to the markers.
- CPU Hotplug support (this piece seemed necessary for the Xen port I am
  currently working on)
- Use of per-CPU atomic operations even on SMP machines (no lock prefix, no
  memory barriers) to update the per-cpu counters. An explicit smp_wmb()
  is used at the one place where the subbuffers are tagged "full" and
  smp_rmb() is used in the buffer consumer just after it reads this counter
  indicating that the subbuffer is full.

I am not submitting the probes themselves, as they can be provided as separate
kernel modules.

Comments and constructive criticism are, as always, welcome.

The patches follow.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
