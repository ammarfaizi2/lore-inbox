Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTI2JNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 05:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbTI2JNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 05:13:32 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:16587 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262910AbTI2JN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 05:13:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16247.63409.996071.860727@gargle.gargle.HOWL>
Date: Mon, 29 Sep 2003 11:13:21 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Frank Cusack <fcusack@fcusack.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2nd proc not seen
In-Reply-To: <20030929085807.GA22884@werewolf.able.es>
References: <20030904021113.A1810@google.com>
	<20030904091437.A25107@google.com>
	<20030928205045.B21288@google.com>
	<20030929085807.GA22884@werewolf.able.es>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon writes:
 > 
 > On 09.29, Frank Cusack wrote:
 > > On Thu, Sep 04, 2003 at 09:14:37AM -0700, Frank Cusack wrote:
 > > > On Thu, Sep 04, 2003 at 02:11:13AM -0700, Frank Cusack wrote:
 > > > > I think I've seen some recent talk about this problem.  I have an HPAQ
 > > > > xw6000 w/ 2xP4 CPUs.  A RH kernel finds both CPUs (4 if I enable HT).  A
 > > > > kernel.org kernel only finds 1 (2 if I enable HT).
 > > 
 > > This turned out to be a CPU numbering issue.  The HPAQ machine numbers
 > > the cpus #0 and #6.  I had NR_CPUS set to 2.  That only works if the CPUs
 > > are physically numbered 0 and 1.
 > > 
 > > So NR_CPUS is a little misleading.  I could suggest a Config.help change
 > > if you like.
 > > 
 > 
 > This is a little weird. This forces you to have all the SMP structures sized
 > 8 just to use 2 members.
 > 
 > Was not there a physical-logical map ? Or that was in -aa kernel and 2.6 ?

Problem #1 is that physical CPU numbering isn't dense. This is not a bug.
Problem #2 is that the kernel's internal dense-logical-to-sparse-physical
numbering was deleted in 2.5.23 or thereabouts.

Hence NR_CPUS is basically impossible to use reliably in 2.6 unless we
reintroduce cpu_logical_map[].

/Mikael
