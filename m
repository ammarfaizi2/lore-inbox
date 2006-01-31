Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWAaGjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWAaGjq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 01:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWAaGjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 01:39:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28889 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932340AbWAaGjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 01:39:46 -0500
Date: Tue, 31 Jan 2006 01:39:39 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: more cfq spinlock badness
Message-ID: <20060131063938.GA1876@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not seen this break for a while, but I just hit it again in 2.6.16rc1-git4.

		Dave

BUG: spinlock bad magic on CPU#0, pdflush/1128
 lock: ffff81003a219000, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0

Call Trace: <ffffffff80206edc>{spin_bug+177} <ffffffff80207045>{_raw_spin_lock+25}
       <ffffffff801fea4a>{cfq_exit_single_io_context+85} <ffffffff801ff9a6>{cfq_exit_io_context+24}
       <ffffffff801f79b0>{exit_io_context+137} <ffffffff80135fbc>{do_exit+182}
       <ffffffff8010ba49>{child_rip+15} <ffffffff80146087>{keventd_create_kthread+0}
       <ffffffff8014629c>{kthread+0} <ffffffff8010ba3a>{child_rip+0}
Kernel panic - not syncing: bad locking


