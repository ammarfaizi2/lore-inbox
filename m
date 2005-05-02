Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVEBB1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVEBB1j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 21:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVEBB1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:27:39 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:28604 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261419AbVEBB1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:27:32 -0400
Message-ID: <427581F6.9090201@davyandbeth.com>
Date: Sun, 01 May 2005 20:27:18 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Davy Durham <pubaddr2@davyandbeth.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 issue..
References: <4270FA5B.5060609@davyandbeth.com> <20050428200908.GB6669@thunk.org>
In-Reply-To: <20050428200908.GB6669@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I caught another machine doing it..   So here's the output of: df, 
unmount, fsck.ext3, mount, df

I don't know if it shows anything that would indicate the cause of the 
issue though.


#df
Filesystem Size Used Avail Use% Mounted on

/dev/ide/host0/bus0/target0/lun0/part1
                      2.0G  465M  1.5G  25% /
/dev/ide/host0/bus0/target0/lun0/part6
                       33G  -64Z   31G 101% /home



# umount /home


# fsck.ext3 -f -v /dev/ide/host0/bus0/target0/lun0/part6
e2fsck 1.34 (25-Jul-2003)
Pass 1: Checking inodes, blocks, and sizes
Inode 8, i_blocks is 65616, should be 65608.  Fix<y>? yes

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
/lost+found not found.  Create<y>? yes

Pass 4: Checking reference counts
Pass 5: Checking group summary information
Free blocks count wrong for group #2 (47844, counted=30900).
Fix<y>? yes

Free blocks count wrong for group #4 (36926, counted=31744).
Fix<y>? yes

Free blocks count wrong (8435011, counted=8412885).
Fix<y>? yes


/dev/ide/host0/bus0/target0/lun0/part6: ***** FILE SYSTEM WAS MODIFIED *****

      13 inodes used (0%)
       2 non-contiguous inodes (15.4%)
         # of inodes with ind/dind/tind blocks: 2/0/0
  282288 blocks used (3%)
       0 bad blocks
       0 large files

       2 regular files
       1 directory
       0 character device files
       0 block device files
       0 fifos
       0 links
       0 symbolic links (0 fast symbolic links)
       0 sockets
--------
       3 files


# mount /home



# df
Filesystem            Size  Used Avail Use% Mounted on
/dev/ide/host0/bus0/target0/lun0/part1
                      2.0G  439M  1.5G  24% /
/dev/ide/host0/bus0/target0/lun0/part6
                       33G   39M   31G   1% /home


# uname -r
2.6.3-15mdk


# uptime
 20:25:26 up 100 days, 12 min,  1 user,  load average: 0.01, 0.08, 0.04





Theodore Ts'o wrote:

>On Thu, Apr 28, 2005 at 09:59:39AM -0500, Davy Durham wrote:
>  
>
>>Crazy huh?  Well, I unmounted /home and did an fsck -f  on the partition 
>>and remounted it.  Then everything looked okay.
>>    
>>
>
>What messages were displayed by e2fsck?  What version of the kernel
>are you running?
>
>No, I haven't heard of any such problems with ext2/3 filesystems.
>This is the first time that someone was reported a specific problem
>with the # of blocks used accounting.  There is the standard "file
>held open so the number of blocks used is greater than blocks reported
>by du", but that won't cause df to display negative numbers.
>
>						- Ted
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

