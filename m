Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWBAHmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWBAHmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 02:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWBAHmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 02:42:05 -0500
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:64405 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751419AbWBAHmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 02:42:04 -0500
Message-ID: <43E06648.4070401@namesys.com>
Date: Tue, 31 Jan 2006 23:42:00 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
References: <200601281613.16199.vda@ilport.com.ua> <43DDAE2D.6080300@namesys.com> <200601300822.47821.mason@suse.com> <200602010932.50972.vda@ilport.com.ua>
In-Reply-To: <200602010932.50972.vda@ilport.com.ua>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>On Monday 30 January 2006 15:22, Chris Mason wrote:
>  
>
>>On Monday 30 January 2006 01:11, Hans Reiser wrote:
>>    
>>
>>>Chris, would Denis Vlasenko wrote:
>>>      
>>>
>>>>[CCing namesys]
>>>>
>>>>Narrowed it down to 100% reproducible case:
>>>>
>>>>	chown -Rc 0:<n> .
>>>>
>>>>in a top directory of tree containing ~21938 files
>>>>on reiser3 partition:
>>>>
>>>>	/dev/sdc3 on /.3 type reiserfs (rw,noatime)
>>>>
>>>>causes oom kill storm. "ls -lR", "find ." etc work fine.
>>>>
>>>>I suspected that it is a leak in winbindd libnss module,
>>>>but chown does not seem to grow larger in top, and also
>>>>running it under softlimit -m 400000 still causes oom kills
>>>>while chown's RSS stays below 4MB.
>>>>        
>>>>
>>In order for the journaled filesystems to make sure the FS is consistent after 
>>a crash, we need to keep some blocks in memory until other blocks have been 
>>written.  These blocks are pinned, and can't be freed until a certain amount 
>>of io is done.
>>
>>In the case of reiserfs, it might pin as much as the size of the journal at 
>>any time.  The default journal is 32MB, which is much too large for a system 
>>with only 32MB of ram.
>>
>>You can shrink the log of an existing filesystem.  The minimum size is 513 
>>blocks, you might try 1024 as a good starting poing.
>>
>>reiserfstune -s 1024 /dev/xxxx
>>
>>The filesystem must be unmounted first.
>>    
>>
>
>Will try this and report the result.
>
>Please consider printing a big fat warning at mount time if total RAM
>on the system is close to sum of RAM space required for all currently
>mounted reiserfs partitions...
>--
>vda
>
>
>  
>
I already suggested this to Chris.;-)  I agree.

Best,

Hans
