Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273210AbRISFrl>; Wed, 19 Sep 2001 01:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274003AbRISFrV>; Wed, 19 Sep 2001 01:47:21 -0400
Received: from celebris.bdk.pl ([212.182.99.100]:21253 "EHLO celebris.bdk.pl")
	by vger.kernel.org with ESMTP id <S273210AbRISFrT>;
	Wed, 19 Sep 2001 01:47:19 -0400
Date: Wed, 19 Sep 2001 07:49:17 +0200 (CEST)
From: Wojtek Pilorz <wpilorz@bdk.pl>
To: Bruce Blinn <blinn@MissionCriticalLinux.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, root@chaos.analogic.com,
        Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
In-Reply-To: <3BA7BA06.B7E61F63@MissionCriticalLinux.com>
Message-ID: <Pine.LNX.4.21.0109190740100.31311-100000@celebris.bdk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001, Bruce Blinn wrote:

> Date: Tue, 18 Sep 2001 14:17:58 -0700
> From: Bruce Blinn <blinn@MissionCriticalLinux.com>
> To: Wojtek Pilorz <wpilorz@bdk.pl>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, root@chaos.analogic.com,
>      Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>,
>      linux-kernel@vger.kernel.org
> Subject: Re: Reading Windows CD on Linux 2.4.6
> 
> Wojtek Pilorz wrote:
> > 
> > Could you try
> > cdrecord -toc dev=x,y
> > where x,y are numbers returned for your SCSI (either native or emulated)
> > device by
> >  cdrecord -scanbus
The result  of this command (at the end of your mail) clearly indicates
that this is a multi-session disk, do you can't expect to be able to copy
its contents with dd;
Why kernel 2.2.19 is able to read this disk, while 2.4.6 cannot is another
problem. Either 2.4.6 cannot handle multi-session disks (I would be
surprised if that would be case, although I have not checked), or maybe
the Windows CD-mastering/recording software you are using makes some
departure from standards, which is tolerated by 2.2.19, but not by 2.4.6;
You might want to look at your /var/log/messages file and possibly check
whether it is possible to get more debugging output from the kernel (cdrom
driver?)


> 
> I think I finally got the cdrecord command to work (thanks Tobias).  By
> the way, after today, I will be on vacation until Monday, so if I don't
> reply to messages, don't think that it is that I do not appreciate all
> the help that I am getting.
> 
> Thanks,
> Bruce
> 
> # cdrecord -scanbus
> Cdrecord 1.8 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
> Using libscg version 'schily-0.1'
> scsibus0:
> cdrecord: Warning: controller returns wrong size for CD capabilities
> page.
>         0,0,0     0) 'Lite-On ' 'LTN483S 48x Max ' 'PD02' Removable
> CD-ROM
>         0,1,0     1) *
[...]
> # cdrecord -toc dev=0,0,0
> Cdrecord 1.8 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
> scsidev: '0,0,0'
> scsibus: 0 target: 0 lun: 0
> Using libscg version 'schily-0.1'
> cdrecord: Warning: controller returns wrong size for CD capabilities
> page.
> Device type    : Removable CD-ROM
> Version        : 0
> Response Format: 1
> Vendor_info    : 'Lite-On '
> Identifikation : 'LTN483S 48x Max '
> Revision       : 'PD02'
> Device seems to be: Generic mmc CD-ROM.
> cdrecord: Warning: controller returns wrong size for CD capabilities
> page.
> cdrecord: Warning: controller returns wrong size for CD capabilities
> page.
> cdrecord: Warning: controller returns wrong size for CD capabilities
> page.
> Using generic SCSI-3/mmc CD driver (mmc_cd).
> Driver flags   : SWABAUDIO
> first: 1 last 2
> track:   1 lba:         0 (        0) 00:02:00 adr: 1 control: 6 mode: 2
> track:   2 lba:       512 (     2048) 00:08:62 adr: 1 control: 5 mode: 2

======== ^^^^^^ ==============
> track:lout lba:     14144 (    56576) 03:10:44 adr: 1 control: 5 mode:
> -1
> #
> 

