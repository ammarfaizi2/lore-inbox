Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270172AbTGPGSD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 02:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270173AbTGPGSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 02:18:03 -0400
Received: from palrel11.hp.com ([156.153.255.246]:31908 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S270172AbTGPGR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 02:17:59 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16148.61840.663255.863176@napali.hpl.hp.com>
Date: Tue, 15 Jul 2003 23:32:48 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch] e1000 TSO parameter
In-Reply-To: <20030715183911.1c18cc15.davem@redhat.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229169@orsmsx402.jf.intel.com>
	<20030714214510.17e02a9f.davem@redhat.com>
	<16147.37268.946613.965075@napali.hpl.hp.com>
	<20030714223822.23b78f9b.davem@redhat.com>
	<16148.34787.633496.949441@napali.hpl.hp.com>
	<20030715183911.1c18cc15.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 15 Jul 2003 18:39:11 -0700, "David S. Miller" <davem@redhat.com> said:

  >>  We could, but would it always be a win?  Especially for
  >> copy_from_user().  Most of the time, that data remains cached, so
  >> I don't think we'd want to use non-temporal stores on those (in
  >> general).  csum_and_copy_from_user() isn't well optimized yet.
  >> Let's see if I can find a volunteer... ;-)

  DaveM> No, I mean "bypass L2 cache on miss" for stores.  Don't tell
  DaveM> me IA64 doesn't have that? 8) I certainly didn't mean "always
  DaveM> bypass L2 cache" for stores :-)

What I'm saying is that I almost always want copy_user() to put the
destination data in the cache, even if it isn't cached yet.  Many
copy_user() calls are for for data structures that easily fit in the
cache and the data is usually used quickly afterwards.

As for cache-hints supported by IA64: the architecture supports
various non-temporal hints (non-temporal in 1st, 2nd, or all
cache-levels).  How these hints are implemented depends on the chip.
On McKinley, non-temporal hints are generally implemented by storing
the data in the cache without updating the LRU info.  So if the data
is already there, it will stay cached (until a victim is needed).

	--david
