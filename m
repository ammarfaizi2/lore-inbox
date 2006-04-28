Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965190AbWD1BeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbWD1BeM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWD1BeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:34:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:31888 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965187AbWD1BeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:34:11 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:34:10 -0700
Message-Id: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
Subject: [PATCH 00/12] Resource Groups... formerly CKRM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

CKRM has gone through a major overhaul by removing some of the complexity,
cutting down on features and moving portions to userspace.

We have posted ckrm last week as an RFC:
infrastructure:
	http://www.ussg.iu.edu/hypermail/linux/kernel/0604.2/1297.html
numtasks controller:
	http://www.ussg.iu.edu/hypermail/linux/kernel/0604.2/1311.html
CPU controller:
	http://www.ussg.iu.edu/hypermail/linux/kernel/0604.2/1310.html

Diffstat of this patchset (including the numtasks controller that follows)
is:

	23 files changed, 2466 insertions(+), 5 deletions(-)

including Documentaion and comments.

This patchset will be followed with two controllers:
	- a simple controller, numtasks to control number of tasks
	- CPU controller, to control CPU resource.

Please consider these for inclusion in -mm tree.
--

Changes since last post:
 - CKRM has been replaced with Resource Groups
 - 'class' has been replaced with resource group
 - Limit the depth of the hierarchy.

---------
Patch Descriptions:

01/12 - controller_support

This patch defines data structures for defining a resource group and
resource controller.
Provides register/unregister functions for a controller.
Provides utility functions to get a controller's data structure.

02/12 - resource_group_support

Provides functions to alloc and free a user defined resource group.
Provides utility macro to walk through the resource group hierarchy.

03/12 - shares_support

Provides functions to set/get shares of a specific resource of a resource
group.
Defines a teardown function that is intended to be called when user
disables resource group (by umount of the configfs component).

04/12 - tasksupport

Adds logic to support adding/removing task to/from a resource group
Provides interface to set a task's resource group.

05/12 - tasksupport_fork_exit_init

Initializes and clears Resource Group specific information in a task
at fork() and exit().  Inititalizes Resource Groups (called from start_kernel)

06/12: task_procsupport

Adds an interface in /proc to get the name of a resource group to which a task
is attached.

07/12 - user_interface

Create the configfs component for managing Resource groups. Hooks up with
configfs. Provides functions for creating and deleting resource groups.

08/12 - user_interface_attr_support

Adds the basic attribute store and show functions. 

09/12 - user_interface_stats

Adds attr_store and attr_show support for stats file. 

10/12 - user_interface_shares

Adds attr_store and attr_show support for shares file. 

11/12 - user_interface_members

Adds attr_store and attr_show support for members file. 

12/12 - res_groups_docs

Documentation describing important Resource Groups components such as resource
group, shares, controllers, and the configfs based user interface.
--
Thanks & Regards,

chandra

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
