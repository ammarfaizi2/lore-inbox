Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031724AbWLGGps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031724AbWLGGps (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 01:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031727AbWLGGps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 01:45:48 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:53965 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031724AbWLGGpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 01:45:47 -0500
Date: Thu, 7 Dec 2006 12:15:12 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Myron Stowe <myron.stowe@hp.com>, Jens Axboe <axboe@kernel.dk>,
       Dipankar <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-ID: <20061207064512.GA27583@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200612061726.14587.bjorn.helgaas@hp.com> <20061207061701.GA25744@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207061701.GA25744@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 11:47:01AM +0530, Srivatsa Vaddagiri wrote:
> 	- Make it rw-sem

I think rw-sems also were shown to hit deadlocks (recursive read-lock
attempt deadlocks when a writer comes between the two read attempts by the same
thread). So below suggestion only seems to makes sense ..

> 	- Make it per-cpu mutex, which could be either:
> 
> 		http://lkml.org/lkml/2006/11/30/110 - Ingo's suggestion
> 		http://lkml.org/lkml/2006/10/26/65 - Gautham's work based on RCU
> 
> In Ingo's suggestion, I really dont know if the task_struct
> modifications is a good thing (to support recursive requirements).
> Gautham's patches avoid modifications to task_struct, is fast but can
> starve writers (who want to bring down/up a CPU).

-- 
Regards,
vatsa
