Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262635AbREOFSE>; Tue, 15 May 2001 01:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262637AbREOFRy>; Tue, 15 May 2001 01:17:54 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:8466 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262635AbREOFRl>; Tue, 15 May 2001 01:17:41 -0400
Date: Mon, 14 May 2001 22:17:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alexander Viro <viro@math.psu.edu>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: Getting out of hand?
In-Reply-To: <Pine.LNX.4.21.0105142114310.23663-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105142207030.23663-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 May 2001, Linus Torvalds wrote:
> 
> How hard is it to generate a new "disk driver framework", and let people
> register themselves, kind of like the "misc" drivers do. Except we'd only
> allow DISKS. You could add something like
> 
> 	register_disk_driver("compaq-ciss", nr_disks, &my_queue);

Note: one _important_ part of this is that absolutely _nobody_ registers a
disk driver except for a controller that is physically found on the
machine. 

None of this stupid "we have numbers pre-allocated for hardware that does
not even exists on this machine" crap that the current setup is full of. 

This way, you can pretty much depend on the fact that in any "normal"
configuration, you'll find disks at "disk0", "disk1", ... completely
regardless of whether the machine has a IDE controller, a "old-fashioned
SCSI" controller, or a Compaq smart-raid controller. And THAT is useful.  
You can migrate filesystem setups from one machine to another, without
worrying about the fact that one machine has IDE disks and another has
SCSI disks - the filesystem will just work, and the kernels will just
boot.

THAT is how it is supposed to work.

For people who care about where the disks are (0.01% of all people, and
half of those are misguded anyway), you can have a /proc interface or an
ioctl or something. 

But don't make excuses for the current setup. And understand why we must
NOT continue to just give out major numbers indiscriminately.

[ Oh, and _please_ don't Cc: me on this discussion. I'm not that
  interested. I know what I want, and I've let the current mess go on for
  too long. If it takes some pain to fix it, then so be it. It needs to be
  fixed, even if people suddenly start thinking that the light of my a**
  dimmed a bit. That's ok. I just don't want to really fill my inbox - I
  read the kernel mailing list with a newsreader and the "D" key. ]

		Linus

