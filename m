Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbVJRUzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbVJRUzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 16:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbVJRUzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 16:55:20 -0400
Received: from main.gmane.org ([80.91.229.2]:50327 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751482AbVJRUzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 16:55:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Possible killer app for user space RCU+SMR
Date: Tue, 18 Oct 2005 16:55:13 -0400
Message-ID: <dj3n8k$7av$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been trying to come up with a good application for user space RCU+SMR.
This has been problematic since most apps these days are pretty bloated and
overloaded with features, so you're talking about a huge amount of effort which
is why I haven't done a lock-free database at this point but have been looking
for something a little more doable.

What about nscd, the name service cache daemon?   It's possible to rewrite the
cache data structures to be reader lock-free, put them into a shared memory
segment, and be able to resolve lookups from cache without any syscall or ipc
overhead.   If the lookup wasn't satisfied from cache then you would use a
syscall to communicate with nscd.   Is this worthwhile?  As it is, does the current
implementation of nscd provide actual performance benefits or is it just around for
the coolness factor?

Note this technique could be extended to allow direct reading of kernel data
structures mapped into shared memory segments as well if anyone found a
use for that.

--
Joe Seigh



