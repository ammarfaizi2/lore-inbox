Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbSL3CpQ>; Sun, 29 Dec 2002 21:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbSL3CpQ>; Sun, 29 Dec 2002 21:45:16 -0500
Received: from mnh-1-01.mv.com ([207.22.10.33]:6149 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265960AbSL3CpP>;
	Sun, 29 Dec 2002 21:45:15 -0500
Message-Id: <200212300245.VAA04199@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Werner Almesberger <wa@almesberger.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Anomalous Force <anomalous_force@yahoo.com>, ebiederm@xmission.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: holy grail 
In-Reply-To: Your message of "Sun, 29 Dec 2002 22:32:47 -0300."
             <20021229223247.C1363@almesberger.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 29 Dec 2002 21:45:52 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wa@almesberger.net said:
> I see a certain trend towards mechanisms that can be useful for
> process migration. E.g. the address space manipulations discussed for
> UML seem to allow almost perfect reconstruction of processes. PIDs,
> signals, anything with externally visible changes in kernel state

With a UML running in skas mode, the process address space is identical to
what it would be on the host.  Migrating one to the host would be a matter
of
	Sticking a process in it
	Releasing that process from ptrace
	Recreating the required kernel state in the host kernel
	Kicking the process out of the UML kernel and into userspace somehow
	Letting it run

Step 3 is obviously where the meat of the problem is.  The process needs
to have available on it all the resources it had in UML -
	the same files
	network connections (puntable on a first pass)
	process relationships (I have no idea what to do about a parent
process on the host, nor what to do with children whose parent has been
migrated, or ipc mechanisms, except to do the Mosix thing and have little
proxies sitting around passing information between UML and the host).

And since I've brought up Mosix, as did Werner, the fastest way to get
this working is probably to finish off the OpenMosix/UML port (which was
close from what I heard), and cluster a UML and its host.  You should get
process migration for free.

Just remember to prevent the host from trying to migrate a UML to itself.
That would be very bad.

				Jeff

