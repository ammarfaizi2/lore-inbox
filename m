Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265501AbUFICLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbUFICLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 22:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265484AbUFICLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 22:11:39 -0400
Received: from lips.borg.umn.edu ([160.94.232.50]:22721 "EHLO
	lips.borg.umn.edu") by vger.kernel.org with ESMTP id S265501AbUFICLb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 22:11:31 -0400
In-Reply-To: <20040609095109.E1200131@wobbly.melbourne.sgi.com>
References: <20040608154422.GA3946@thumper2> <20040609095109.E1200131@wobbly.melbourne.sgi.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7DA16A7A-B9BA-11D8-BA43-000393020C0A@thebarn.com>
Content-Transfer-Encoding: 7bit
Cc: cattelan@sgi.com, Andy <genanr@emsphone.com>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
From: Russell Cattelan <cattelan@xfs.org>
Subject: Re: NFS corruption (duplicated data)
Date: Tue, 8 Jun 2004 21:12:43 -0500
To: Nathan Scott <nathans@sgi.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ya it's probably the same problem.

To really understand what is going on in terms of corruption
pattern up the disk with a known pattern and re-run the test.

If the corrupted areas show up as the known pattern you are dealing
with stale disk data and not data from the wrong file/process.

And at that point I would definitely say it's bug:
http://oss.sgi.com/bugzilla/show_bug.cgi?id=198
On Jun 8, 2004, at 6:51 PM, Nathan Scott wrote:

> Hi Andy,
>
> Be good to try this with files served from ext2/3 as well,
> to try isolate it to XFS/NFS.  We have a known issue thats
> possibly related to this in XFS - Russell, does this sound
> like that problem you've been looking at?
>
> If you have a simple test case to reproduce it (we have an
> extremely complex test case to reproduce that other issue,
> but from your description I'm not sure its the same), that
> would be very helpful Andy.
>
> thanks.
>
> On Tue, Jun 08, 2004 at 10:44:22AM -0500, Andy wrote:
>> I really don't understand what could be causing this, but it happens 
>> on
>> several machine and at least on kernels 2.4.22, 2.4.25, 2.4.26.
>> NFS v3 : hard, udp, rsize=8192,wsize=8192
>> local filesystems are XFS
>>
>> Trond, this is data corruption not dropped packets so the protocol
>> being UDP is not the problem.
>>
>> Here is what is happening :
>>
>> Copying a file of offsets from machine A to machine B over NFS and 
>> then
>> comparing the file on B with the file on A over NFS, the file on 
>> machine B
>> is corrupted in the following ways.
>>
>> Usually, data earlier in the file will show up again later.
>> For example :
>>
>> 57344 bytes of data from 672190464-672247807 is also in positions
>> 1449664512-1449721855
>>
>> sometimes, data later in the file is dupped to a position before it
>> should be
>>
>> 53248 bytes of data from 1197158400-1197211647 is also in positions
>> 1036660736-1036713983
>>
>> Any ideas
>>
>> Andy
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
> -- 
> Nathan
>

