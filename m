Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136247AbREGQNg>; Mon, 7 May 2001 12:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136253AbREGQN1>; Mon, 7 May 2001 12:13:27 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13184 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S136247AbREGQNQ>; Mon, 7 May 2001 12:13:16 -0400
Date: Mon, 7 May 2001 12:12:57 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: alexander.eichhorn@rz.tu-ilmenau.de, linux-kernel@vger.kernel.org
Subject: Re: [Question] Explanation of zero-copy networking
In-Reply-To: <E14wlUi-0003WQ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1010507121212.4256A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2001, Alan Cox wrote:

> > documented so far) detailed description of the newly 
> > implemented zero-copy mechanisms in the network-stack. 
> > We are interested in how to use it (changed network-API?) 
> > and also in the internal architecture. 
> 
> It is built around sendfile. Trying to do zero copy on pages with user space
> mappings get so horribly non pretty it is better to build the API from the
> physical side of things.
> 
> > Our second question: Are there any plans for contructing 
> > a general copy-avoidance infrastructure (smth. like UVM in 
> > NetBSD does) and new IPC-mechanisms on top of it yet??
> 
> Andrea Arcangeli has O_DIRECT file I/O for the ext2 file system. There are also
> several patches for kiovec based single copy pipes have been posted too.
> 
> 

The Networking RFCs talk about "not copying data" as they
attempt to give pointers on improving network speed.

However, PCI to memory copying runs at about 300 megabytes per
second on modern PCs and memory to memory copying runs at over 1,000
megabytes per second. In the future, these speeds will increase.

I don't advise retrofitting network code to improve the speed of
older machines. Instead, time should be spent to improve the
robustness and capability of the networking speed and accommodating
the new breeds of GHz network boards.

In case anybody is interested, Networking remains a serial communications
element. As such, it functions as a low-pass filter. The speed of
a serial communications link is set primarily by the dominant pole
of the links transfer function, which in the frequency domain, is
information_rate * 2. With 100 megabits/second link we have
200 MHz as the dominent pole. The 2 comes from Shannon, it takes
2 carrier events to determine if anything has changed (to transfer
information).  Therefore, if we can detect changes 100 million times
per second, the information carrier must have been at least 200 MHz.
This is the dominent pole.

With a 300 Megabyte / second transfer via PCI, the information carrier
must have been 300 * 8 * 2 = 4,800 MHz. This is 4,800/200 = 24 times
the frequency of the dominent pole of the network transfer function.
This is so far removed from the dominent pole of the system's transfer
function that even doubling the PCI speed (66 MHz v.s. 33 MHz) will
have no measurable affect upon networking speed. With existing kernels,
you can perform network speed tests using "lo", removing the network
board from the speed test. You will note that the network speed, due
to software, is over 10 times faster, 30 times on some machines) than
when the hardware I/O is used. This shows that the network code, alone,
cannot be improved very much to provide an improvement in throughput.

However, a new breed of GHz boards are now available. These boards
have a dominent pole of 1000 * 2 = 2000 MHz. This is rougly one-
half of the PCI bandwidth, and roughly the same as a 66 MHz bus.

This is where some work needs to be done.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


