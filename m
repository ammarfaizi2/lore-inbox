Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWFIK52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWFIK52 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 06:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbWFIK52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 06:57:28 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:24234 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965091AbWFIK51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 06:57:27 -0400
Message-ID: <448952C2.1060708@in.ibm.com>
Date: Fri, 09 Jun 2006 16:21:46 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, jlan@sgi.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com> <20060609010057.e454a14f.akpm@osdl.org>
In-Reply-To: <20060609010057.e454a14f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 09 Jun 2006 03:41:04 -0400
> Shailabh Nagar <nagar@watson.ibm.com> wrote:
> 
> 
>>Hence, this patch introduces a configuration parameter
>>	/sys/kernel/taskstats_tgid_exit
>>through which a privileged user can turn on/off sending of per-tgid stats on
>>task exit.
> 
> 
> That seems a bit clumsy.  What happens if one consumer wants the per-tgid
> stats and another does not?

For all subsystems that re-use the taskstats structure from the exit path,
we have the issue that you mentioned. Thats because several statistics co-exist
in the same structure. These subsystems can keep their tgid-stats empty by not
filling up anything in fill_tgid() or using this patch to selectively enable/disable
tgid stats.

For other subsystems, they could pass tgidstats as NULL to taskstats_exit_send().

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
