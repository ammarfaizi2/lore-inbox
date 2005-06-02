Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVFBMbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVFBMbY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 08:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVFBMbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 08:31:24 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:17128 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S261394AbVFBMbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 08:31:13 -0400
Message-ID: <429EFC0D.9020703@stud.feec.vutbr.cz>
Date: Thu, 02 Jun 2005 14:31:09 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: RT patch breaks X86_64 build
References: <200505302141.31731.kernel-stuff@comcast.net> <200505302201.48123.kernel-stuff@comcast.net> <429BFF51.4000401@stud.feec.vutbr.cz> <200505310753.49447.kernel-stuff@comcast.net> <429C530E.70704@stud.feec.vutbr.cz> <20050601091344.GB11703@elte.hu>
In-Reply-To: <20050601091344.GB11703@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------050204070507020800020600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050204070507020800020600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ingo,

I don't see why /proc/sys/kernel/preempt_{max_latency,thresh} should not 
be readable for all users. They already can see much more detailed 
information in /proc/latency_trace.

Michal

--------------050204070507020800020600
Content-Type: text/plain;
 name="rt-latency-procfiles.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt-latency-procfiles.diff"

--- linux-RT.mich/kernel/latency.c.orig	2005-06-02 13:42:23.000000000 +0200
+++ linux-RT.mich/kernel/latency.c	2005-06-02 12:57:05.000000000 +0200
@@ -1809,14 +1809,14 @@ static __init int latency_init(void)
 {
 	struct proc_dir_entry *entry;
 
-	entry = create_proc_entry("sys/kernel/preempt_max_latency", 0600, NULL);
+	entry = create_proc_entry("sys/kernel/preempt_max_latency", 0644, NULL);
 
 	entry->nlink = 1;
 	entry->data = &preempt_max_latency;
 	entry->read_proc = preempt_read_proc;
 	entry->write_proc = preempt_write_proc;
 
-	entry = create_proc_entry("sys/kernel/preempt_thresh", 0600, NULL);
+	entry = create_proc_entry("sys/kernel/preempt_thresh", 0644, NULL);
 
 	entry->nlink = 1;
 	entry->data = &preempt_thresh;

--------------050204070507020800020600--
