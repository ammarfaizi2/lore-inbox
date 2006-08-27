Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWH0JL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWH0JL1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 05:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWH0JL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 05:11:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:46302 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751352AbWH0JL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 05:11:26 -0400
Date: Sun, 27 Aug 2006 02:10:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Keith Owens <kaos@sgi.com>
Cc: ego@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       arjan@infradead.org, rusty@rustcorp.com.au, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@intel.linux.com,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug
Message-Id: <20060827021055.61c9d44f.pj@sgi.com>
In-Reply-To: <9747.1156668129@ocs10w.ocs.com.au>
References: <20060827005944.67f51e92.pj@sgi.com>
	<9747.1156668129@ocs10w.ocs.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith wrote:
> Updaters (which by
> definition are extremely rare) stop all other cpus, do their work then
> restart_machine().

Cpuset updaters are rare, but they are not -that- rare.

And the cpuset file system allows one to configure some
cpusets to be modifiable by any end user.

One would not want such an end user to be able to stop
the machine at will by manipulating the cpusets they
are allowed to modify.

Nor would one want the cpuset actions done by say a
batch scheduler during one jobs setup to bring all the
other presently active jobs to a grinding halt.

So perhaps taking CPUs offline merits a stop_machine().

But I've little desire to stop_machine() when modifying
cpusets.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
