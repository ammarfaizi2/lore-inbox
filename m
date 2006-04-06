Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWDFH76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWDFH76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 03:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWDFH76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 03:59:58 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:45270 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S932150AbWDFH75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 03:59:57 -0400
Message-ID: <4434CA7A.6020802@dgreaves.com>
Date: Thu, 06 Apr 2006 08:59:54 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
Cc: Kurt Wall <kwall@kurtwerks.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: Re: Bonnie++ Burps on XFS
References: <20060406023445.GB5806@kurtwerks.com> <20060406125756.H1110920@wobbly.melbourne.sgi.com> <20060406151301.I1110920@wobbly.melbourne.sgi.com>
In-Reply-To: <20060406151301.I1110920@wobbly.melbourne.sgi.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:

>On Thu, Apr 06, 2006 at 12:57:56PM +1000, Nathan Scott wrote:
>  
>
>>On Wed, Apr 05, 2006 at 10:34:45PM -0400, Kurt Wall wrote:
>>    
>>
>>>I've been using bonnie++ off and on for a long time. Suddenly, it has
>>>started failing when run against an XFS filesystem situated on a SATA
>>>drive. Here's the output of a run:
>>>      
>>>
>>[ Please report these things to linux-xfs@oss.sgi.com... ]
>>
>>    
>>
>>>Delete files in sequential order...Bonnie: drastic I/O error (rmdir):
>>>      
>>>
>>Anything in your system log?
>>    
>>
>
>Lemme answer that for you - "no".  I've reproduced the problem,
>I'll get back to you once I've nutted out whats gone wrong.
>
>Thanks for reporting it.
>
>cheers.
>
>  
>
Me too.

2.6.16

I had filesystem corruption and needed ran xfs_repair.

After I finished I removed most of the lost and found bits but was left
with:

haze:/scratch/lost+found# ll
total 28
drwxr-xr-x   4 root root   38 2006-04-02 08:29 ./
drwxrwxrwx  26 root root 4096 2006-04-04 18:25 ../
drwxrwxr-x   2 1046 1046 8192 2006-04-02 08:30 658616481/
drwxrwxr-x   2 1046 1046 8192 2006-04-02 08:22 823441168/
haze:/scratch/lost+found# rmdir *
rmdir: `658616481': Directory not empty
rmdir: `823441168': Directory not empty
haze:/scratch/lost+found# ll *
658616481:
total 12
drwxrwxr-x  2 1046 1046 8192 2006-04-02 08:30 ./
drwxr-xr-x  4 root root   38 2006-04-02 08:29 ../

823441168:
total 12
drwxrwxr-x  2 1046 1046 8192 2006-04-02 08:22 ./
drwxr-xr-x  4 root root   38 2006-04-02 08:29 ../

Obviously I had an fs corruption (due to raid failure due to some bogus
libata errors) so this may not be the same thing.

David

-- 

