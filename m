Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbSJQKnz>; Thu, 17 Oct 2002 06:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261352AbSJQKne>; Thu, 17 Oct 2002 06:43:34 -0400
Received: from edu.joroinen.fi ([195.156.135.125]:41998 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S261347AbSJQKmT> convert rfc822-to-8bit;
	Thu, 17 Oct 2002 06:42:19 -0400
Date: Thu, 17 Oct 2002 13:48:17 +0300 (EEST)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: pk@edu.joroinen.fi
To: "G.de-With" <G.de-With@herts.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: I/O performance test
In-Reply-To: <3DAE89B1.F58E90C3@herts.ac.uk>
Message-ID: <Pine.LNX.4.44.0210171342560.5519-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Oct 2002, G.de-With wrote:

> Hello
>
> Since a month we have a LINUX BEOWULF cluster, the clusters contains 7
> P4 dual processor 2GHz computers, with 8Gb of RAM per machine. For our
> network we have used Gigabit ethernet. On our cluster we are running RH
> 7.2, with Linux 2.4.19.
>
> These are some of the hardware specs:
>
> - Dual Intel Xeon 2.GHz, 512 cache 400 MHz FSB
> - 8 Gb ECC DDR
> - Fujitsu 72Gb 10.000 rpm Ultra 160 SCA HDD SCSI HARDDISK
>
> The problem we have with our cluster is as follows. When running large
> scientific simulations the computer performance gradually goes down as
> the I/O activity is increasing. At some point the response of the
> computer is so poor that we have to kill the simulation. In a worst case
> when the simulation was running overnight the computer hangs and a reset
> of the computer is necessary. Nevertheless, even when we manage to kill
> the simulation in time the computer remains very slow and a reboot is
> necessary to regain full computer power.
>
> My first suspicion was that the computer simply started swapping, but
> there is no swap space being used, instead free RAM memory is still
> apparent
> (between 5-10%) and only 90% of the RAM is in use whereby 50% is cached
> and another 50% is in usage. In addition the cpu usage is very low as
> well.
>
> To investigate the I/O performance I installed an I/O performance
> benchmark program called bonnie++. The first test I performed was a
> single bonnie++ -s 16096 instance.
>
> # bonnie++ -s 16096
>
> Unfortunately, as a result of running bonnie++ the computer started to
> slow down till it finally hang. All the symptoms I discover with
> bonnie++ are identical to what I experience when running our scientific
> calculations.
>
> In order to improve the I/O performance I have add some patches to the
> kernel, including the patch for 00_block-highmem-all-19-1, to avoid
> bounce buffers. Unfortunately none of the patches let to any improvement
> in the I/O performance.
>
> I don't think the machine should be behaving like this. I certainly
> expect some slowdowns with that much IO, but the computer should still
> be reasonably responsive, particularly because no system or user files
> that need to be accessed are on that channel of the SCSI controller.
>
> As a sort of a desperate move I did two other test in addition which
> could be of use to the understanding of the problem:
>
> - I removed 6Gb from the server and run the test bonnie++ -s 16096
> succesfully with 2Gb of RAM.
> - I placed an IDE disk 40Gb and run the test bonnie++ -s 16096 with 8Gb
> of RAM succesfully.
>
>
> Any advice on approaching this problem would be appreciated.
>

I'm not expert on this, but I would try with -aa patches for 2.4.19
kernel. They work really well for me, and are stable, and also perform
better than vanilla 2.4.19.

2.4.19rc5aa1 applies cleanly to 2.4.19 final (because rc5 and final are
the same kernel).

-aa patches are available from kernel.org mirrors
(people/andrea/kernels/v2.4/2.4.19rc5aa1.bz2)


- Pasi Kärkkäinen

                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

