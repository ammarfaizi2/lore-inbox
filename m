Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290750AbSBGSG2>; Thu, 7 Feb 2002 13:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291155AbSBGSGR>; Thu, 7 Feb 2002 13:06:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:38788 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290750AbSBGSF6>; Thu, 7 Feb 2002 13:05:58 -0500
Date: Thu, 7 Feb 2002 13:08:24 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Perches, Joe" <joe.perches@spirentcom.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: want opinions on possible glitch in 2.4 network error reporti ng
In-Reply-To: <9384475DFC05D2118F9C00805F6F263107ECA811@exchange1.netcomsystems.com>
Message-ID: <Pine.LNX.3.95.1020207125644.8721A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Perches, Joe wrote:
[SNIPPED..]
> > That is correct UDP behaviour 
> 
> Do you think this is the correct PacketSocket/RAW behaviour?

Yes.

> How does one guarantee a send/sendto/write?
> -

Easy, you use send() or write(). These work on stream protocol TCP/IP
where there is a "connection". Connectionless protocols, i.e., UDP are
not guaranteed to do anything useful -- but, because of their speed,
they can be useful with some help from user-mode code.

Example file x-fer:
  Connection says: Here is a N-byte file, sent in numbered blocks over
         UDP port Y.
  UDP sender: sends all the file blocks.
  Receiver:  receives all the UDP data except Z numbered blocks.
  Receiver connection says: send me Z numbered blocks.
  UDP sender: sends the missing blocks
  Receiver: receives all UDP data except Z! numbered blocks.
  Receiver connection says: send me Z! numbered blocks.
  /// This repeats until there are no missing blocks.
  Receiver connection says: Thanks and hangs up.

  Now, since every UDP packet is not ACKed in the network layer,
  the through-put can be very high. Only the missing data needs
  to be replaced. Even with 10 percent missing data, such a transfer
  can be much faster than TCP/IP with high-latency links (like satellite).


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


