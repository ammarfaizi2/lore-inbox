Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131285AbRBDApj>; Sat, 3 Feb 2001 19:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131334AbRBDAp3>; Sat, 3 Feb 2001 19:45:29 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:7719 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S131306AbRBDApV>; Sat, 3 Feb 2001 19:45:21 -0500
Message-ID: <3A7CA60E.9040600@kalifornia.com>
Date: Sat, 03 Feb 2001 16:45:02 -0800
From: David Ford <david@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-pre11 i686; en-US; m18) Gecko/20010129
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Rik van Riel <riel@conectiva.com.br>, LKML <linux-kernel@vger.kernel.org>,
        reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Re: VM brokenness, possibly related to reiserfs
In-Reply-To: <377430000.981045102@tiny>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

> 
> On Thursday, February 01, 2001 02:16:43 PM -0200 Rik van Riel <riel@conectiva.com.br> wrote:
> 
>> About the system hanging completely, I wonder if it goes
>> away by pressing sysrq-S (sync all disks). If it does,
>> maybe Reiserfs was blocking all the pages in the inactive
>> list from being written because one of the active pages
>> (not a replacement candidate) needed to be written out
>> first?  Or does the Reiserfs ->writepage() function handle
>> this?
> 

In answer to Rik's question, no, sysrq-S doesn't fix it.  The sound of 
the disk grind changes momentarily then it resumes.

> In most cases, the reiserfs writepage func is the same as block_write_full_page.  The only difference should come when a packed tail has been mmap'd.
> 
> Since JOURNAL_MAX_BATCH was at 100, the log should have only pinned 400k.  More blocks could be pinned, but kreiserfsd should be in the process of flushing those.
> 
> I've been trying out a few things to send memory pressure down to reiserfs, but they have mostly been based on the code to make fs/buffer.c use writepage for flushing.  I should have done something simple first, I'll start on that now.
> 
> -chris


http://stuph.org/VM/ is back up, no thanks to the network solutions.  
The files listed there have all the relevant backtraces.

-d


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
