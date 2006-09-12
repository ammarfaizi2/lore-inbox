Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWILWrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWILWrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWILWrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:47:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26042 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932316AbWILWrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:47:46 -0400
Message-ID: <45073901.8020906@redhat.com>
Date: Tue, 12 Sep 2006 18:47:29 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
References: <20060901110908.GB15684@skybase>
In-Reply-To: <20060901110908.GB15684@skybase>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> From: Hubertus Franke <frankeh@watson.ibm.com>
> From: Himanshu Raj <rhim@cc.gatech.edu>
> 
> [patch 1/9] Guest page hinting: unused / free pages.
> 
> A very simple but already quite effective improvement in the handling
> of guest memory vs. host memory is to tell the host when pages are
> free. 

Would it be an idea to place this interface in-between the
per-cpu free page lists and the buddy allocator, so we can
move a batch of pages around at once and do the hinting in
a batched fashion ?

That way the overhead will be acceptable not just on S390
(where things are millicoded), but also on hypervisor based
virtualization like Xen.

Easy enough to pass a vector of pages to the hypervisor.

-- 
What is important?  What you want to be true, or what is true?
