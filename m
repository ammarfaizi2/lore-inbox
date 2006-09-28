Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWI1XqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWI1XqH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWI1XqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:46:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53733 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751205AbWI1XqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:46:04 -0400
Date: Thu, 28 Sep 2006 16:45:36 -0700
From: Paul Jackson <pj@sgi.com>
To: menage@google.com
Cc: akpm@osdl.org, ckrm-tech@lists.sourceforge.net, mbligh@google.com,
       rohitseth@google.com, winget@google.com, dev@sw.ru, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/4] Generic container system abstracted from
 cpusets code
Message-Id: <20060928164536.84039937.pj@sgi.com>
In-Reply-To: <20060928111407.762783000@menage.corp.google.com>
References: <20060928104035.840699000@menage.corp.google.com>
	<20060928111407.762783000@menage.corp.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Be sure to spell out, if you haven't already, that there is just a
single container hierarchy, with each task attached to a single
container in that hierarchy, and each subsystem (e.g. cpusets)
adding its own special files to the common container hierarchy
directories.

It is not the case that each subsystem using containers gets to
concoct its own hierarchy, independent of any other subsystem.

Menage wrote:
> +config CONTAINERS
> +	bool "Container support"
> +	help
> +	  This option will let you create and manage process containers,
> +	  which can be used to aggregate multiple processes, e.g. for
> +	  the purposes of resource tracking.

I wonder if this should be a configurable ... perhaps not.

If someone configures in one or more of the subsystems, such as
cpusets, that requires CONTAINERS, then we need to enable containers.
Otherwise we don't need to enable CONTAINERS.  I don't see what
user input we need here specific to CONTAINERS.

> + *  Copyright (C) 2003 BULL SA.
> + *  Copyright (C) 2004-2006 Silicon Graphics, Inc.

Perhaps you want to add a Google or Menage copyright here?

> + *  2003-10-22 Updates by Stephen Hemminger.
> + *  2004 May-July Rework by Paul Jackson.

Perhaps time for another log line here, such as:
  + *  2006 Generalized to containers by Paul Menage.

> +	struct list_head sibling;	/* my parents children */
> +	struct list_head children;	/* my children */
> +
> +	struct container *parent;		/* my parent */
> +	struct dentry *dentry;		/* container fs entry */

Delete extra tab after semi-colon on parent line.

> + 2) mount -t container none /dev/container

(Yes - this pertains to something this you took as is from the current
cpuset docmentation ...)  Please don't use 'none' for this argument to
mount.  Use some string relevant to the type of filesystem being
mounted.  This argument shows up in error messages from mount, and as
it notes in the mount(8) man page, when speaking of the proc file
system, though it applies here too:

       The  proc file system is not associated with a special device, and when
       mounting it, an arbitrary keyword, such as proc can be used instead  of
       a  device specification.  (The customary choice none is less fortunate:
       the error message `none busy' from umount can be confusing.)

For example, make the above:

       mount -t container container /dev/container

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
