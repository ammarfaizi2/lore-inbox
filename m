Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbUK1VBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbUK1VBn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 16:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbUK1VBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 16:01:43 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:34285 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261584AbUK1VBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 16:01:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IX3HkhH8nENn4jodG9oCmiHIPIe8nqC7J0ScvQNe31IiWNlH66jBitY9DsKgrkG9w2Tq3sl/MBqk1+W858FtgG+8VYIZ98iU2A0y/8m9AbnH9mm7aBzYnKPpBYAVW8nHYTyU0JB/Y76RKIGWhuUXFHHPFNbBJVOi677rUYx3tlQ=
Message-ID: <b9013cc2041128130130ceeed2@mail.gmail.com>
Date: Sun, 28 Nov 2004 23:01:35 +0200
From: Pasi Savolainen <pasi.savolainen@gmail.com>
Reply-To: pasi.savolainen@iki.fi
To: Jens Axboe <axboe@suse.de>
Subject: Re: Is controlling DVD speeds via SET_STREAMING supported?
Cc: linux-kernel@vger.kernel.org, Thomas Fritzsche <tf@noto.de>
In-Reply-To: <20041128185329.GB26933@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <33133.192.168.0.2.1101499190.squirrel@192.168.0.10>
	 <32942.192.168.0.2.1101549298.squirrel@192.168.0.10>
	 <slrncqhqib.19r.psavo@varg.dyndns.org>
	 <33262.192.168.0.2.1101597468.squirrel@192.168.0.10>
	 <slrncqjcve.19r.psavo@varg.dyndns.org>
	 <33050.192.168.0.5.1101651929.squirrel@192.168.0.10>
	 <20041128165257.GA26714@suse.de>
	 <slrncqk3so.19r.psavo@varg.dyndns.org>
	 <20041128185329.GB26933@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Nov 2004 19:53:30 +0100, Jens Axboe <axboe@suse.de> wrote:
> > (under 2.6.10-rc2-mm1)
> > I ran speed-1.0 program as root and also modified to open the device
> > file as O_RDWR. This didn't help, it still reports same error.
> 
> Ehm I don't see how that is possible, since that kernel definitely
> contains SET_STREAMING as a write safe command. Are you 110% sure you
> are running the kernel you think you are?

I was talking about 'feature not suppoerted by device' -error.
Got uptodate to 2.6.10-rc2-mm3, ran following:
- -
tienel:~# whoami
root
tienel:~# uname -a
Linux tienel 2.6.10-rc2-mm3 #1 SMP Sun Nov 28 22:28:17 EET 2004 i686 GNU/Linux
tienel:~# wget -q http://noto.de/speed/speedcontrol.c
tienel:~# gcc -o speedcontrol speedcontrol.c 
tienel:~# ./speedcontrol -x 1 /dev/dvd
Command failed: b6 00 00 00 00 00 00 00 00 00 1c 00  - sense: 05.20.00
ERROR.
tienel:~# tail /var/log/messages
...
Nov 28 22:50:04 tienel kernel: hdb: packet command error: status=0x51
{ DriveReady SeekComplete Error }
Nov 28 22:50:04 tienel kernel: hdb: packet command error: error=0x54
Nov 28 22:50:04 tienel kernel: ide: failed opcode was 100
tienel:~# hdparm -I /dev/dvd 

/dev/dvd:

ATAPI CD-ROM, with removable media
        Model Number:       SAMSUNG DVD-ROM SD-616E                 
        Serial Number:      
        Firmware Revision:  F506    
Standards:
        Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
        Supported: CD-ROM ATAPI-2 
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(can be disabled)
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=120ns  IORDY flow control=120ns

- -

When I'm running these, I have a single-sided stamped DVD in drive.
These tend to make an awfull noise of hoovering when viewed (and
really need speed adjustment to 1-2x)

> > Booted into 2.4.28, speed-1.0 didn't do the trick there either. 'sense'
> > reported was 00.00.00 though.
> 
> Any dmesg errors from 2.4.28? The sense reporting might be a bit broken
> there, but if you don't set cgc->quiet it should report the error in the
> kernel ring buffer at least.

No errors in dmesg. speedcontrol.c only reported that same error that
this current kernel did, but with sense 00.00.00.


-- 
psi -- http://iki.fi/psavo
