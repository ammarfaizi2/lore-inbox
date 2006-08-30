Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWH3RzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWH3RzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWH3RzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:55:21 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:15841 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751206AbWH3RzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:55:19 -0400
Date: Wed, 30 Aug 2006 10:54:34 -0700
From: Paul Jackson <pj@sgi.com>
To: paulmck@us.ibm.com
Cc: ego@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       arjan@infradead.org, rusty@rustcorp.com.au, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@intel.linux.com,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug
Message-Id: <20060830105434.d00ae4dc.pj@sgi.com>
In-Reply-To: <20060830151405.GD1296@us.ibm.com>
References: <20060824140342.GI2395@in.ibm.com>
	<1156429015.3014.68.camel@laptopd505.fenrus.org>
	<44EDBDDE.7070203@yahoo.com.au>
	<20060824150026.GA14853@elte.hu>
	<20060825035328.GA6322@in.ibm.com>
	<20060827005944.67f51e92.pj@sgi.com>
	<20060829180511.GA1495@us.ibm.com>
	<20060829123102.88de61fa.pj@sgi.com>
	<20060829200304.GF1290@us.ibm.com>
	<20060829193828.d38395fe.pj@sgi.com>
	<20060830151405.GD1296@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
> Well, my next question was going to be whether cpuset readers really
> need to exclude the writers, or whether there can be a transition
> period while the mastodon makes the change as long as it avoids stomping
> the locusts.  ;-)

The mastodon's (aka mammoths ;) may make a batch of several related
changes to the cpuset configuration.  What's important is that the
locusts see either none or all of the changes in a given batch, not
some intermediate inconsistent state, and that the locusts see the
change batches in the same order they were applied.

Off the top of my head, I doubt I care when the locusts see the
changes.  Some delay is ok, if that's your question.

But don't try too hard to fit any work you do to cpusets.  For now,
I don't plan to mess with cpuset locking anytime soon.  And when I
do next, it might be that all I need to do is to change the quick
lock held by the locusts from a mutex to an ordinary rwsem, so that
multiple readers (locusts) can access the cpuset configuration in
parallel.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
