Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283729AbRK3Rab>; Fri, 30 Nov 2001 12:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283722AbRK3RaV>; Fri, 30 Nov 2001 12:30:21 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:61394
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S283721AbRK3RaM>; Fri, 30 Nov 2001 12:30:12 -0500
Date: Fri, 30 Nov 2001 12:29:39 -0500
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] smarter atime updates
Message-ID: <970480000.1007141379@tiny>
In-Reply-To: <Pine.LNX.4.21.0111301344330.17515-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0111301344330.17515-100000@freak.distro.conectiva>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, November 30, 2001 01:44:42 PM -0200 Marcelo Tosatti
<marcelo@conectiva.com.br> wrote:

> 
> Now are you sure this can't break anything ? 
> 

It shouldn't hurt reiserfs at least, I like it.

-chris

> On Thu, 29 Nov 2001, Andrew Morton wrote:
> 
>> mark_inode_dirty() is quite expensive for journalling filesystems,
>> and we're calling it a lot more than we need to.
>> 
>> --- linux-2.4.17-pre1/fs/inode.c	Mon Nov 26 11:52:07 2001
>> +++ linux-akpm/fs/inode.c	Thu Nov 29 21:53:02 2001
>> @@ -1187,6 +1187,8 @@ void __init inode_init(unsigned long mem
>>   
>>  void update_atime (struct inode *inode)
>>  {
>> +	if (inode->i_atime == CURRENT_TIME)
>> +		return;
>>  	if ( IS_NOATIME (inode) ) return;
>>  	if ( IS_NODIRATIME (inode) && S_ISDIR (inode->i_mode) ) return;
>>  	if ( IS_RDONLY (inode) ) return;
>> 
>> 
>> with this patch, the time to read a 10 meg file with 10 million
>> read()s falls from 38 seconds (ext3), 39 seconds (reiserfs) and
>> 11.6 seconds (ext2) down to 10.5 seconds.

