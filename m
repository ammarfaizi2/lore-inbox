Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVETKqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVETKqT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 06:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVETKqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 06:46:19 -0400
Received: from szxga01-in.huawei.com ([61.144.161.53]:7384 "EHLO huawei.com")
	by vger.kernel.org with ESMTP id S261406AbVETKqL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 06:46:11 -0400
Date: Fri, 20 May 2005 18:44:01 +0800
From: steve <lingxiang@huawei.com>
Subject: Re: Re: why nfs server delay 10ms in nfsd_write()?
To: Peter Staubach <staubach@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "zhangtiger@huawei.com" <zhangtiger@huawei.com>
Message-id: <0IGS00FKJBCKRE@szxml02-in.huawei.com>
MIME-version: 1.0
X-Mailer: Foxmail 4.2 [cn]
Content-type: text/plain; charset=GB2312
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
My envionment looks like that:

NFS Server£ºSuse9 Enterprise 
NFS Client£ºRedhat AS3.0(kernel 2.4.21) 

I made a ramdisk and export it with nfs
Server and Client are connected with 1000Mbps

mount the ramdisk on the client with parameters: -t nfs -o rw,noac

then test with iometer and the parameters are: 
Outstanding IO is 32, transfer request size is 512, sequential write
the result is about 300KB/s, iops is about 600

with dd test i find the delay most cost at the server.

i agree with Avi that "if the NFS client has no (or low) concurrency, then write gathering would
reduce preformance"


Regards! 				
Steve
2005-05-20

======= 2005-05-19 10:10:00 =======

>Lee Revell wrote:
>
>>On Thu, 2005-05-19 at 08:53 -0400, Peter Staubach wrote:
>>  
>>
>>>There are certainly many others way to get gathering, without adding an
>>>artificial delay.  There are already delay slots built into the code 
>>>which could
>>>be used to trigger the gathering, so with a little bit different 
>>>architecture, the
>>>performance increases could be achieved.
>>>
>>>Some implementations actually do write gathering with NFSv3, even.  Is
>>>this interesting enough to play with?  I suspect that just doing the 
>>>work for
>>>NFSv2 is not...
>>>    
>>>
>>
>>Also, how do you explain the big performance hit that steve observed?
>>Write gathering is supposed to help performance, but it's a big loss on
>>his test...
>>
>
>Well, a little bit more information about what he is doing would be 
>helpful.  I'd
>like to better understand the environment and what the traffic from the 
>client
>looks like.
>
>Write gathering is not a panacea for all of the ills caused by the NFSv2 
>WRITE
>stable storage requirements.  In fact, if done wrong, it can cause 
>performance
>regressions, such as those being noticed by Steve.
>
>--
>
>I implemented the write gathering used in Solaris and experimented with
>several (many?) different approachs.  Adding a delay in order to allow
>subsequent WRITE requests to arrive seems like a good thing, but can
>end up just adding latency to the entire process if not done right.
>
>A suggestion might be to use the delay caused by the nfsd_sync() call
>and synchronize other WRITE requests around that.  The delay caused by
>doing real i/o to the storage subsystem should allow write gathering to
>take place, assuming that the client is generating concurrent WRITE
>requests.
>
>       ps





