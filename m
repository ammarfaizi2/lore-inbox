Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267666AbUH1UGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267666AbUH1UGz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267756AbUH1UGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:06:54 -0400
Received: from holomorphy.com ([207.189.100.168]:63400 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267666AbUH1UFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:05:50 -0400
Date: Sat, 28 Aug 2004 13:05:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [0/5] standardized waitqueue hashing
Message-ID: <20040828200549.GR5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch series consolidates the various instances of 
waitqueue hashing to use a uniform structure and share the per-zone
hashtable among all waitqueue hashers. This is expected to increase the
number of hashtable buckets available for waiting on bh's and inodes
and eliminate statically allocated kernel data structures for greater
node locality and reduced kernel image size. Some attempt was made to
look similar to Oleg Nesterov's suggested API in order to provide some
kind of credit for independent invention of something very similar (the
original versions of these patches predated my public postings on the
subject of filtered waitqueues).

These patches have the further benefit and intention of enabling aio
to use filtered wakeups by standardizing the data structure passed to
wake functions so that embedded waitqueue elements in aio structures
may be succesfully passed to the filtered wakeup wake functions, though
this patch series doesn't implement that particular functionality.

Successfully stress-tested on x86-64, and ia64 in recent prior versions.


-- wli
