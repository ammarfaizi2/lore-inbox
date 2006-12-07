Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163191AbWLGSbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163191AbWLGSbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163193AbWLGSbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:31:20 -0500
Received: from zrtps0kp.nortel.com ([47.140.192.56]:43879 "EHLO
	zrtps0kp.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163191AbWLGSbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:31:18 -0500
Message-ID: <45785DDD.3000503@nortel.com>
Date: Thu, 07 Dec 2006 12:30:53 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: additional oom-killer tuneable worth submitting?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2006 18:31:05.0031 (UTC) FILETIME=[DAD0B570:01C71A2D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The kernel currently has a way to adjust the oom-killer score via 
/proc/<pid>/oomadj.

However, to adjust this effectively requires knowledge of the scores of 
all the other processes on the system.

I'd like to float an idea (which we've implemented and been using for 
some time) where the semantics are slightly different:

We add a new "oom_thresh" member to the task struct.
We introduce a new proc entry "/proc/<pid>/oomthresh" to control it.

The "oom-thresh" value maps to the max expected memory consumption for 
that process.  As long as a process uses less memory than the specified 
threshold, then it is immune to the oom-killer.

On an embedded platform this allows the designer to engineer the system 
and protect critical apps based on their expected memory consumption. 
If one of those apps goes crazy and starts chewing additional memory 
then it becomes vulnerable to the oom killer while the other apps remain 
protected.

If a patch for the above feature was submitted, would there be any 
chance of getting it included?  Maybe controlled by a config option?

Chris
