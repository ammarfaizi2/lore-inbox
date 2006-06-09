Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWFIPlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWFIPlq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWFIPlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:41:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:49293 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030219AbWFIPlp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:41:45 -0400
Message-ID: <44899562.6010609@in.ibm.com>
Date: Fri, 09 Jun 2006 21:06:02 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: nagar@watson.ibm.com, jlan@sgi.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org>
In-Reply-To: <20060609042129.ae97018c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 09 Jun 2006 16:21:46 +0530
> Balbir Singh <balbir@in.ibm.com> wrote:
> 
> 
>>Andrew Morton wrote:
>>
>>>On Fri, 09 Jun 2006 03:41:04 -0400
>>>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>>>
>>>
>>>
>>>>Hence, this patch introduces a configuration parameter
>>>>	/sys/kernel/taskstats_tgid_exit
>>>>through which a privileged user can turn on/off sending of per-tgid stats on
>>>>task exit.
>>>
>>>
>>>That seems a bit clumsy.  What happens if one consumer wants the per-tgid
>>>stats and another does not?
>>
>>For all subsystems that re-use the taskstats structure from the exit path,
>>we have the issue that you mentioned. Thats because several statistics co-exist
>>in the same structure. These subsystems can keep their tgid-stats empty by not
>>filling up anything in fill_tgid() or using this patch to selectively enable/disable
>>tgid stats.
>>
>>For other subsystems, they could pass tgidstats as NULL to taskstats_exit_send().
>>
> 
> 
> I don't understand.  If a subsystem exists then it fills in its slots in
> the taskstats structure, doesn't it?
> 
> No other subsystem needs a global knob, does it?
> 
> You see the problem - if one userspace package wants the tgid-stats and
> another concurrently-running one does now, what do we do?  Just leave it
> enabled and run a bit slower?

Another option is to get the package to define their own taskstats genetlink 
attribute and fill it up in taskstats_exit_send(). This would be similar to
TASKSTATS_TYPE_AGGR_PID/TGID.

They can make this attribute independent of the taskstats structure and fill
it based on their policy (per-pid or per-tgid). But the current interface
users like CSA want to build on top of the taskstats structure.

> 
> If so, how much slower?  Your changelog says some potential users don't
> need the tgid-stats, but so what?  I assume this patch is a performance
> thing?  If so, has it been quantified?
> 


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
