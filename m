Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbTDOXtk (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 19:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbTDOXtk 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 19:49:40 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:24678 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264164AbTDOXtj (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 19:49:39 -0400
Message-ID: <3E9C9B19.7000107@myrealbox.com>
Date: Tue, 15 Apr 2003 16:51:53 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
References: <fa.hdvi4hc.152sj34@ifi.uio.no> <fa.fnhqqrs.ok0028@ifi.uio.no>
In-Reply-To: <fa.fnhqqrs.ok0028@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt wrote:
> Patrick Mansfield wrote:
> 
>> On Sun, Apr 13, 2003 at 07:44:04PM +0200, Gert Vervoort wrote:
>>
>> Here is a patch against 2.5.67, can you try it out?
>>
>> I did not compile let alone run with this patch.
>>
>> We never hold the host_lock while calling the detect function (unlike the
>> io_request_lock, see the bizzare 2.4 code), so acquiring it inside
>> ppa_detect is very wrong. I don't know why your scsi scan did not hang.
>>
>> --- linux-2.5.67/drivers/scsi/ppa.c-orig    Mon Apr  7 10:31:47 2003
>> +++ linux-2.5.67/drivers/scsi/ppa.c    Tue Apr 15 11:54:34 2003
>> @@ -219,15 +219,12 @@
>>          printk("  supported by the imm (ZIP Plus) driver. If the\n");
>>          printk("  cable is marked with \"AutoDetect\", this is what 
>> has\n");
>>          printk("  happened.\n");
>> -        spin_lock_irq(hreg->host_lock);
>>          return 0;
>>      }
>>      try_again = 1;
>>      goto retry_entry;
>> -    } else {
>> -    spin_lock_irq(hreg->host_lock);
>> +    } else
>>      return 1;        /* return number of hosts detected */
>> -    }
>>  }
>>  
>>  /* This is to give the ppa driver a way to modify the timings (and other
> 
> 
> 
> Yes!  Thank you.  This patch fixes the segfault of modprobe that I've 
> been seeing for ages.

Hmm.  An important addendum --

I can mount and unmount the Zip disk as many times as I want, as long as
I don't eject the disk from the drive.

Once I eject the disk and insert it again, the mount commant just hangs
forever.  No error messages anywhere -- it just hangs.  I can't even
kill the mount command.  The only way out is to reboot and then all is
well again until the next time I eject the disk from the drive.

