Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbUK2GTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbUK2GTg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 01:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbUK2GTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 01:19:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43666 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261151AbUK2GTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 01:19:31 -0500
Date: Mon, 29 Nov 2004 07:19:00 +0100
From: Jens Axboe <axboe@suse.de>
To: pasi.savolainen@iki.fi
Cc: linux-kernel@vger.kernel.org, Thomas Fritzsche <tf@noto.de>
Subject: Re: Is controlling DVD speeds via SET_STREAMING supported?
Message-ID: <20041129061856.GA10477@suse.de>
References: <33133.192.168.0.2.1101499190.squirrel@192.168.0.10> <32942.192.168.0.2.1101549298.squirrel@192.168.0.10> <slrncqhqib.19r.psavo@varg.dyndns.org> <33262.192.168.0.2.1101597468.squirrel@192.168.0.10> <slrncqjcve.19r.psavo@varg.dyndns.org> <33050.192.168.0.5.1101651929.squirrel@192.168.0.10> <20041128165257.GA26714@suse.de> <slrncqk3so.19r.psavo@varg.dyndns.org> <20041128185329.GB26933@suse.de> <b9013cc2041128130130ceeed2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9013cc2041128130130ceeed2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28 2004, Pasi Savolainen wrote:
> On Sun, 28 Nov 2004 19:53:30 +0100, Jens Axboe <axboe@suse.de> wrote:
> > > (under 2.6.10-rc2-mm1)
> > > I ran speed-1.0 program as root and also modified to open the device
> > > file as O_RDWR. This didn't help, it still reports same error.
> > 
> > Ehm I don't see how that is possible, since that kernel definitely
> > contains SET_STREAMING as a write safe command. Are you 110% sure you
> > are running the kernel you think you are?
> 
> I was talking about 'feature not suppoerted by device' -error.
> Got uptodate to 2.6.10-rc2-mm3, ran following:
> - -
> tienel:~# whoami
> root
> tienel:~# uname -a
> Linux tienel 2.6.10-rc2-mm3 #1 SMP Sun Nov 28 22:28:17 EET 2004 i686 GNU/Linux
> tienel:~# wget -q http://noto.de/speed/speedcontrol.c
> tienel:~# gcc -o speedcontrol speedcontrol.c 
> tienel:~# ./speedcontrol -x 1 /dev/dvd
> Command failed: b6 00 00 00 00 00 00 00 00 00 1c 00  - sense: 05.20.00
> ERROR.
> tienel:~# tail /var/log/messages
> ...
> Nov 28 22:50:04 tienel kernel: hdb: packet command error: status=0x51
> { DriveReady SeekComplete Error }
> Nov 28 22:50:04 tienel kernel: hdb: packet command error: error=0x54
> Nov 28 22:50:04 tienel kernel: ide: failed opcode was 100

Makes more sense, then. It looks like you drive just isn't very happy
with the set streaming command. First I'd try to correct the end_lba of
the command, that might be it.

-- 
Jens Axboe

