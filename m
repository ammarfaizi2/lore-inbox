Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132577AbRDQJ61>; Tue, 17 Apr 2001 05:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132578AbRDQJ6S>; Tue, 17 Apr 2001 05:58:18 -0400
Received: from access-35.98.rev.fr.colt.net ([213.41.98.35]:33286 "HELO
	phoenix.linuxatbusiness.com") by vger.kernel.org with SMTP
	id <S132577AbRDQJ6H>; Tue, 17 Apr 2001 05:58:07 -0400
Subject: Re: Ide performance (was RAID0 Performance problems)
From: Philippe Amelant <philippe.amelant@free.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/0.10+cvs.2001.04.11.08.00 (Preview Release)
Date: 17 Apr 2001 11:57:09 +0200
Message-Id: <987501429.27672.5.camel@avior>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have the same problem, but i think it 's a BX chipset related problem.

I Have a BP6 whit a BX chipset and a htp 366 chipset.
on a single device, hdparm report ~ 18/19 MB/s

with 2 devices on the same chipset (hda/hdc) 
hdparm report ~ 9 MB/s each

with 2 devices not on the same chipset (hda/hdg)
hdparm report ~ 16/17 MB/s 

Le 15 Apr 2001 21:08:04 +0200, Andreas Peter a écrit :
> Hi,
> I've posted about performance problems with my RAID0 setup.
> RAID works fine, but it's too slow.
> But now it seems not to be a problem with the md code, it's an ide problem.
> There are two HDs in my PC: /dev/hda and /dev/hdc. No other devices are 
> attached to the ide-bus.
> PC is a SMP-System, 2 Celeron 533, Gigabyte 6BXDS with Intel BX-Chipset, 
> 66MHz FSB.
> The hdparm settings: 
> 
> bash-2.04# hdparm /dev/hda /dev/hdc
>  
> /dev/hda:
>  multcount    =  0 (off)
>  I/O support  =  3 (32-bit w/sync)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  0 (off)
>  geometry     = 59556/16/63, sectors = 60032448, start = 0
>  
> /dev/hdc:
>  multcount    =  0 (off)
>  I/O support  =  3 (32-bit w/sync)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  0 (off)
>  geometry     = 59556/16/63, sectors = 60032448, start = 0
> 
> I've tested a lot of variations of this settings (multcount=16, 
> unmaskirq=0...) without succes. 
> The performance of the RAID doesn't increase :-(
> hdparm -tT on a single HD (dev/hda3 is the RAID-partition) reports a very 
> good performance:
> 
> bash-2.04# hdparm -tT /dev/hda3
>  
> /dev/hda3:
>  Timing buffer-cache reads:   128 MB in  1.42 seconds = 90.14 MB/sec
>  Timing buffered disk reads:  64 MB in  2.27 seconds = 28.19 MB/sec
> 
> But if I start 2 hdparms simultanous (one on /dev/hda3 the other on 
> /dev/hdc3) the performance on the HDs decreases to 1/2 of the original speed:
> 
> bash-2.04# hdparm -tT /dev/hda3
>  
> /dev/hda3:
>  Timing buffer-cache reads:   128 MB in  2.27 seconds = 56.39 MB/sec
>  Timing buffered disk reads:  64 MB in  4.56 seconds = 14.04 MB/sec
> 
> bash-2.04# hdparm -tT /dev/hdc3
>  
> /dev/hdc3:
>  Timing buffer-cache reads:   128 MB in  2.25 seconds = 56.89 MB/sec
>  Timing buffered disk reads:  64 MB in  4.49 seconds = 14.25 MB/sec
> 
> The performance of the RAID0:
> 
> bash-2.04# hdparm -tT /dev/md0
>  
> /dev/md0:
>  Timing buffer-cache reads:   128 MB in  1.35 seconds = 94.81 MB/sec
>  Timing buffered disk reads:  64 MB in  3.11 seconds = 20.58 MB/sec
> 
> Tests with bonnie or iozone have the same reuslts, RAID is slower then a 
> single HD :-(
> 
> Does anybody has an idea what's wrong with my setup??
> 
> Thx,
> Andreas
> -- 
> Andreas Peter *** ujq7@rz.uni-karlsruhe.de
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

