Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSHWVG2>; Fri, 23 Aug 2002 17:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSHWVG2>; Fri, 23 Aug 2002 17:06:28 -0400
Received: from sw-55.SEDSystems.ca ([192.107.131.9]:19328 "EHLO
	sw-55.sedsystems.ca") by vger.kernel.org with ESMTP
	id <S311025AbSHWVG1>; Fri, 23 Aug 2002 17:06:27 -0400
Date: Fri, 23 Aug 2002 15:10:35 -0600 (CST)
From: Kendrick Hamilton <hamilton@sedsystems.ca>
To: uclinux <uclinux-dev@uclinux.org>, <linux-kernel@vger.kernel.org>
Subject: Disabling and Re-enabling the network card interrupt.
Message-ID: <Pine.LNX.4.44.0208231447170.1571-100000@sw-55.sedsystems.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can people CC me with there responses. I am on the uClinux developper's
mailing list but not the Linux developpers list.

Sorry for the long background explination but I needed it for my questions
to make sense.

We are build a Linux based system with a few hard realtime requirements.
It is based on an already designed card with a motorola 68360 processor
(processing power is similar to a 33MHz 386, uclinux 2.0.39 kernel with
tcp/ip stack). It has two real time requirements:
	1. It needs to poll a few memory locations every 10ms. I can use a
non-maskable interrupt and bi-pass the linux kernel (if needed) to ensure
the memroy locations get polled.
	2. If the poll detects an error, the systems needs to do a number
of operations on the serial ports and some other devices.

The processor is not running very many tasks and the few that are running
don't have to do a lot. The problem is the network. Most of the time, it
can interrupt the processor as data comes in except when an error has been
detected. When an error is detected, normal network traffic (broadcasts
from windows networking and other broadcasts along with TCP/IP packets
being sent to my application) could slow down significantly the processor
and prevent it from handling the error.

To stop the network from causing delays during the critical routine, I am
planning stopping the network card from interrupting the
processor in the polling interrupt service routine. Neither the kernel nor
the network driver will know that the interrupt has been disabled and
there code will not be affected (there is a Programable Logic Device
in between the processor and network card that I can add a register to
prevent the interrupt from getting through). The network card also has
about 2k of buffer space to hold data without the processor's help.

After all that background here are my questions:
	Will disabling the network interrupt for 1-2 seconds cause any
problems or will the TCP/IP stack handle that it lost a few packets and the
lower level handle the delay in acknowledgements? How long can I keep the
network interrupt disabled before I risk TCP connections being closed
because the computers communicating with my board think my board has been
disconnected from the network?

TIA,
Kendrick Hamilton

