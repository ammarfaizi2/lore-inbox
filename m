Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbTCMRgh>; Thu, 13 Mar 2003 12:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262482AbTCMRgh>; Thu, 13 Mar 2003 12:36:37 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6784 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262478AbTCMRga>; Thu, 13 Mar 2003 12:36:30 -0500
Date: Thu, 13 Mar 2003 12:46:44 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ed Vance <EdV@macrolink.com>
cc: "'Linux PPP'" <linuxppp@indiainfo.com>, linux-serial@vger.kernel.org,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: RS485 communicatio
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33DDF@EXCHANGE>
Message-ID: <Pine.LNX.3.95.1030313123550.405A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Mar 2003, Ed Vance wrote:

> On Wed, Mar 12, 2003 at 10:15 PM, linuxppp@indiainfo.com wrote:
> > Hi all,
> > am currently working on PPP over serial interface (RS485) in 
> > linux 2.4.2-2. I believe RS485 half duplex system and hence 
> > only one can transmit at a time. And for RS485 we basicaly 
> > use Master-Slave or Primary-Secondary kind of communication. 
> > I don't know how to achieve the same using PPP since i need 
> > to have max of 10 nodes connected via serial interface. I 
> > tested with two nodes using PPP daemon it works fine. 
> > Following are the commands i issued
> > 
> > In PPP server: 
> > $usr/sbin/pppd -detach crtscts 10.10.10.100:10.10.10.101 
> > 115200 /dev/ttyS0 &
> > 
> > In PPP client side : 
> > $/usr/sbin/pppd call ppp-start 
> > where ppp-start file is copied into directory /etc/ppp/peers/ 
> > that had the following
> > 
> > -detach /dev/ttyS0 115200 crtscts
> > noauth
> > 
> > This point to point communication worked fine with RS485 
> > interface. If i had to connect one more node what i need to 
> > do. Please clarify with the following 
> > 
> > i) Whether the existing pppd takes care of the RS485 with 
> > multi node , if so how do i manage giving commands
> > ii) If there is no direct support how do i go ahead. Is there 
> > any other layer 2 protocol allows me to acheive TCP/IP 
> > communicattion over RS485 which is my ultimatum.
> > 
> > I will be grateful if anybody of them could help me with my 
> > current problem.
> > 
> 
> I believe Point-to-Point Protocol only supports point-to-point symmetric
> links. Don't think there is any multi-point support in the protocol. IIRC,
> PPP also requires a full duplex link, which is not available on an RS-485
> link with more than two stations, even if it is a 4-wire link. 
> 
> I don't know of an easy way around this fundamental limitation.
> 
> Maybe somebody on the kernel list has a suggestion.
> 
> Cheers

TCP/IP only requires two-way communicaton. It does not even
have to be reliable. There are IP/SCSI adapters and fibre
channel adapters already in the kernel.

Therefore, you just make a driver that substitutes for a
network communications adapter and away you go. PPP does not,
in principle, require simultaneous two-way communications.
However, current implimentations expect that a modem is
attached.

You should be able to use any serial cmmunications device
for a PPP link although one would have to make a serial driver
that handles the TX/RX direction-change in a transparent manner
as well as the RS-485 "address" problem. If the drivers on each
connected host communicate with each other, i.e., resolve their
own address problems,, then the payload between these hosts can
be the communications channels for PPP.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


