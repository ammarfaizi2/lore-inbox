Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbTCGLlB>; Fri, 7 Mar 2003 06:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261538AbTCGLlB>; Fri, 7 Mar 2003 06:41:01 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:46253 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261535AbTCGLlB>;
	Fri, 7 Mar 2003 06:41:01 -0500
Message-Id: <200303071151.h27BpB415705@owlet.beaverton.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: NUMA scheduler broken 
In-reply-to: Your message of "Fri, 07 Mar 2003 00:30:30 PST."
             <324180000.1047025830@[10.10.2.4]> 
Date: Fri, 07 Mar 2003 03:51:11 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like __activate_task() should call nr_running_inc(rq) rather than
rq->nr_running++, and the same in wake_up_forked_process().  My guess
is that the bogus node_nr_running value is causing some really poor
scheduling decisions to be made on NUMA.  See if that changes your result.

Rick
