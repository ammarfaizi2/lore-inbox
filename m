Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbRBHWhy>; Thu, 8 Feb 2001 17:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129075AbRBHWho>; Thu, 8 Feb 2001 17:37:44 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:51718 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129069AbRBHWhb>; Thu, 8 Feb 2001 17:37:31 -0500
Date: Thu, 08 Feb 2001 17:37:15 -0500
From: Chris Mason <mason@suse.com>
To: Andrius Adomaitis <charta@gaumina.lt>, linux-kernel@vger.kernel.org
Subject: Re: Problems with 2.4.2-pre1 & reiser & vfs
Message-ID: <1220580000.981671835@tiny>
In-Reply-To: <0102081600260I.32334@castle.gaumina.lt>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, February 08, 2001 04:00:26 PM +0100 Andrius Adomaitis <charta@gaumina.lt> wrote:

> 
> Hello,
> 
> I have  dual PIII 800 machine running as mail server on DAC 960 RAID & 
> reiserfs comming with 2.4.1kernel.
> 
> Under very high loads I get  following messages in my kernel log:
> 
> kernel: vs-13060: reiserfs_update_sd: stat data of object [7906789 
> 7906806 0x0 SD](nlink == 1) not found (pos 23)
> kernel: vs-13060: reiserfs_update_sd: stat data of object [7906789 
> 7906806 0x0 SD] (nlink == 1) not found (pos 23)
> kernel: PAP-5660: reiserfs_do_truncate: wrong result -1 of search for 
> [7906789 7906806 0xfffffffffffffff DIRECT]
> kernel: vs-13060: reiserfs_update_sd: stat data of object [7906789 
> 7906806 0x0 SD] (nlink == 1) not found (pos 23)
> kernel: PAP-5660: reiserfs_do_truncate: wrong result -1 of search for 
> [7906789 7906806 0xfffffffffffffff DIRECT]
> .....

These aren't good at all, and show a general corruption problem.  I know the ac kernels have at least one small DAC960 bug fixes, are there other fixes pending?

> 
> and afterwards come these:
> 
> kernel: vs-3050: wait_buffer_until_released: nobody releases buffer 
> (dev 30:09, size 4096, blocknr 1661732, count 16,
> kernel: vs-3050: wait_buffer_until_released: nobody releases buffer 
> (dev 30:09, size 4096, blocknr 1661732, count 16,
> ...
> and so on.
> 

There is more info in this message, it would help if you could send the entire line.

> The interesting thing is that system is still operational, but load 
> jumps up to 260 or so, and any attempts to reboot system fail. ps aux 
> shows that there exists imortal (kill -9 $PID doesn't kill it) qmail 
> process that consumes 97% of one CPU's resources.  Also `vmstat` shows 
> tons of processes in uninterruptable sleep, but `free` reports that it 
> is still enough memory (no swap used) and huge buffers... Machine gets 
> slugish but works for a while (0.5-2h dependent on mail request rate).
> 

Once you get a vs-3050, any process that tries to change the FS ends up waiting on the journal, which is waiting on the process stuck in vs-3050.  There is no escape.

-chris



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
