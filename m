Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbTJIUgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbTJIUgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:36:39 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:2578 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S262562AbTJIUgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:36:37 -0400
Message-ID: <3F85C875.2030506@kolumbus.fi>
Date: Thu, 09 Oct 2003 23:43:33 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Dave Kleikamp <shaggy@austin.ibm.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG() in exec_mmap()
References: <Pine.LNX.4.44.0310091718080.3040-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0310091718080.3040-100000@logos.cnet>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 09.10.2003 23:38:18,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 09.10.2003 23:37:37,
	Serialize complete at 09.10.2003 23:37:37
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti wrote:

>On Thu, 9 Oct 2003, Dave Kleikamp wrote:
>
>  
>
>>Marcelo,
>>A recent change to exec_mmap() removed the initialization of old_mm,
>>leaving an uninitialized use of it.  This patch would completely remove
>>old_mm from the function.  Is this what was intended?
>>    
>>
>
>Yes. 
>
>Blame me... patch applied, thank you!
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

Hmm.. you still need to mmput(old_mm) etc, just remove the mm_users == 1 
optimization from the beginning of exec_mmap, so this patch is wrong!

--Mika


