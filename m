Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265274AbSJaTFH>; Thu, 31 Oct 2002 14:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265287AbSJaTFH>; Thu, 31 Oct 2002 14:05:07 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:2235 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265274AbSJaTEq> convert rfc822-to-8bit; Thu, 31 Oct 2002 14:04:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: jt@hpl.hp.com, Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Juan Gomez <juang@us.ibm.com>
Subject: Re: How to get a local IPv4 address from within a kernel module?
Date: Thu, 31 Oct 2002 13:09:35 -0600
User-Agent: KMail/1.4.1
Cc: Josh Myer <jbm@joshisanerd.com>, jbm@blessed.joshisanerd.com,
       linux-kernel@vger.kernel.org
References: <OFA4AB1D53.AE6E9560-ON87256C63.006382A4@us.ibm.com> <20021031183009.GB2972@bougret.hpl.hp.com>
In-Reply-To: <20021031183009.GB2972@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210311309.35451.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 October 2002 12:30 pm, Jean Tourrilhes wrote:
>         Now, there is only one thing that could qualify as "the node
> IP address", this is the IP address associated with the hostname :
>                 gethostbyname(hostname());
>         IMHO, if you define the interface you are proposing, it should
> always return the result above, because this is a well defined
> semantic and it is more useful.

Ummmmm... not quite the right answer - gethostbyname(hostname());
doesn't even have to return an IP number.

I have an environment right now that would make that result
useless. It is equivalent to using the 127.0.0.1 loopback.

We have a cluster where the address assgned to the hostname
is a nonroutable address, used only for internal communication
with other nodes in a cluster. The only way to get a "proper"
internet address is to request DNS for the address. And then
you might get back 35 addresses (would get 330 if the library
function would work properly).

It is also possible that NONE of the interfaces are assigned the
same name as the local host name. One of our environments
identifies a node by a frame/node construct. Addressing is
totally independant.

This association is only a convention, and is not something
mandatory.

Even at home, my systems have two or three addreses.

<external IP> applied to the firewall for external use
192.168.1.x for a small wireless network
192.168.0.x for the internal network
<external IP> for a dummy network device to make Kerberos work
192.168.2.x for a cluster network (some experimental systems).

The firewall has the first three, my workstation has the third and
fourth, and my toy cluster has the third and last.

There is no "node" IP number. Especially if you have more
than one network device.
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
