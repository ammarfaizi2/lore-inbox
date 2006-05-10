Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWEJCLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWEJCLe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWEJCLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:11:34 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:60375 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751227AbWEJCLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:11:33 -0400
Date: Tue, 9 May 2006 21:11:21 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       herbert@13thfloor.at, dev@sw.ru, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: [PATCH 0/9] nsproxy: Introduction
Message-ID: <20060510021121.GA32523@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch introduces a nsproxy (name taken from Andi Kleen's
suggestion) structure intended to encompass all per-process namespaces.
The second moves the fs namespace structure from the task-struct
into nsproxy.  The rest of the patches are mostly repeats of the utsname
patchset, except that they put the uts_ns structure into nsproxy
instead of the task_struct, and the exit_utsname is moved to mirror
exit_namespace (and exit_nsproxy) location.

Locking:
Currently i'm not doing any locking.  Any time the nsproxy->namespace is
unshare()d, nsproxy is first cloned.  So by definition the nsproxy
usage count is 1, and the task is locked.  So the current scheme of
locking task_struct when reading tsk->nsproxy->namespace should be ok.

-serge
