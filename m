Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTKTXwx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 18:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbTKTXwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 18:52:53 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:1636 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263765AbTKTXwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 18:52:49 -0500
Date: Thu, 20 Nov 2003 15:52:11 -0800
From: Paul Jackson <pj@sgi.com>
To: mochel@osdl.org
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: What keeps drivers/base/sys.c sysdev_show() from overrunning
 buffer?
Message-Id: <20031120155211.5cd2897a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The calls in drivers/base/sys.c to sysdev_show(), which seem to resolve
to the routines node_read_cpumap() and node_read_meminfo() in node.c,
do not take any buffer count (size).  They used to, by Patrick removed
the count parameter in Jan 2003, from here and other such places.

What's to keep the node_read_*() sprintf's from overrunning these
buffers?

I am developing some changes to the cpumask_t print routines, which
include using snprintf() instead of sprintf(), and watching buffer
limits.  These changes are motivated by the need to handle such things
as 512 CPUs.

I couldn't plug my new routine into read_cpumap() to display the
node_dev->cpumap (a cpumask_t), for want of a buffer count.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
