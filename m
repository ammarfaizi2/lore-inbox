Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284016AbRLAJXc>; Sat, 1 Dec 2001 04:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284018AbRLAJXY>; Sat, 1 Dec 2001 04:23:24 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:18194 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284016AbRLAJXF>; Sat, 1 Dec 2001 04:23:05 -0500
Message-ID: <3C08A14E.6070703@namesys.com>
Date: Sat, 01 Dec 2001 12:22:22 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        reiserfs-dev <reiserfs-dev@namesys.com>
Subject: Re: [patch] smarter atime updates
In-Reply-To: <Pine.LNX.4.21.0111301344330.17515-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>Now are you sure this can't break anything ? 
>
>On Thu, 29 Nov 2001, Andrew Morton wrote:
>
>>mark_inode_dirty() is quite expensive for journalling filesystems,
>>and we're calling it a lot more than we need to.
>>
>>--- linux-2.4.17-pre1/fs/inode.c	Mon Nov 26 11:52:07 2001
>>+++ linux-akpm/fs/inode.c	Thu Nov 29 21:53:02 2001
>>@@ -1187,6 +1187,8 @@ void __init inode_init(unsigned long mem
>>  
>> void update_atime (struct inode *inode)
>> {
>>+	if (inode->i_atime == CURRENT_TIME)
>>+		return;
>> 	if ( IS_NOATIME (inode) ) return;
>> 	if ( IS_NODIRATIME (inode) && S_ISDIR (inode->i_mode) ) return;
>> 	if ( IS_RDONLY (inode) ) return;
>>
>>
>>with this patch, the time to read a 10 meg file with 10 million
>>read()s falls from 38 seconds (ext3), 39 seconds (reiserfs) and
>>11.6 seconds (ext2) down to 10.5 seconds.
>>
>>-
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
nice optimization.

Hans


