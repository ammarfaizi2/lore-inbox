Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUCFAGV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 19:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUCFAGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 19:06:21 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:17820 "EHLO
	omta08.mta.everyone.net") by vger.kernel.org with ESMTP
	id S261498AbUCFAGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 19:06:17 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Fri, 5 Mar 2004 16:06:16 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel-User shared buffer
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.184.117]
X-Eon-Sig: AQHDJlhASRX4AAGdDQEAAAAB,7dec45460b687b3055dbcaaa76783c1c
Message-Id: <20040306000616.1D51F3953@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm trying to create a shared buffer for realtime communication
between the kernel and a userspace application.  All allocation
is done for the userspace task in the kernel, and the kernel is
to write to the ram from within syscalls made by other
processes.

I don't think remap_page_range will work for this application,
but I am unsure, and I am unsure of its usage besides.

The basic logic is pretty much as follows:

task_t *acl_daemon = tskacld;
acldata *waclque;
waclque = kmalloc(sizeof(acldata), GFP_KERN);
addr = map_to_user(acl_daemon, waclque, sizeof(acldata));
old_aclque->msg  = msg;
old_aclque->next = addr;
old_aclque->eval = ACL_EVAL_EVAL;

pretty much, I want to map system memory to userspace per task,
in the context of the core kernel.  This is NOT a driver or
loadable module.

If you could give me a source file and function name of a
function that does this or does something similar, I could
work from there.  I've already tried making do_mmap() call a
do_mmap_task() (which is the original do_mmap() with "current"
replaced with "tsk", and tsk passed), but I don't think this
helps me :/

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
