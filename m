Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbVDYPIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVDYPIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbVDYPIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:08:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31141 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262626AbVDYPII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:08:08 -0400
Date: Mon, 25 Apr 2005 23:11:36 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 0/7] dlm: overview
Message-ID: <20050425151136.GA6826@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This is a distributed lock manager (dlm) that we'd like to see added to
the kernel.  The dlm programming api is very similar to that found on
other operating systems, but this is modeled most closely after that in
VMS.

Many distributed/cluster applications use a dlm for inter-process
synchronization where processes may live on different machines.  (GFS and
CLVM are two examples which our group also develop; GFS using the dlm from
the kernel and CLVM from userspace.)

We've done a lot of work in this second version to meet the kernel's
conventions.  Comments and suggestions are welcome; we're happy to answer
questions and make changes so this can be a widely useful feature for
people running Linux clusters.

The dlm requires configuration from userspace.  In particular, it needs to
be told which other nodes it should work with, and provided with their IP
addresses.  In a typical setup, a cluster-membership system in userspace
would do this configuration (the dlm is agnostic about what system that
is).  A command line tool can also be used to configure it manually.
(It's helpful to compare this with device-mapper where dmsetup/LVM2/EVMS
are all valid userland alternatives for driving device-mapper.)

Features _not_ in this patchset that can be added incrementally:
. hierarchical parent/child locks
. lock querying interface
. deadlock handling, lock timeouts
. configurable method for master selection (e.g. static master
  assignment with no resource directory)

Background: we began developing this dlm from the ground up about 3 years
ago at Sistina.  It became GPL after the Red Hat acquisition.

The following patches are against 2.6.12-rc3 and do not touch any existing
files in the kernel.

