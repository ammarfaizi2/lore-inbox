Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261311AbSJQKGn>; Thu, 17 Oct 2002 06:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261314AbSJQKGn>; Thu, 17 Oct 2002 06:06:43 -0400
Received: from hestia.herts.ac.uk ([147.197.200.9]:61163 "EHLO
	hestia.herts.ac.uk") by vger.kernel.org with ESMTP
	id <S261311AbSJQKGl>; Thu, 17 Oct 2002 06:06:41 -0400
Message-ID: <3DAE89B1.F58E90C3@herts.ac.uk>
Date: Thu, 17 Oct 2002 10:58:10 +0100
From: "G.de-With" <G.de-With@herts.ac.uk>
Organization: University of Hertfordshire
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: I/O performance test
References: <200209260854.g8Q8s1403660@blueraja.scyld.com> <3D9316D4.28D4904D@herts.ac.uk> <3DAD8DA3.95DBD7C5@herts.ac.uk> <3DAD91C0.B8FC2B4C@herts.ac.uk> <3DADB02B.3725A191@herts.ac.uk> <3DAE162D.D36EB07A@herts.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner: No Virus detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Since a month we have a LINUX BEOWULF cluster, the clusters contains 7
P4 dual processor 2GHz computers, with 8Gb of RAM per machine. For our
network we have used Gigabit ethernet. On our cluster we are running RH
7.2, with Linux 2.4.19.

These are some of the hardware specs:

- Dual Intel Xeon 2.GHz, 512 cache 400 MHz FSB
- 8 Gb ECC DDR
- Fujitsu 72Gb 10.000 rpm Ultra 160 SCA HDD SCSI HARDDISK

The problem we have with our cluster is as follows. When running large
scientific simulations the computer performance gradually goes down as
the I/O activity is increasing. At some point the response of the
computer is so poor that we have to kill the simulation. In a worst case
when the simulation was running overnight the computer hangs and a reset
of the computer is necessary. Nevertheless, even when we manage to kill
the simulation in time the computer remains very slow and a reboot is
necessary to regain full computer power.

My first suspicion was that the computer simply started swapping, but
there is no swap space being used, instead free RAM memory is still
apparent
(between 5-10%) and only 90% of the RAM is in use whereby 50% is cached
and another 50% is in usage. In addition the cpu usage is very low as
well.

To investigate the I/O performance I installed an I/O performance
benchmark program called bonnie++. The first test I performed was a
single bonnie++ -s 16096 instance.

# bonnie++ -s 16096

Unfortunately, as a result of running bonnie++ the computer started to
slow down till it finally hang. All the symptoms I discover with
bonnie++ are identical to what I experience when running our scientific
calculations.

In order to improve the I/O performance I have add some patches to the
kernel, including the patch for 00_block-highmem-all-19-1, to avoid
bounce buffers. Unfortunately none of the patches let to any improvement
in the I/O performance.

I don't think the machine should be behaving like this. I certainly
expect some slowdowns with that much IO, but the computer should still
be reasonably responsive, particularly because no system or user files
that need to be accessed are on that channel of the SCSI controller.

As a sort of a desperate move I did two other test in addition which
could be of use to the understanding of the problem:

- I removed 6Gb from the server and run the test bonnie++ -s 16096
succesfully with 2Gb of RAM.
- I placed an IDE disk 40Gb and run the test bonnie++ -s 16096 with 8Gb
of RAM succesfully.


Any advice on approaching this problem would be appreciated.

Govert

--
 ------------------------------------------------------------
| Dr. Govert de With     Research Fellow                     |
| Fluid Mechanics Research Group                             |
| University of Hertfordshire                                |
| Tel: 01707 284124 Fax: 01707 285086                        |
 ------------------------------------------------------------
| Der Horizont vieler Menschen ist ein Kreis mit Radius Null |
| und das nennen sie ihren Standpunkt.                       |
 ------------------------------------------------------------



