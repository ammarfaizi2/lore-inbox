Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTKBTnx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 14:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTKBTnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 14:43:53 -0500
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:41572 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S261788AbTKBTnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 14:43:51 -0500
Message-ID: <3FA55E7B.3050706@planet.nl>
Date: Sun, 02 Nov 2003 20:43:55 +0100
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031025
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Di-30 non working [bug 967]
References: <3FA41703.1030408@planet.nl> <200311012228.29085.bzolnier@elka.pw.edu.pl> <20031101152453.42346338.akpm@osdl.org> <200311020054.49869.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200311020054.49869.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Bartlomiej,

The problem is now fully solved. I can read from the tape, use mt on the 
tape drive. Your second patch was the final missing bit.

Thanks for your help, I hope that Linus will accept the patch for test10 
so that more people can enjoy the use of this tape drive with Linux.

Stef

Bartlomiej Zolnierkiewicz wrote:

>On Sunday 02 of November 2003 00:24, Andrew Morton wrote:
>  
>
>>Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>>    
>>
>>>Noticed by Stuart_Hayes@Dell.com:
>>>
>>>I've noticed that, in the 2.6 (test 9) kernel, the "cmd" field (of type
>>>int) in struct request has been removed, and it looks like all of the
>>>code in ide-tape has just had a find & replace run on it to replace any
>>>instance of rq.cmd or rq->cmd with rq.flags or rq->flags.
>>>      
>>>
>>Nasty.
>>
>>    
>>
>>>@@ -193,6 +193,11 @@ enum rq_flag_bits {
>>> 	__REQ_PM_SUSPEND,	/* suspend request */
>>> 	__REQ_PM_RESUME,	/* resume request */
>>> 	__REQ_PM_SHUTDOWN,	/* shutdown request */
>>>+	__REQ_IDETAPE_PC1,	/* packet command (first stage) */
>>>+	__REQ_IDETAPE_PC2,	/* packet command (second stage) */
>>>+	__REQ_IDETAPE_READ,
>>>+	__REQ_IDETAPE_WRITE,
>>>+	__REQ_IDETAPE_READ_BUFFER,
>>> 	__REQ_NR_BITS,		/* stops here */
>>> };
>>>      
>>>
>>This takes us up to about 28 flags; we'll run out soon.
>>
>>Probably it is time to split this into generic and private flags, as we did
>>with bh_state_bits.  The scope of the "private" section needs to be
>>defined: maybe "whoever created the queue"?
>>    
>>
>
>This issue was already discussed and is planned for 2.7. :-)
>
>  
>
>>blk_dump_rq_flags() will need updating.  Probably change it to only decode
>>the "generic" flags, and print "bit XX" for the remainders.
>>
>>Your patch forgot to update rq_flags[] btw.
>>    
>>
>
>Thanks, fixed.
>
>I overlooked fact that ide-tape is calling ide_init_drive_cmd() just to zero
>rq and then overwrites rq->flags, fixed.  Stef, please try corrected patch.
>
>
>  
>

