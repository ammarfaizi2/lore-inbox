Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284557AbRLMSfU>; Thu, 13 Dec 2001 13:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284569AbRLMSfK>; Thu, 13 Dec 2001 13:35:10 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9344 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S284557AbRLMSfE>; Thu, 13 Dec 2001 13:35:04 -0500
Date: Thu, 13 Dec 2001 13:34:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Bradley D. LaRonde" <brad@ltc.com>
cc: Thomas Capricelli <orzel@kde.org>, linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently
In-Reply-To: <07cd01c18401$fa397db0$5601010a@prefect>
Message-ID: <Pine.LNX.3.95.1011213132109.707A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, Bradley D. LaRonde wrote:
[SNIPPED...]

> Sent: Thursday, December 13, 2001 1:02 PM Subject: Re: Mounting a in-ROM
> filesystem efficiently
> 
> 
> > Generally, ROM based stuff is compressed before being written to >
> NVRAM. It's uncompressed into a RAM-Disk and the RAM-Disk is mounted.  >
> > That way, you can use, say, 2 megabytes of NVRAM to get a 10 to 20 >
> megabyte root file-system. This also allows /tmp and /var/log to be >
> writable, which is a great help because the development environment >
> closely approximates the run-time environment. 
> 
> That's perfect if you have plenty of RAM to spare. 
> 

Well RAM is a hell of a lot cheaper than NVRAM. If you don't have
the required RAM on your box, the hardware engineers screwed up
and have to be "educated" preferably with an axe in the parking-lot.

The machine configuration should NOT have NVRAM addressed as a
bunch of RAM occupying a lot of address space. It should be
an easily-decodable chunk (0x1000, 0x2000, 0x4000, 0x8000, etc.)
that is paged, under software control. The base address should
be wherever memory-mapped hardware for your architecture usually
is.

> > FYI, generally NVRAM access is sooooo slow. I don't think you'd
> > like to use it directly as a file-system and access-time will be
> > a problem unless you modify the kernel. 
> 
> Modify the kernel how?
>

You have to keep it from failing when it tries to update the access-time
of files/directories. This means that your read/only NVRAM/ROM must
either pretend that it can be written or the driver for the hardware
has to do the same.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
 Santa Claus is coming to town...
          He knows if you've been sleeping,
             He knows if you're awake;
          He knows if you've been bad or good,
             So he must be Attorney General Ashcroft.


