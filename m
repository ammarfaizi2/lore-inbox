Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUDAAQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 19:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbUDAAQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 19:16:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18386 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262143AbUDAAQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 19:16:26 -0500
Message-ID: <406B5F4C.10000@pobox.com>
Date: Wed, 31 Mar 2004 19:16:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Boutcher <sleddog@us.ibm.com>
CC: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ibmvscsi driver - sixth version
References: <opr3u0ffo7l6e53g@us.ibm.com> <20040225134518.A4238@infradead.org>  <opr3xta6gbl6e53g@us.ibm.com> <1079027038.2820.57.camel@mulgrave> <opr5qwiyw4l6e53g@us.ibm.com> <406B3FDA.9010507@pobox.com> <opr5q1enb6l6e53g@us.ibm.com>
In-Reply-To: <opr5q1enb6l6e53g@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Boutcher wrote:
> On Wed, 31 Mar 2004 17:02:02 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> Comments:
>>
>> 1) Would be nice to eliminate  module options for commands-per-lun, 
>> max-requests etc. and actually have the driver figure out the real 
>> needs.  One or two options could fall into the "performance tuning" 
>> category, and stay, but the others are really dependent on the 
>> underlying configuration and underlying limits.
> 
> Hmmm...well, I could collapse the two together, since commands_per_lun
> is not limited by anything specific for this adapter.  I would prefer
> to leave them broken out to handle users who have extreme requirements.

"Do what you need to do, and no more."

Don't engineer code because users _might_ have some outlandish requirement.


>> 2) why is one-descriptor a special case in map_sg_data()?  You proceed 
>> to do the same thing in a loop, right below that...  AFAICS you can 
>> just use the loop, and clamp the number of scatterlist elements to one.
> 
> The SRP spec has two different buffer formats: SRP_DIRECT_BUFFER for a
> single buffer, and SRP_INDIRECT_BUFFER for lists of buffers, and the
> layout of the buffers in the request is different for those two cases.

My mistake here -- I was misreading the code as testing both 
DIRECT_BUFFER and INDIRECT_BUFFER in both the loop and non-sg case.


>> 10) what the heck is this???  do some people not know they are running 
>> Linux???
>> +static ssize_t show_host_os_type(struct class_device *class_dev, char 
>> *buf)
> 
> This whole driver has to do with adapter sharing....and this answers
> the question with whom you are sharing it.  Which may in fact NOT
> be Linux.

ewwww ;-)


>> 12) in ibmvscsi_probe(), you want to use TASK_UNINTERRUPTIBLE here:
>>
>> +            set_current_state(TASK_INTERRUPTIBLE);
>> +            schedule_timeout(5);
>>
>> 13) in the code pasted in #12, you should pass a value calculated 
>> using the 'HZ' constant.
> 
> Hmmm...above code copied from the qlogic driver...and it looked reasonable
> to me, but I'll tweak it.

Well, qlogic is wrong too.  Do you want to submit a patch fixing qlogic 
while you're at it?  ;-)

	Jeff



