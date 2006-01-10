Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030677AbWAJXDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030677AbWAJXDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030678AbWAJXDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:03:32 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:41966 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1030677AbWAJXDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:03:31 -0500
Subject: 2.6.15-rt3 + Open Posix Test Suite
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Content-Type: text/plain
Date: Tue, 10 Jan 2006 15:03:29 -0800
Message-Id: <1136934210.5756.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	It's worth noting that a few tests in the current Open Posix Test Suite
hang RT systems. 

Specifically this test (hope this url comes through),

http://cvs.sourceforge.net/viewcvs.py/*checkout*/posixtest/posixtestsuite/conformance/interfaces/sched_setparam/10-1.c?rev=1.2

sched_setparam test 10-1.c and I think 9-1.c .

The 10-1 test spawns some children at SCHED_FIFO priority 99 , then runs
the following,

void child_process(){
	alarm(2);

	while(1) {
		(*shmptr)++;
		sched_yield();
	}
}

I'm sure this is what's hanging the system, the yield() is one issue.
Another is why the alarm() is never delivered .

Daniel

