Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262119AbSJQVKZ>; Thu, 17 Oct 2002 17:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbSJQVKZ>; Thu, 17 Oct 2002 17:10:25 -0400
Received: from mailc.telia.com ([194.22.190.4]:44022 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S262119AbSJQVKX>;
	Thu, 17 Oct 2002 17:10:23 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: "G.de-With" <G.de-With@herts.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: I/O performance test
Date: Thu, 17 Oct 2002 23:14:16 +0200
User-Agent: KMail/1.4.7
References: <200209260854.g8Q8s1403660@blueraja.scyld.com> <3DAE162D.D36EB07A@herts.ac.uk> <3DAE89B1.F58E90C3@herts.ac.uk>
In-Reply-To: <3DAE89B1.F58E90C3@herts.ac.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200210172310.54274.roger.larsson@skelleftea.mail.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On torsdagen den 17 oktober 2002 11.58, G.de-With wrote:
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

Do you have a 72 GB HD per dual processors? Or only on one?
Or do the data have to pass through the ethernet for your tests?

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

Could still be that all DMA or normal zone memory is used up.
Use the magic sysrq to get zone info.
 Alt+Sys Rq+M
check in vt10 (Alt+F10 or Ctrl+Alt+F10) or with dmesg

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

Fortunately!

You may have found a way for others to reproduce your problem :-)

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

This points towards a highmem issue...

> - I placed an IDE disk 40Gb and run the test bonnie++ -s 16096 with 8Gb
> of RAM succesfully.

This is why I asked the first question.

My guess: Highmem issue with Gb Ethernet?

Brand and model of the Ethernet boards?


-- 
Roger Larsson
Skellefteå
Sweden

