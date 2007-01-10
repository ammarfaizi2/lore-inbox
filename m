Return-Path: <linux-kernel-owner+w=401wt.eu-S964880AbXAJO1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbXAJO1K (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 09:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbXAJO1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 09:27:10 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:41221 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964880AbXAJO1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 09:27:08 -0500
Message-ID: <45A4F675.3080503@in.ibm.com>
Date: Wed, 10 Jan 2007 19:51:41 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061117)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com, dev@sw.ru, xemul@sw.ru,
       serue@us.ibm.com, vatsa@in.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, mbligh@google.com,
       winget@google.com, containers@lists.osdl.org, devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH 4/6] containers: Simple CPU accounting container
 subsystem
References: <20061222141442.753211763@menage.corp.google.com> <20061222145216.755437205@menage.corp.google.com>
In-Reply-To: <20061222145216.755437205@menage.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> This demonstrates how to use the generic container subsystem for a
> simple resource tracker that counts the total CPU time used by all
> processes in a container, during the time that they're members of the
> container.
> 
> Signed-off-by: Paul Menage <menage@google.com>
> 

Hi, Paul,

I have run into a problem running this patch on a powerpc box. Basically,
the machine panics as soon as I mount the container filesystem with

mount -t container -oall container /<mount point>, I see

cpu 0x2: Vector: 300 (Data Access) at [c0000001e7f2b8e0]
    pc: c000000000098b70: .cpuacct_charge+0x84/0xbc
    lr: c000000000060a3c: .account_user_time+0x60/0xb4
    sp: c0000001e7f2bb60
   msr: 8000000000009032
   dar: 48
 dsisr: 40000000
  current = 0xc0000001e7f0e800
  paca    = 0xc00000000071c300
    pid   = 0, comm = swapper

Analyzing the dump a bit further lead me to container_subsys_state().

I am trying to figure out the reason for the panic and trying to find
a fix. Since the introduction of whole hierarchy system, the debugging
has gotten a bit harder and taking longer, hence I was wondering if you
had any clues about the problem

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
