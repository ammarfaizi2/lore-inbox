Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130179AbRCCAej>; Fri, 2 Mar 2001 19:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130180AbRCCAeS>; Fri, 2 Mar 2001 19:34:18 -0500
Received: from FACULTY-41.ubishops.ca ([207.162.104.41]:56582 "HELO
	thanatos.ubishops.ca") by vger.kernel.org with SMTP
	id <S130179AbRCCAeO>; Fri, 2 Mar 2001 19:34:14 -0500
Message-ID: <3AA03BE7.9057EDFC@mail.com>
Date: Fri, 02 Mar 2001 19:33:43 -0500
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
Reply-To: jdthoodREMOVETHIS@yahoo.co.uk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Should isa-pnp utilize the PnP BIOS?
In-Reply-To: <20010214092251.D1144@e-trend.de> <3A8AA725.7446DEA0@ubishops.ca> <20010214165758.L28359@e-trend.de> <20010214122244.H7859@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, a couple of people have responded positively to this 
suggestion.  The next question is, how should it be implemented?

How 'bout:

$ cd pcmcia-cs/modules
$ cp pnp_bios.c pnp_proc.c pnp_rsrc.c /usr/src/linux/2.4.2a/drivers/pnp
$ cd ../include/linux
$ cp pnp_bios.h pnp_resource.h /usr/src/linux/2.4.2a/include/linux
Edit makefiles
Edit isapnp.c to include new global flag "isapnp_usepnpbios",
  a MODULE_PARM, which each isapnp function checks at entry.
  If the flag is set then: in the case of "low-level" functions,
  return immediately; in the case of "high-level" functions, call
  appropriate pnp_bios functions to perform the task; in the case
  of isapnp_init(), just check isapnp_disabled and exit.  isapnp's
  /proc interface would not be supported.  Presumably
  inter_module_get_request() would be used to call the isapnp-bios
  routines.

Comments?  (Go easy on me; I'm a newbie at kernel hacking.)

Thomas

> Hello, l-k.
> 
> On my ThinkPad 600, The ThinkPad PnP BIOS configures
> all PnP devices at boot time.
> 
> If I load the isa-pnp.o driver it never detects any ISA PnP
> devices: it says "isapnp: No Plug & Play device found".  This
> is unfortunate, because it means that device drivers can't
> find out from isa-pnp where the devices are.
> 
> David Hinds's pcmcia-cs package contains driver code that
> interfaces with the PnP BIOS.  With it, one can list the resource
> usage of ISA PnP devices (serial and parallel ports, sound chip,
> etc.) and set them, using the "lspnp" and "setpnp" commands.
> 
> Would it not be useful if the isa-pnp driver would fall back
> to utilizing the PnP BIOS (if possible) in order to read and
> change ISA PnP device configurations when it can't do this
> itself?  If so, could this perhaps be done by bringing the Hinds
> PnP BIOS driver into the kernel and interfacing isa-pnp to it?
> 
> Thomas Hood
> jdthood_AT_yahoo.co.uk   <- Change '_AT_' to '@'
