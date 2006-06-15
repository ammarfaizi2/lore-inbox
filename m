Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031069AbWFOS5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031069AbWFOS5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 14:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031113AbWFOS5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 14:57:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62119 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1031106AbWFOS5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 14:57:12 -0400
Message-ID: <4491AD81.4040700@sgi.com>
Date: Thu, 15 Jun 2006 11:57:05 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: balbir@in.ibm.com
Cc: Shailabh Nagar <nagar@watson.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Sturtivant <csturtiv@sgi.com>
Subject: Re: ON/OFF control of taskstats accounting data at do_exit
References: <449093D6.6000806@engr.sgi.com> <4490CDC2.3090009@watson.ibm.com> <4490D515.8070308@engr.sgi.com> <449182FB.6020907@watson.ibm.com> <449197D3.3090109@sgi.com> <4491A398.4050204@in.ibm.com>
In-Reply-To: <4491A398.4050204@in.ibm.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> 
>> For that reason, i think exposing the switch at sysfs is not a good
>> idea. Instead, /etc/init.d/taskstats script would be right for
>> this purpose. At kernel side, we would need to make this possible.
> 
> 
> When you say we need to make this possible at the kernel side, do you
> want the kernel not to accumulate taskstats in the do_exit() path
> (avoid calling fill_xxxx routines) if there are no listeners
> on TASKSTATS_LISTEN_GROUP? As Shailabh, mentioned sending out does not
> happen if there are no listeners.

I did not understand that when i made the request because i did not
see from taskstats code how you can control that. Shailabh later said
that it was done at netlink layer.

I do not know how deep down in netlink layer to exit the proces,
but it may turn out that the need of this feature not that importan...

Yet, we still allocate memory, fill taskstats struct, invoke netlink,
and free memory. Ideally when taskstats is turned off, we do not need
to do any of these. So, if we can fail memory allocation when taskstats
is turned off, the taskstats_exit_send() will return right away.

To answer Shailabh's discussion in a separate email, yes, i meant
the second case that all taskstats applications will be stopped or
suspended. The different between a /etc/init.d/taskstats and a
sysfs/procfs control of taskstats is that the system will not
be activated at init time. However, i admit customers can always turn
off taskstats via sysfs before starts whatever they like to do.

I do not know what is community's preference: a /etc/init.d mechnism
or a sysfs mechnism. I would be happy either way. Thanks!

Regards,
  jay


> 
>>
>> What do you think?
>>
>> Regards,
>>  - jay
>>

