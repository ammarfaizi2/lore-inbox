Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWD1UoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWD1UoH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 16:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWD1UoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 16:44:07 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:43935 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751234AbWD1UoG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 16:44:06 -0400
Date: Sat, 29 Apr 2006 02:11:16 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: "Mauricio Lin" <mauriciolin@gmail.com>
Cc: nagar@watson.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: schedstats: sched_info_switch() invocation without checking (prev != next) before
Message-ID: <20060428204116.GA8301@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <3f250c710604281216k79ebe2c8ie63fb337cec8481a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f250c710604281216k79ebe2c8ie63fb337cec8481a@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Look that sched_info_switch() is being invoked before verifying if the
> prev and next tasks are different or not. IMHO the more logical place
> to put sched_info_switch() function is inside the if (likely(prev !=
> next) { } block according to the comments mentioned previously.
> 
> Any comments?
> 

Yes, I think your analysis seems correct. There is an advantages
to calling sched_info_switch() before checking for prev != next in
the if (likely()).

if prev == next, sched_info_switch() updates the task and runqueue statistics
information (that helps keeping it up to date). This might be useful
for SCHED_FIFO.

-- 
					<---	Balbir
