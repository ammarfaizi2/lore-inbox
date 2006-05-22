Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWEVTcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWEVTcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWEVTcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:32:53 -0400
Received: from cyrus.iparadigms.com ([64.140.48.8]:61180 "EHLO
	cyrus.iparadigms.com") by vger.kernel.org with ESMTP
	id S1751148AbWEVTcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:32:52 -0400
Message-ID: <447211E1.7080207@iparadigms.com>
Date: Mon, 22 May 2006 12:32:49 -0700
From: fitzboy <fitzboy@iparadigms.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
CC: linux-kernel@vger.kernel.org
Subject: Re: tuning for large files in xfs
References: <447209A8.2040704@iparadigms.com> <44720DB8.4060200@argo.co.il>
In-Reply-To: <44720DB8.4060200@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That makes sense, but how come the numbers for the large file (2TB)
doesn't seem to match with the Avg. Seek Time that 15k drives have? Avg
Seek Time for those drives are in the 5ms range, and I assume they
aren't just seeking in the first couple tracks when they come up with
that number (and Bonnie++ confirms this too). Any thoughts on why it is
double for me when I use the drives?

Avi Kivity wrote:
> fitzboy wrote:
> 
>>
>> BUT... here is what I need to understand, the filesize has a drastic
>> effect on performance. If I am doing random reads from a 20GB file
>> (system only has 2GB ram, so caching is not a factor), I get
>> performance about where I want it to be: about 5.7 - 6ms per block. But
>> if that file is 2TB then the time almost doubles, to 11ms. Why is this?
>> No other factors changed, only the filesize.
>>
> 
> With the 20GB file, the disk head is seeking over 1% of the tracks. With 
> the 2TB file, it is seeking over 100% of the tracks.
> 
>>
>> I am assuming that somewhere along the way, the kernel now has to do an
>> additional read from the disk for some metadata for xfs... perhaps the
>> btree for the file doesn't fit in the kernel's memory? so it actually
>> needs to do 2 seeks, one to find out where to go on disk then one to
> 
> 
> No, the btree should be completely cached fairly soon into the test.
> 
>> get the data. Is that the case? If so, how can I remedy this? How can I
>> tell the kernel to keep all of the files xfs data in memory?
> 
> 
> Add more disks. If you're writing, use RAID 1.
> 

