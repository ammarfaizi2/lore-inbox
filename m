Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261692AbSI0MXb>; Fri, 27 Sep 2002 08:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261694AbSI0MXb>; Fri, 27 Sep 2002 08:23:31 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:23826 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S261692AbSI0MXa>; Fri, 27 Sep 2002 08:23:30 -0400
Message-ID: <3D944EE9.6020702@myrealbox.com>
Date: Fri, 27 Sep 2002 14:28:25 +0200
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: Jens Axboe <axboe@suse.de>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file
 transfers
References: <20020925232736.A19209@shookay.newview.com> <20020926061419.GA12862@suse.de> <3D92B17C.9030504@myrealbox.com> <3870780000.1033054272@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs wrote:
>>    I reported this same problem some weeks ago -
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=103069116227685&w=2 .
>>2.4.20pre kernels solved the error messages flooding the console, and
>>improved things a bit, but system load still got very high and disk read
>>and write performance was lousy. Adding more memory and using a
>>completely different machine didn't help. What did? Changing the Adaptec
>>scsi driver to aic7xxx_old . The performance was up 50% for writes and
>>90% for reads, and the system load was acceptable. And i didn't even had
>>to change the RedHat kernel (2.4.18-10) for a custom one. The storage was
>>two external Arena raid boxes, btw.
> 
> 
> I would be interested in knowing if reducing the maximum tag depth for
> the driver improves things for you.  There is a large difference in the
> defaults between the two drivers.  It has only reacently come to my
> attention that the SCSI layer per-transaction overhead is so high that
> you can completely starve the kernel of resources if this setting is too
> high.  For example, a 4GB system installing RedHat 7.3 could not even
> complete an install on a 20 drive system with the default of 253 commands.
> The latest version of the aic7xxx driver already sent to Marcelo drops the
> default to 32.
> 
> --
> Justin
> 
> 
> 

    I have a server available to test it, but the storage in question is 
already deployed. Yet, by luck (irony apart) i have a maintenance window 
this weekend for tuning and other matters, i can decrease the maximum 
number of TCQ commands per device in the proper aic7xxx driver to 32 and 
  report on the results. While trying to solve this problem i browsed 
RedHat's bugzilla, and there were several people burned with this 
problem. Hope this sorts it out for them.


/Pedro

