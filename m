Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752391AbWCPQiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbWCPQiq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbWCPQip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:38:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59801 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752390AbWCPQip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:38:45 -0500
Date: Thu, 16 Mar 2006 08:38:36 -0800
From: Paul Jackson <pj@sgi.com>
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu_exclusive feature of cpuset broken?
Message-Id: <20060316083836.f598ff45.pj@sgi.com>
In-Reply-To: <20060316152848.GA6548@in.ibm.com>
References: <20060316152848.GA6548@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa wrote:
	# cd /dev/cpuset
	# mkdir a
	# /bin/echo 7 > cpus
	# /bin/echo 1 > cpu_exclusive

I have not seen anything resembling such a lockup.

However you are doing something odd here.

While you created a subcpuset 'a', you changed the
cpus and cpu_exclusive in the root cpuset.  This
changed -all- tasks to only be allowed to run on
cpu 7.

I'd guess you have some kernel thread or such that
really, really wants to run on some other cpu.

When I read you transcript, I expected it to say:

	# mkdir /dev/cpuset
	# mount -t cpuset cpuset /dev/cpuset	# s/none/cpuset/ - clearer
	# cd /dev/cpuset
	# mkdir a
	# cd a					# the missing step
	# /bin/echo 7 > cpus
	# /bin/echo 1 > cpu_exclusive

The s/none/cpuset/ in the mount command is just a nit.
That field shows up in various mount command error
messages, and 'cpuset' is alot clearer than 'none' in
such messages.

When I do your commands (without the 'cd a'), I don't
see any problem or hang on my Altix test box.  But that
probably just means I am not critically depending at that
moment on some kernel thread running on any particular cpu.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
