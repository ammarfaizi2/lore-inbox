Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbSJWRsr>; Wed, 23 Oct 2002 13:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265136AbSJWRsr>; Wed, 23 Oct 2002 13:48:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:34950 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265135AbSJWRsk>; Wed, 23 Oct 2002 13:48:40 -0400
Date: Wed, 23 Oct 2002 13:56:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Nivedita Singhvi <niv@us.ibm.com>
cc: bert hubert <ahu@ds9a.nl>, Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       "David S. Miller" <davem@rth.ninka.net>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] tuning linux for high network performance?
In-Reply-To: <3DB6D877.3D5489DA@us.ibm.com>
Message-ID: <Pine.LNX.3.95.1021023133435.14975B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Nivedita Singhvi wrote:

> bert hubert wrote:
> 
> > I still refuse to believe that a 1.8GHz Pentium4 can only checksum
> > 250megabits/second. MD Raid5 does better and they probably don't use a
> > checksum as braindead as that used by TCP.
> > 
> > If the checksumming is not the problem, the copying is, which would be a
> > weakness of your hardware. The function profiled does both the copying and
> > the checksumming.
> 
> Yep, its not so much the checksumming as the fact that this is
> done over each byte of data and copied.
> 
> thanks,
> Nivedita

No. It's done over each word (short int) and the actual summation
takes place during the address calculation of the next word. This
gets you a checksum that is practically free.

A 400 MHz ix86 CPU will checksum/copy at 685 megabytes per second.
It will copy at 1,549 megabytes per second. Those are megaBYTES!

If you have slow network performance it has nothing to do with
either copy or checksum. Data transmission acts like a low-pass
filter. The dominant pole of that transfer function determines
the speed, that's why it's called dominant. If you measure
a data-rate of 10 megabytes/second. Nothing you do with copy
or checksum will affect it to any significant extent.

If you have a data-rate of 100 megabytes per second, then any
tinkering with copy will have an effective improvement ratio
of 100/1,559 ~= 0.064. If you have a data rate of 100 megabytes
per second and you tinker with checksum, you get an improvement
ratio of 100/685 ~=0.14. These are just not the things that are
affecting your performance.

If you were to double the checksumming speed, you increase the
throughput by 2 * 0.14 = 0.28 with the parameters shown.

The TCP/IP checksum is quite nice. It may have been discovered
by accident, but it's still nice. It works regardless of whether
you have a little endian or big endian machine. It also doesn't
wrap so you don't (usually) show a good checksum when the data
is bad. It does have the characteristic that if all the bits are
inverted, it will checksum good. However, there are not too many
real-world scenarios that would result in this inversion. So it's
not "brain-dead" as you state. A hardware checksum is really
quick because it's really easy.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


