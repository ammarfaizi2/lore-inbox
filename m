Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSK0GyY>; Wed, 27 Nov 2002 01:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSK0GyY>; Wed, 27 Nov 2002 01:54:24 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:31967 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261599AbSK0GyX>; Wed, 27 Nov 2002 01:54:23 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 26 Nov 2002 23:01:24 -0800
Message-Id: <200211270701.XAA23288@adam.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Modules with list
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz, zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:
>In message <200211260649.WAA22216@adam.yggdrasil.com> you write:
>> >TCP for example, sets the destructor function for the skb.  It can be
>> >called an arbitrary time later.  Netfilter modules do a similar thing,
>> >for similar reasons.  You'd better grab a reference to *something*.
>> 
>> 	The ->remove() function of a network device driver will
>> not return until it has freed all receive skb's that it allocated
>> and all transmit skb's that were passed to its transmit function.

>I'm not talking about a device driver, but modularizing the IPv4
>stack.

	I don't see skb->destructor being set in net/ipv4 (although I
see it in other net/ subdirectories).  Anyhow, I don't see why ipv4
would need to increment or decrement a module reference count every
time a packet is sent or received.  It should suffice to do so when a
file descriptor is opened or closed and when a network connection is
created or completely forgotten (if that does not necessarily happen
before the close system call returns).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

