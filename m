Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965257AbVHJStz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbVHJStz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 14:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbVHJSty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 14:49:54 -0400
Received: from mailfe09.tele2.fr ([212.247.155.12]:47260 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S965257AbVHJStx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 14:49:53 -0400
X-T2-Posting-ID: g63wq726D5fsXb2UbU6LU0KOXzHnTHjCzHZ35sC2MDs=
Message-ID: <42FA4C44.5040609@astek.fr>
Date: Wed, 10 Aug 2005 20:49:40 +0200
From: Frederic TEMPORELLI - astek <ftemporelli@astek.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.7.3) Gecko/20040910
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] remove name length check in a workqueue
References: <1123683544.5093.4.camel@mulgrave>	 <Pine.LNX.4.58.0508101044110.31617@devserv.devel.redhat.com>	 <20050810100523.0075d4e8.akpm@osdl.org> <1123694672.5134.11.camel@mulgrave>	 <20050810103733.42170f27.akpm@osdl.org> <1123696466.5134.23.camel@mulgrave>
In-Reply-To: <1123696466.5134.23.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley a écrit :

>Well, but the other alternative is that we hit arbitrary BUG_ON() limits
>in systems that create numbered workqueues which is rather contrary to
>our scaleability objectives, isn't it?
>
>I think I'd rather the name truncation than have to respond to kernel
>BUG()'s.  If someone really has a problem with the appearance of ps,
>they can always increase TASK_COMM_LEN.
>
>  
>
>>We could truncate the name before adding the CPU number, but it sounds
>>saner to just prevent anyone passing in excessively long names.  Via
>>BUG_ON, say ;)
>>
>>What's the actual problem?
>>    
>>
>
>What I posted originally; the current SCSI format for a workqueue:
>scsi_wq_%d hits the bug after the host number rises to 100, which has
>been seen by some enterprise person with > 100 HBAs.
>
>The reason for this name is that the error handler thread is called
>scsi_eh_%d; so we could rename all our threads to avoid this, but one
>day someone will come along with a huge enough machine to hit whatever
>limit we squeeze it down to.
>
>James
>
>  
>
In scsi layer (drivers/scsi/hosts.c), wq name length is limited to 
KOBJ_NAME_LEN due to the snprintf .
may be nice to use same limit if BUG_ON is kept... but why NULL isn't 
returned, then ?  ;-)

--
Tempo
