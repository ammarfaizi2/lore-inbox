Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281034AbRKLWBd>; Mon, 12 Nov 2001 17:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281031AbRKLWBX>; Mon, 12 Nov 2001 17:01:23 -0500
Received: from dsl-64-192-96-25.telocity.com ([64.192.96.25]:23533 "EHLO
	orr.falooley.org") by vger.kernel.org with ESMTP id <S281030AbRKLWBQ>;
	Mon, 12 Nov 2001 17:01:16 -0500
Date: Mon, 12 Nov 2001 17:00:59 -0500
From: Jason Lunz <j@falooley.org>
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new aic7xxx bug, 2.4.13/6.2.4
Message-ID: <20011112170059.A23809@orr.falooley.org>
In-Reply-To: <20011101222455.A5885@orr.falooley.org> <200111021443.fA2EhRY46335@aslan.scsiguy.com> <20011102143545.A30381@trellisinc.com> <20011112184533.1DE6A1027@shrek.lisa.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011112184533.1DE6A1027@shrek.lisa.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at  7:45PM +0100, Hans-Peter Jansen wrote:
> cdrdao read-cd --device /dev/sr0 --driver generic-mmc --buffers 80 -n
> --eject --paranoia-mode 0 toc
> [...]
> ?: Input/output error.  : scsi sendcmd: retryable error
> CDB:  BE 00 00 04 2C 67 00 00 1A F8 01 00
> status: 0x0 (GOOD STATUS)
> cmd finished after 20.101s timeout 20s
> ?: Input/output error.  : scsi sendcmd: retryable error
> CDB:  BE 00 00 04 2E 43 00 00 1A F8 01 00
> status: 0x0 (GOOD STATUS)
> cmd finished after 20.101s timeout 20s
> [...]
> killed with ^c
> 
> locked the drive completely. Need to reboot to eject the cd...
> I suspect some bad interference between DVD firmware, kernel 
> SCSI error handling and cdrdao. A plextor reader finally 
> succeeded on this job (wink :)

I agree it's the same effect, but I disagree about the cause. It's the
fault of the scsi mid-layer; it marks the device as dead when a command
times out and won't allow further accesses to it. The fact that it
happens to both of us with different drives and different scsi drivers
(you don't even have scsi, but ide-scsi emulation) shows that the scsi
midlayer is broken in both cases.

And as Justin Gibbs suggested, I'd bet that raising the timeout on the
failing scsi command in cdrdao would probably fix this for both of us,
but I haven't had time to try it. If so, it's not a userspace bug
because it allows any user with cdrom access to disable a cdrom until
reboot.

Jason
