Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbSACK75>; Thu, 3 Jan 2002 05:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285367AbSACK7h>; Thu, 3 Jan 2002 05:59:37 -0500
Received: from 10fwd.cistron-office.nl ([195.64.65.197]:36363 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id <S285352AbSACK7Q>; Thu, 3 Jan 2002 05:59:16 -0500
Date: Thu, 3 Jan 2002 11:59:13 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sync and reboot (was: Re: system.map)
Message-ID: <20020103115913.A23530@cistron.nl>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <200201022039.g02KdPSr022018@svr3.applink.net> <a1194d$5r6$3@ncc1701.cistron.net> <02010312301401.01898@manta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <02010312301401.01898@manta>; from vda@port.imtp.ilyichevsk.odessa.ua on Thu, Jan 03, 2002 at 12:30:14PM -0200
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to vda:
> However, then my shutdown script waits 5 secs before hard rebooting the box: 
> there is no way to be sure that IDE drives flushed their cache, except for 
> large pause.

There is, and sysvinit-2.83 implements it ;)

> (There may be some IDE command to do it, but who said each and every drive 
> will implement it? (and will do it correctly, i.e. would not lie to us that 
> cache is written back) :-)

There's supposed to be an IDE command but it depends on task files and
what not according to Andre Hedrick.

However there is another way. Putting the drive in standby mode also
flushes the write cache, and reboot/halt from sysvinit 2.83 and up
look for all IDE drives and put them in standby mode just before calling
the kernel's hard reboot/halt.

Ofcourse the kernel should do that itself, the IDE driver should
register a reboot handler that does this - but it doesn't, so I
put it in sysvinit for now.

Mike.
