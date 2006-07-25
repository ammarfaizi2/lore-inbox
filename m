Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWGYUrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWGYUrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWGYUrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:47:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14997 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751578AbWGYUrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:47:40 -0400
Date: Tue, 25 Jul 2006 16:46:24 -0400
From: Dave Jones <davej@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: remove cpu hotplug bustification in cpufreq.
Message-ID: <20060725204624.GF13829@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com> <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org> <20060725185449.GA8074@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725185449.GA8074@elte.hu>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 08:54:49PM +0200, Ingo Molnar wrote:
 > 
 > * Linus Torvalds <torvalds@osdl.org> wrote:
 > 
 > > The current -git tree will complain about some of the more obvious 
 > > problems. If you see a "Lukewarm IQ" message, it's a sign of somebody 
 > > re-taking a cpu lock that is already held.
 > testing on my latest-rawhide laptop (kernel-2.6.17-1.2445.fc6 and later 
 > rpms have this change) seems to have pushed the problem over to another 
 > lock:
 > 
 >   S06cpuspeed/1580 is trying to acquire lock:
 >    (&policy->lock){--..}, at: [<c06075f9>] mutex_lock+0x21/0x24
 > 
 >   but task is already holding lock:
 >    (cpu_bitmask_lock){--..}, at: [<c06075f9>] mutex_lock+0x21/0x24
 > 
 >   which lock already depends on the new lock.
 > 
 > and we also get the:
 > 
 >   Lukewarm IQ detected in hotplug locking
 > 
 > message :-| Find the full bootlog below. And i dont understand the 
 > cpufreq code well enough to fix this. In fact, does anyone understand 
 > it? :-/

Things used to be fairly simple until hotplug cpu came along :-/
Each day, I'm getting more of the opinion that my patch just ripping
out this garbage is the right solution.

		Dave

-- 
http://www.codemonkey.org.uk
