Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVGMJ3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVGMJ3D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 05:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVGMJ3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 05:29:02 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:46060 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261493AbVGMJ3B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 05:29:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ju1HZXXsSnGhCninvb7THjJ1Tvh4ngHRyn+vZ2PzBzhE+WPc7vgyf3StYaWCbho+TE5lOYTIRT4rY9euRFvtR67MgYXgrqUDcSa4Sw32wec2MMN/QBvWsarbG3pzKVLO6lqL/B1enLXcCRHV2YC1TxDuZasEfJEwEWwiQZ7gyTI=
Message-ID: <6f6293f1050713022916435dd0@mail.gmail.com>
Date: Wed, 13 Jul 2005 11:29:00 +0200
From: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Reply-To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
To: Alasdair G Kergon <agk@redhat.com>,
       Felipe Alfaro Solana <felipe.alfaro@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2-mm2
In-Reply-To: <20050712202436.GA12341@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050712021724.13b2297a.akpm@osdl.org>
	 <6f6293f10507121116363ff57c@mail.gmail.com>
	 <20050712202436.GA12341@agk.surrey.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What's your device-mapper/lvm configuration and what 'lvm' command
> did you run to trigger this?

Nothing special... it happens while booting Fedora Core 4.

>   'dmsetup info -c'
>   'dmsetup table'
>   'lvs --segments -o+devices -a'

# cat /etc/fstab
/dev/VolGroup00/Root    /                       ext3    defaults        1 1
/dev/VolGroup00/Home    /home                   ext3    nodev           1 2
/dev/VolGroup00/Swap     none                   swap    defaults        0 0

# dmsetup info -c
Name             Maj Min Stat Open Targ Event  UUID
VolGroup00-Home  253   2 L--w    1    1      0
pooZ0kfkAXH04Jai0ih2M1YtE1FNgI2xdn8wPAEh3ROBTzYw6gG7qEnYMDn5hfeR
VolGroup00-Swap  253   1 L--w    1    1      0
pooZ0kfkAXH04Jai0ih2M1YtE1FNgI2x1ITYve4bdfV53jjNMWTa3w24BBFFLI3t
VolGroup00-Root  253   0 L--w    1    1      0
pooZ0kfkAXH04Jai0ih2M1YtE1FNgI2x7HHDn3Iw4wxcQNBHO0gEDMoe7Nta2xv0

# dmsetup table
VolGroup00-Home: 0 190414848 linear 3:2 42008960
VolGroup00-Swap: 0 1048576 linear 3:2 40960384
VolGroup00-Root: 0 40960000 linear 3:2 384

# lvs --segments -o+devices -a
  LV   VG         Attr   #Str Type   SSize   Devices         
  Home VolGroup00 -wi-ao    1 linear  90.80G /dev/hda2(5128) 
  Root VolGroup00 -wi-ao    1 linear  19.53G /dev/hda2(0)    
  Swap VolGroup00 -wi-ao    1 linear 512.00M /dev/hda2(5000)
