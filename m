Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280916AbRKLSqD>; Mon, 12 Nov 2001 13:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280921AbRKLSpy>; Mon, 12 Nov 2001 13:45:54 -0500
Received: from mout04.kundenserver.de ([195.20.224.89]:14191 "EHLO
	mout04.kundenserver.de") by vger.kernel.org with ESMTP
	id <S280917AbRKLSpj>; Mon, 12 Nov 2001 13:45:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: TreeWater Society Berlin
To: Jason Lunz <j@falooley.org>
Subject: Re: new aic7xxx bug, 2.4.13/6.2.4
Date: Mon, 12 Nov 2001 19:45:31 +0100
X-Mailer: KMail [version 1.3]
In-Reply-To: <20011101222455.A5885@orr.falooley.org> <200111021443.fA2EhRY46335@aslan.scsiguy.com> <20011102143545.A30381@trellisinc.com>
In-Reply-To: <20011102143545.A30381@trellisinc.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011112184533.1DE6A1027@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 2. November 2001 20:35, Jason Lunz wrote:
> In mlist.linux-kernel, you wrote:

[...]

> > But the mid-layer has already decided that it can't recover this device,
> > so it calls it dead and refuses to allow I/O to it anymore.
>
> This is definitely wrong. The drive won't do anything now without a
> reboot (or maybe removing and reinserting all scsi modules; I could do
> that but I haven't tried it).
>
> > Have you recently changed your version of cdrdao?  Perhaps that program
> > is issuing a command that this particular drive simply will not accept?
>
> This is the same drive and version of cdrdao that have ripped more than
> 100 CDs. It's just this particular CD that breaks in this way at the
> same spot every time.
>
> If the DVD-ROM can't handle that CD then that's fine, but it would be
> nice if such a broken CD didn't result in not being able to use that
> drive at all anymore.

FYI: I've found a similar result under totally different conditions:
2.4.13-ac7
Vendor: TOSHIBA  Model: DVD-ROM SD-M1502 Rev: 1012
Type:   CD-ROM                           ANSI SCSI revision: 02
via ide-scsi

cdrdao read-cd --device /dev/sr0 --driver generic-mmc --buffers 80 -n
--eject --paranoia-mode 0 toc
[...]
?: Input/output error.  : scsi sendcmd: retryable error
CDB:  BE 00 00 04 2C 67 00 00 1A F8 01 00
status: 0x0 (GOOD STATUS)
cmd finished after 20.101s timeout 20s
?: Input/output error.  : scsi sendcmd: retryable error
CDB:  BE 00 00 04 2E 43 00 00 1A F8 01 00
status: 0x0 (GOOD STATUS)
cmd finished after 20.101s timeout 20s
[...]
killed with ^c

locked the drive completely. Need to reboot to eject the cd...
I suspect some bad interference between DVD firmware, kernel 
SCSI error handling and cdrdao. A plextor reader finally 
succeeded on this job (wink :)

Maybe you're barking up the wrong tree.

Hans-Peter

> thanks for your help,
>
> Jason
