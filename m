Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318884AbSH1Pqe>; Wed, 28 Aug 2002 11:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318897AbSH1PqP>; Wed, 28 Aug 2002 11:46:15 -0400
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:52786
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S318884AbSH1Ppj>; Wed, 28 Aug 2002 11:45:39 -0400
Message-ID: <3D6CF132.4090205@bonin.ca>
Date: Wed, 28 Aug 2002 11:50:10 -0400
From: Andre Bonin <Bonin@bonin.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: hch@infradead.org, aia21@cantab.net, kernel@bonin.ca,
       linux-kernel@vger.kernel.org
Subject: Re: Loop devices under NTFS
References: <200208280106.SAA05492@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep04-mail.bloor.is.net.cable.rogers.com from [65.39.24.214] using ID <bonin@rogers.com> at Wed, 28 Aug 2002 11:49:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:

>On Wed, 28 Aug 2002 at 00:59:55AM +0100, Christoph Hellwig wrote:
>  
>
>>On Tue, Aug 27, 2002 at 04:42:56PM -0700, Adam J. Richter wrote:
>>    
>>
>>>>On Tue, Aug 27, 2002 at 06:53:19AM -0700, Adam J. Richter wrote:
>>>>        
>>>>
>>>>>	Why?
>>>>>
>>>>>	According to linux-2.5.31/Documentation/Locking,
>>>>>"->prepare_write(), ->commit_write(), ->sync_page() and ->readpage()
>>>>>may be called from the request handler (/dev/loop)."
>>>>>          
>>>>>
>>>>Just because it's present in current code it doesn't mean it's right.
>>>>Calling aops directly from generic code is a layering violation and
>>>>it will not survive 2.5.
>>>>        
>>>>
>>>	Only according your own proclamation.  You are arguing
>>>circular logic, and I am aruging a concrete benefit: we can avoid an
>>>extra copying of all data in the input and output paths going through
>>>an encrypted device.
>>>
I'me new to kernel development and i've never fooled around with drivers 
before (I do have a course in it this september though, Wohoo!).

Why are you saying it would copy the data? Couldn't you just make some 
sort of shared memory system that would let you unencript/uncompress the 
data without having to do a copy?  The way i see it you can read the 
block, pass it through the necessary mods using the same data.  You 
could get a wierd race condition if your uncompress and your unencript 
work on the same data at the same time but that can easily be avoided 
 The way i see it, the NTFS driver should be able to read the file and 
uncompress.  The loop driver should have access to that block without 
having to do a copy to present it to a third party driver. Which then 
reads the data read by the driver and rpesents it as a filesystem.  

Maby even do away with loop.c, there should really be no loop.c .  A 
normal mount (/dev/hda1 for example) is a first level mount.  If you let 
/mnt/foo/myfile.iso be from /dev/hda1, then the chain should be 
/dev/hda1->ISO9660 module-->presentation.

I think the filesystem drivers should be written in such a way that they 
are totally pluggable with eachother.  That it doesn't matter where the 
blocks are comming from and going to.  You could have a mount of 
/dev/hda1 of an iso containing an ext2 image within it etc etc etc.

But like i said i'me new to kernel development so I think i might have 
the wrong perspective.  


-----------------------------------
Andre Bonin
Student in Software Engineering
Lakehad University
Thunder Bay,
Canada
-----------------------------------

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>




