Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271226AbRHOPPp>; Wed, 15 Aug 2001 11:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271225AbRHOPPf>; Wed, 15 Aug 2001 11:15:35 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:25106 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271222AbRHOPP0> convert rfc822-to-8bit; Wed, 15 Aug 2001 11:15:26 -0400
X-Apparently-From: <xioborg@yahoo.com>
From: Steve Brueggeman <xioborg@yahoo.com>
To: linux-kernel@vger.kernel.org
Cc: "Alan Li" <alan_li31@hotmail.com>
Subject: Re: Scsi Driver & Hanging on Writing inode tables for large partitions
Date: Wed, 15 Aug 2001 10:15:37 -0500
Message-ID: <kd3lnt095p3u2ecf1lnn98pe5dn5org83d@4ax.com>
In-Reply-To: <F2281iRykIl92eEuWut00001a7e@hotmail.com>
In-Reply-To: <F2281iRykIl92eEuWut00001a7e@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, this should probably be posted on 
linux-scsi@vger.kernel.org instead of here.

Well, I hate to be obvious, but since you mention it's size related, 
the first thing to suspect is that your driver is not shifting the
SECTOR bits correctly. 

Notably, 0x5FFFF sectors * 0x200 bytes/sector ~= 201MB.

Enable scsi logging in the kernel, and turn it on with
echo "scsi log all" >/proc/scsi

and exercise the disk with something simple like
dd if=/dev/sda of=/dev/null bs=512 count=1000 skip=393200

(Note, 393200 == 0x5FFF0 )

and look at the kernel log to see what CDB's the SCSI middle layers
are pushing to your driver, and see what CDB's your driver is pushing
to the hardware.

Steve Brueggeman


On Thu, 12 Jul 2001 18:00:37 -0700, you wrote:

>Hi,
>
>I'm very new at this, so here goes:
>
>I'm trying to write a scsi driver, and everything (device detection, 
>reading/writing to partition tables) works fine, until I try to mkfs any 
>partition larger than 200 megs.  When it's over 200 megs, it would hang on 
>writing to the inode tables for ~20 seconds, then spit out many i/o errors.  
>Is there a reason why mkfs would work for partitions <200 megs and not for 
>partitions larger than that?
>
>Kernel: 2.4.2-2
>mke2fs: 1.19
>CPU: Pentium Pro 200mhz
>Memory: 48mb physical, 256mb swap
>
>I would really appreciate any help, and please cc: any responses to this to 
>this email address because I'm not on the mailing list.
>
>Thanks, Alan
>_________________________________________________________________
>Get your FREE download of MSN Explorer at http://explorer.msn.com
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

