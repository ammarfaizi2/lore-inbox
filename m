Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751745AbWCUOwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWCUOwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbWCUOwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:52:34 -0500
Received: from zcars04e.nortel.com ([47.129.242.56]:42947 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP
	id S1751743AbWCUOwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:52:33 -0500
Message-ID: <44201325.2010008@nortel.com>
Date: Tue, 21 Mar 2006 08:52:21 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: help with SMP debugging...task struct corruption
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2006 14:52:21.0950 (UTC) FILETIME=[0F08B5E0:01C64CF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running a customized 2.6.10 and seeing some interesting behaviour. 
Based on some additional debugging that we added, the "p->signal" member 
is being set to NULL between the time we call spin_lock() and the time 
we return from it.

Anyone have any ideas what might be going on?  It seems to go away if we 
boot with only 1 cpu.  I assume that some other cpu already holds that 
lock and does something while holding it that causes the "p->signal" 
member to become NULL.


void release_task(struct task_struct * p)
{
	int zap_leader;
	task_t *leader;
	struct dentry *proc_dentry;

repeat:
	atomic_dec(&p->user->processes);
	spin_lock(&p->proc_lock);
	proc_dentry = proc_pid_unhash(p);



Thanks,

Chris
