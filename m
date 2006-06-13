Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWFMUZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWFMUZd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWFMUZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:25:33 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:1811 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932074AbWFMUZd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:25:33 -0400
Message-ID: <448F1F35.4020109@argo.co.il>
Date: Tue, 13 Jun 2006 23:25:25 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Theodore Tso <tytso@mit.edu>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
References: <Pine.LNX.4.61.0606132209420.11918@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0606132209420.11918@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2006 20:25:31.0252 (UTC) FILETIME=[84492340:01C68F27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>> if (inode->i_ops->getblksize)
>>>>     return inode->i_ops->getblksize(inode);
>>>> else
>>>> return inode->i_sb->s_blksize;
>>>>
>>>> Trading some efficiency for space.
>>>>         
>>> Yep, that was what I was planning on doing....
>>>
>>>       
>> Maybe
>>
>> if (inode->i_sb->s_blksize)
>>   return inode->i_sb->s_blksize;
>> else
>> ...
>>
>> is a tiny little bit faster...
>>
>>     
>
> The compiler will anyway pick the one it thinks is better by itself.
> Influence can be taken using likely/unlikely of course.
>   

The compiler cannot infer that (inode->i_ops->getblksize == 0) is 
equivalent to (inode->i_sb->s_blksize != 0).

Maybe someday the language will allow us to specify it, but not today.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

