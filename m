Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285166AbRLRVKd>; Tue, 18 Dec 2001 16:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285170AbRLRVKU>; Tue, 18 Dec 2001 16:10:20 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:14629 "EHLO
	tsmtp8.mail.isp") by vger.kernel.org with ESMTP id <S285161AbRLRVJL>;
	Tue, 18 Dec 2001 16:09:11 -0500
Date: Tue, 18 Dec 2001 22:11:22 +0100
From: Diego Calleja <grundig@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: Nikita@Namesys.COM
Subject: [grundig@teleline.es: Re: Reiserfs corruption on 2.4.17-rc1!]
Message-ID: <20011218221122.B381@diego>
In-Reply-To: <20011217025856.A1649@diego> <13425.1008580831@nova.botz.org> <20011218003359.A555@diego> <15391.12150.650359.33792@laputa.namesys.com> <20011218220828.A381@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20011218220828.A381@diego>; from grundig@teleline.es on Tue, Dec 18, 2001 at 22:08:28 +0100
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001 22:08:28 Diego Calleja wrote:

On Tue, 18 Dec 2001 12:58:46 Nikita Danilov wrote:
> Diego Calleja writes:
>  > Well, I've run badblocks in 2.4.16
>  > results:
>  > 
>  > 

>  > Dec 18 00:22:41 diego kernel: is_tree_node: node level 18771 does not
> match
>  > to the expected one 1
>  > Dec 18 00:22:41 diego kernel: vs-5150: search_by_key: invalid format
> found
>  > in block 10667. Fsck?
>  > Dec 18 00:22:41 diego kernel: vs-13070: reiserfs_read_inode2: i/o
> failure
>  > occurred trying to find stat data of [4160 68377 0x0 SD]
>  > 
>  > This is my opinion:
>  > 	-Something (reiserfs, anything) has caused fs corruption
>  > 	-It should be repaired by reiserfsck, but it's broken :-((
> 
> You mean you cannot access /sbin/reiserfsck, because root file system is
> unstable? Sorry, probably I missed start of this thread on lkml.

I mean this:
root@diego:~# reiserfsck /dev/hdc5

<-------------reiserfsck, 2001------------->
reiserfsprogs 3.x.0j

Will read-only check consistency of the partition
Will put log info to 'stderr'
Do you want to run this program?[N/Yes] (note need to type Yes):Yes
Analyzing journal..nothing to replay (no transactions older than last
flushed one found)
Fetching on-disk bitmap..done
Checking S+tree../  1 (of   2)/  3 (of 110)/ 15 (of 149)node (10667) with
wrong level (18771) found in the tree (should be 1)
Segmentation fault
root@diego:~#

> 
>  > 	-This corruption should NOT have happened, reiserfsck
> shouldn't
>  > have to be used.
> 
> Unfortunately this looks like "standard" reiserfs tree corruption. 
> Take
> 
> ftp://ftp.namesys.com/pub/reiserfsprogs/pre/reiserfsprogs-3.x.0k_pre11.tar.gz,
> 
> build it and run reiserfsck from there. If your root file system is
> dead, you will have to do this from some other media (like floppy).
Well, I've a copy of all data in another partition...I'm running from it.
I've downloaded that version....well, it don't crash, here's output:
root@diego:~/reiserfsprogs-3.x.0k_pre11/fsck# ./reiserfsck -i /dev/hdc5

<-------------reiserfsck, 2001------------->
reiserfsprogs 3.x.0k_pre11

Will read-only check consistency of the filesystem on /dev/hdc5
Will put log info to 'stdout'

Do you want to run this program?[N/Yes] (note need to type Yes):Yes
###########
reiserfsck --check started at Tue Dec 18 21:59:12 2001
###########
Replaying journal..
0 transactions replayed
reserved=8193
Checking S+tree../  1 (of   2)/  3 (of 110)/ 15 (of 149)node (10667) with
wrong level (18771) found in the tree (should be 1)
whole subtree skipped
ok
Comparing bitmaps..free block count 1970606 mismatches with a correct one
1971004.
on-disk bitmap does not match to the correct one. 91 bytes differ
Bad nodes were found, Semantic pass skipped
There were found 3 corruptions which can be fixed only during
--rebuild-tree
###########
reiserfsck finished at Tue Dec 18 22:06:23 2001
###########

If I do --rebuild tree, will I lose my data?


> 
>  > 	-I'm not a kernel hacker, so I can't try anything...what I
> know is
>  > that
>  > 		/etc in hc5 doesn't work. /usr, /var....works
> correctly.
>  > 
>  > Well, I'd like to know what's happened in my drive. Can somebody try
> to
>  > give an explanation?
>  > 
>  > Diego Calleja
> 
> Nikita.
Diego Calleja



