Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135268AbRD3Olv>; Mon, 30 Apr 2001 10:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135277AbRD3Oll>; Mon, 30 Apr 2001 10:41:41 -0400
Received: from [212.217.140.14] ([212.217.140.14]:51460 "HELO
	Iluvatar.nyren.net") by vger.kernel.org with SMTP
	id <S135268AbRD3Ola>; Mon, 30 Apr 2001 10:41:30 -0400
Date: Mon, 30 Apr 2001 16:41:26 +0200 (CEST)
From: Ralf Nyren <ralf@nyren.net>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4: Kernel crash, possibly tcp related
In-Reply-To: <15085.3340.784923.77844@pizda.ninka.net>
Message-ID: <Pine.LNX.4.31.0104301553560.4785-100000@Iluvatar.nyren.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Sun, 29 Apr 2001, David S. Miller wrote:

[snip]
>
> Anyways, I just tried to reproduce Ralf's problem on two of my
> machines.  One was an SMP sparc64 system, and the other was my
> uniprocessor Athlon.
>
> What kind of machine are you reproducing this on Ralf?  I'm not
> even getting the very strange errors from tcpblast on the command
> line, it is functioning perfectly fine and sending a stream of
> data to the other machine.  Are you doing something weird like
> making the remote machine the local machine in your tcpblast run?
>
> Later,
> David S. Miller
> davem@redhat.com
>


Sorry for not including a reference to the software. I used the
tcpblast program from Debian (unstable). It can be found in the
netdiag package:
http://ftp.debian.org/debian/dists/woody/main/source/net/netdiag_0.7.orig.tar.gz

Since this problem seemed a bit hard to reproduce I tested it on another
machine too. It needed some more load, but eventually crashed.
This machine is a PII 400MHz, 128MB, 440BX/ZX, PIIX. 3c905B network card.
For more information like .config, System.map, ver_linux etc see:
http://www.educ.umu.se/~plumbum/kernel/panic_2.4.4_20010430/

Regarding the strange error msg: tcp/udpblast send:: No such file or directory
both the precompiled binary and one compiled from the source produced
this message. Although I noticed that the min blocksize triggering the message
changed from 40481 to 39841. Probably some compiletime feature :)

Making remote machine the local machine... no, I send from my machine
to another. Both with 100Mbps network connections.

Reproduction procedure:
./tcpblast -d0 -s 200000 _another_host_ 9000
./forkbomb
wait...

The so called "forkbomb" shouldn't really be necessary, some heavy load
making use of scheduler, memory and swap seems to do the thing.

Hope this information could be helpful.

regards,
/Ralf

