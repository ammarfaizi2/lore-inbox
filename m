Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160051-215>; Wed, 17 Mar 1999 04:12:59 -0500
Received: by vger.rutgers.edu id <157389-212>; Wed, 17 Mar 1999 04:12:31 -0500
Received: from lancaster.nexor.co.uk ([193.63.53.1]:45584 "EHLO lancaster.nexor.co.uk" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <160244-212>; Wed, 17 Mar 1999 04:02:27 -0500
To: David Hinds <dhinds@zen.stanford.edu>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: Ideas for abstracting driver IO from bus implementation? 
In-Reply-To: Your message of "Tue, 16 Mar 1999 19:41:44 PST."             <19990316194144.45898@zen.stanford.edu> 
Date: Wed, 17 Mar 1999 09:02:45 GMT
From: David Howells <David.Howells@nexor.co.uk>
Message-Id: <19990317091219Z160244-212+8328@vger.rutgers.edu>
Sender: owner-linux-kernel@vger.rutgers.edu

> For example, there are SCSI-to-PCMCIA adapters, parallel-to-PCMCIA adapters,
> SBUS-to-PCMCIA adapters, and various specialized bridge chips that sit on
> the system bus but do not allow PCMCIA devices to be arbitrarily configured
> to mimic the corresponding type of directly connected system device.

Handling this is my ultimate aim with my configuration manager. As well as the
standard four types of resource token (irq, dma, io & mem), I'd like to be
able to have drivers put up other types (such as a SCSI device token or a
parallel device token, though some generic type of indirection token may be
better).

This would, say, allow the following drivers:
	* a "SCSI interface" driver
	* a "SCSI over PCMCIA interface" driver
	* a "pretend all IDE CD-writers are SCSI CD-writers" driver

to create device record and attach to it a SCSI device access token which
would say:
	* how to find the driver which acts as an intermediary to the device
	* the interface access parameters (such as SCSI LUN)
	* further information about the device

[For example]
  Take the case of a someone writing a SCSI-CDROM driver. What they'd do is
  create a driver structure and register it with the system. This would
  specify a set of SCSI device types or classes that it can handle. The system
  would then attach any suitable SCSI CD-ROM devices to that driver. The
  driver would then be able to pull the SCSI device token out of the device
  structure. This would say what low-level driver to go to actually communicate
  with the device.

Also I'm currently adding a bus layer to the config manager. This will allow
such a low-level driver to implement a virtual bus representing a SCSI device
chain, whether it be directly over a SCSI interface, or whether it's done
through a PCMCIA interface.

I'm also setting up a new web-site (since my old one vanished). It is  at
http://www.astarte.free-online.co.uk, but is incomplete as yet.

David Howells

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
