Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285193AbRLMVbP>; Thu, 13 Dec 2001 16:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285194AbRLMVbG>; Thu, 13 Dec 2001 16:31:06 -0500
Received: from mailb.telia.com ([194.22.194.6]:35084 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S285193AbRLMVa6>;
	Thu, 13 Dec 2001 16:30:58 -0500
Message-Id: <200112132130.fBDLUr511956@mailb.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Jens Axboe <axboe@suse.de>,
        Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
Subject: Unable to handle kernel NULL pointer dereference at virtual address 00000000 (Was: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c)
Date: Thu, 13 Dec 2001 22:28:35 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011128135552.204311E532@Cantor.suse.de> <20011129143538.3A4F81E128@Cantor.suse.de> <20011129175441.N10601@suse.de>
In-Reply-To: <20011129175441.N10601@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursdayen den 29 November 2001 17.54, Jens Axboe wrote:
> On Thu, Nov 29 2001, Sebastian Dröge wrote:
> > Sorry my mistake
> > I've meant this patch:
> > http://kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre3/b
> >io-pre3-1.gz
> >
> > So it's 2.5.1-pre3 + Alan's patch + bio-pre3-1 + the patch you've posted
> > after the 2.5.1-pre3 don't-use mail
> >
> > There were no failures while patching so I think this patches are
> > compatible each other ;)
>
> Yes sure, that's what I expected. THe part I didn't understand was the
> sr-sg-1 part.
>
> > And it works well... no data corruption, no oopses, no nothing ;)
> > Later the day I'll test burning a CD
>
> Good

Hmm...

I got the BUG described earlier in this thread with a 2.4.16 kernel (sligtly 
patched but in a different area - update the page structure referenced bit 
when scheduling away a process - it has been running for several days)

The driver in question is a "Pioneer DVD-ROM ATAPIModel DVD-115 0122"
And i tried to mount a Windows CD - Joliet?

It looks like this:

Dec 13 22:07:00 jeloin kernel: VFS: Disk change detected on device ide1(22,64)
Dec 13 22:07:03 jeloin kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Dec 13 22:07:03 jeloin kernel:  printing eip:
Dec 13 22:07:03 jeloin kernel: d0894866
Dec 13 22:07:03 jeloin kernel: *pde = 00000000
Dec 13 22:07:03 jeloin kernel: Oops: 0002
Dec 13 22:07:03 jeloin kernel: CPU:    0
Dec 13 22:07:03 jeloin kernel: EIP:    0010:[<d0894866>]    Not tainted
Dec 13 22:07:03 jeloin kernel: EFLAGS: 00210202
Dec 13 22:07:03 jeloin kernel: eax: cf8b4600   ebx: 00000001   ecx: c6fa3000  
 edx: cbceb040
Dec 13 22:07:03 jeloin kernel: esi: c6fa3000   edi: 00000000   ebp: c7ad0f60  
 esp: c8403e88
Dec 13 22:07:03 jeloin kernel: ds: 0018   es: 0018   ss: 0018
Dec 13 22:07:03 jeloin kernel: Process kdeinit (pid: 1195, stackpage=c8403000)
Dec 13 22:07:03 jeloin kernel: Stack: 00000001 c6fa3000 c6fa3021 c7ad0f60 
00001640 00000000 00000000 00000000
Dec 13 22:07:03 jeloin kernel:        00000000 00000000 00000000 00000800 
cbceb040 d089227e c6fa3000 00000000
Dec 13 22:07:03 jeloin kernel:        cbceb040 c12bc640 cbceb040 cbceb040 
c7702360 00000030 00000030 00000000
Dec 13 22:07:03 jeloin kernel: Call Trace: [<d089227e>] [<d08923c4>] 
[real_lookup+83/196] [link_path_walk+1302/1880] [getname+93/156]
Dec 13 22:07:03 jeloin kernel:    [path_walk+26/28] [__user_walk+53/80] 
[sys_access+148/300] [system_call+51/56]
Dec 13 22:07:03 jeloin kernel:
Dec 13 22:07:03 jeloin kernel: Code: c6 07 00 0f b6 51 20 8d 42 21 89 44 24 
30 83 e0 01 83 c2 22
Dec 13 22:09:19 jeloin modprobe: modprobe: Can't locate module net-pf-10

I have ide-scsi but that is only used on my CDRW 
"Vendor: HP       Model: CD-Writer+ 9300  Rev: 1.0c"

Ideas?

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
