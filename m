Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130823AbRBVAXe>; Wed, 21 Feb 2001 19:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130829AbRBVAXY>; Wed, 21 Feb 2001 19:23:24 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:37567 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130823AbRBVAXQ>; Wed, 21 Feb 2001 19:23:16 -0500
Date: Wed, 21 Feb 2001 18:33:13 -0500
From: "Michael B. Allen" <mballen@erols.com>
To: Wayne Whitney <whitney@math.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.17 Lockup and ATA-66/100 forced bit set (WARNING)
Message-ID: <20010221183313.A3487@angus.foo.net>
In-Reply-To: <20010221173439.A3178@angus.foo.net> <200102212348.f1LNm6X02792@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200102212348.f1LNm6X02792@adsl-209-76-109-63.dsl.snfc21.pacbell.net>; from whitney@math.berkeley.edu on Wed, Feb 21, 2001 at 03:48:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 03:48:06PM -0800, Wayne Whitney wrote:
> >  append="idebus=66 ide0=ata66"
> 
> The idebus=66 part is incorrect.  This option refers to the clock of
> the PCI bus the IDE controller is on and should rarely be changed from
> the default of 33MHz (i.e., only if you are overclocking the PCI bus).

Ah, well I just added that based on the end of this boot message:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

> >kernel: VP_IDE: ATA-66/100 forced bit set (WARNING)!! 
> 
> I'm sure this is just telling you that you passed the ide0=ata66
> parameter.  Usually it is best not to do this--the driver should run
> your chipset/drive as fast as possible without 'forcing' the
> configuration.  Of course, testing with hdparm -t is considered the
> definitive way to check how fast the interface is running.

If I don't add it hdparm -t /dev/hda reports:

 Timing buffered disk reads:  64 MB in 16.46 seconds =  3.89 MB/sec

Then if I do hdparm -d1 -X66 /dev/hda I get:

/dev/hda:
 setting using_dma to 1 (on)
 setting xfermode to 66 (UltraDMA mode2)
 using_dma    =  1 (on)

[root@nano /root]# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  64 MB in  4.04 seconds = 15.84 MB/sec

Now if I add it via append, reboot and do hdparm -t I get:

 Timing buffered disk reads:  64 MB in  3.70 seconds = 17.30 MB/sec

This last difference is consistently better. Weird.

All your other bets were right too.

Thanks Wayne,
Mike

-- 
signature pending
