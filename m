Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262064AbTCHQJF>; Sat, 8 Mar 2003 11:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbTCHQJF>; Sat, 8 Mar 2003 11:09:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17681 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262064AbTCHQJE>; Sat, 8 Mar 2003 11:09:04 -0500
Date: Sat, 8 Mar 2003 16:19:36 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
       Chris Dukes <pakrat@www.uk.linux.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: Make ipconfig.c work as a loadable module.
Message-ID: <20030308161936.C1896@flint.arm.linux.org.uk>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
	Chris Dukes <pakrat@www.uk.linux.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>, Robin Holt <holt@sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev@oss.sgi.com
References: <Pine.LNX.4.44.0303081132030.12316-100000@kenzo.iwr.uni-heidelberg.de> <m14r6dlu4w.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m14r6dlu4w.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Mar 08, 2003 at 09:07:11AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 09:07:11AM -0700, Eric W. Biederman wrote:
> With a good bootloader it does not much how big your initrd is.  I
> totally agree that small is good and important.  At the same time
> ipconfig.c is wrong.  It is great during development and on systems
> with a single NIC.  But the hard coded policies can be bad for
> production systems.  Not that hard coded policies are bad in general
> just the kernel is the wrong place to put them.

With multi-NIC systems, it is perfectly possible to use ipconfig.c with
one specific interface.

/*
 *  Decode any IP configuration options in the "ip=" or "nfsaddrs=" kernel
 *  command line parameter. It consists of option fields separated by colons in
 *  the following order:
 *
 *  <client-ip>:<server-ip>:<gw-ip>:<netmask>:<host name>:<device>:<PROTO>
 *
 *  Any of the fields can be empty which means to use a default value:
 *      <client-ip>     - address given by BOOTP or RARP
 *      <server-ip>     - address of host returning BOOTP or RARP packet
 *      <gw-ip>         - none, or the address returned by BOOTP
 *      <netmask>       - automatically determined from <client-ip>, or the
 *                        one returned by BOOTP
 *      <host name>     - <client-ip> in ASCII notation, or the name returned
 *                        by BOOTP
 *      <device>        - use all available devices
 *      <PROTO>:
 *         off|none         - don't do autoconfig at all (DEFAULT)
 *         on|any           - use any configured protocol
 *         dhcp|bootp|rarp  - use only the specified protocol
 *         both             - use both BOOTP and RARP (not DHCP)
 */

ip=:::::eth0:dhcp

(I haven't actually tried this though.)

However, how do you configure your ramdisk via the boot loader to use
a specific NIC / mount a specific filesystem, etc?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

