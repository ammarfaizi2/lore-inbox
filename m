Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265502AbUEZLp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUEZLp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265503AbUEZLp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:45:27 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:35685 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265502AbUEZLpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:45:12 -0400
Message-ID: <40B4833F.1060700@yahoo.com.au>
Date: Wed, 26 May 2004 21:45:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: mingo@elte.hu, lkml <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@zwane.ca>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: 2.6.7-rc1-bk: SMT scheduler bug / crashes on kernel boot
References: <1085568719.2666.53.camel@imp.csi.cam.ac.uk>	 <1085569838.2666.60.camel@imp.csi.cam.ac.uk>  <40B47F47.20504@yahoo.com.au> <1085571285.2666.75.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1085571285.2666.75.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> On Wed, 2004-05-26 at 12:28, Nick Piggin wrote:
> 
>>Anton Altaparmakov wrote:
>>
>>
>>>The kernel shows a warning about the number of siblings being 2 but only
>>>1 being detected.  Perhaps this is the cause of the problem.  Even if
>>
>>Probably this is the cause of the problem.
>>
>>What is the exact message?
> 
> 
> You can see it in the PNG I attached in the original post.  But here it
> is copied out:
> 
> WARNING: 1 siblings found for CPU0, should be 2
> 

OK thanks... I think I even wrote that :P

The problem is smp_num_siblings is set to 2, but phys_proc_id
doesn't seem to be set up right (or it could be cpu_callout_map).
That would cause the sched-domains to get set up wrong, sure. Maybe
we should just go bug in this case? Or try to fix up?

Anyone have any idea why this is happening?

