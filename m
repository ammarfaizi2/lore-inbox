Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVKNVbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVKNVbo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVKNVbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:31:44 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:18639 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932145AbVKNVbo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:31:44 -0500
Message-Id: <20051114212341.724084000@sergelap>
Date: Mon, 14 Nov 2005 15:23:41 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [RFC] [PATCH 00/13] Introduce task_pid api
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--

I'm part of a project implementing checkpoint/restart processes.
After a process or group of processes is checkpointed, killed, and
restarted, the changing of pids could confuse them.  There are many
other such issues, but we wanted to start with pids.

This patchset introduces functions to access task->pid and ->tgid,
and updates ->pid accessors to use the functions.  This is in
preparation for a subsequent patchset which will separate the kernel
and virtualized pidspaces.  This will allow us to virtualize pids
from users' pov, so that, for instance, a checkpointed set of
processes could be restarted with particular pids.  Even though their
kernel pids may already be in use by new processes, the checkpointed
processes can be started in a new user pidspace with their old
virtual pid.  This also gives vserver a simpler way to fake vserver
init processes as pid 1.  Note that this does not change the kernel's
internal idea of pids, only what users see.

The first 12 patches change all locations which access ->pid and
->tgid to use the inlined functions.  The last patch actually
introduces task_pid() and task_tgid(), and renames ->pid and ->tgid
to __pid and __tgid to make sure any uncaught users error out.

Does something like this, presumably after much working over, seem
mergeable?

thanks
-serge

