Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277670AbRJ3Szm>; Tue, 30 Oct 2001 13:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277559AbRJ3Szd>; Tue, 30 Oct 2001 13:55:33 -0500
Received: from longsword.omniti.com ([216.0.51.134]:23824 "EHLO
	longsword.omniti.com") by vger.kernel.org with ESMTP
	id <S277530AbRJ3SzT>; Tue, 30 Oct 2001 13:55:19 -0500
Date: Tue, 30 Oct 2001 13:56:52 -0500
Subject: Re: linux-2.4.13 high SWAP
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v472)
Cc: rscuss@omniti.com, linux-kernel@vger.kernel.org
To: Andre Margis <andre@sam.com.br>
From: Theo Schlossnagle <jesus@omniti.com>
In-Reply-To: <200110301609.OAA01973@inter.lojasrenner.com.br>
Message-Id: <E1AFA59B-CD67-11D5-A5E2-0003930FCDF8@omniti.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.472)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 30, 2001, at 10:10  AM, Andre Margis wrote:
> I test 2.4.9 , 2.4.10-ac7, 2.4.13 and all have this problem, I'm not 
> using
> XFS, but reiserfs with LVM and 4 GB RAM. I detected if use tmpfs the 
> kswapd
> eat my all CPU's, in 2.4.13 the system hang after a time. Now I'm 
> testing
> 2.4.13-ac3 without tmpfs and he is very better than the others 
> versions. But
> a nice test is disable the HIGHMEM support. I have a machine with 1GB 
> RAM and
> the system is very fine and stable, running 2.4.10-ac7.

To contrast.  We have had the best success with Linux 2.4.7 with HIGHMEM 
support enabled.

I see several people having similar symptoms and everyone is point 
fingers at tmpfs or ramfs or xfs (I pointed my finger there 
originally).  It seems to me that it is something more fundamental and 
that particular usage patterns are triggering this.  I have around 20 
different dual processor machines that run 2.4.7-xfs, 2.4.2-xfs, or 
2.4.12-xfs and I can only replicate it when I put heavy filesystem 
activity on the machine.

Every time I replicate the problem, I become less certain of the actual 
cause!  I have kdb and SysReq enabled on all these boxes and it doesn't 
cause a console freeze, so if some extra info would be helpful, let me 
know and I will gather it during the next "glitch."


I am confident that the problem, on triggered, directly effects all 
filesystem code.  Once I have an "unkillable" process scheduled, it is 
CPU bound and all filesystem sync operations fail.  The sync command 
never returns, reboot won't work without (-n) and all my mailers (exim 
in this case) freeze on their fsync calls.

The _REALLY_ bad thing here (other than suspended disk I/O and the cruel 
reboot) is that all file blocks that are modified after this "glitch" 
are full of \000's upon reboot.  A good portion of my mail spool is 
corrupted as well as other files.  I don't know if this is specific to 
only journalled file systems as I cannot afford the downtime of 
replicating this problem on a non-journalled fs.

--
Theo Schlossnagle
1024D/82844984/95FD 30F1 489E 4613 F22E  491A 7E88 364C 8284 4984
2047R/33131B65/71 F7 95 64 49 76 5D BA  3D 90 B9 9F BE 27 24 E7

