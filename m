Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbTCCQOQ>; Mon, 3 Mar 2003 11:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbTCCQOQ>; Mon, 3 Mar 2003 11:14:16 -0500
Received: from [62.38.16.106] ([62.38.16.106]:25216 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id <S266615AbTCCQOP>;
	Mon, 3 Mar 2003 11:14:15 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: Pavel Machek <pavel@suse.cz>, bert hubert <ahu@ds9a.nl>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Roger Luethi <rl@hellgate.ch>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Date: Mon, 3 Mar 2003 18:23:16 +0200
User-Agent: KMail/1.5
References: <20030226211347.GA14903@elf.ucw.cz> <20030303123551.GA19859@outpost.ds9a.nl> <20030303124133.GH20929@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20030303124133.GH20929@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303031823.17050.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [ pruned mr Grover from the CC list ]
> >
> > On Mon, Mar 03, 2003 at 01:23:25PM +0100, Pavel Machek wrote:
> > > Well, it does not happen on my machines, but I've already seen it
> > > happen on computer with two harddrives.
> >
> > This is a laptop with only one. Anything I can do to help, let me know.
> > Alan has suggested that an IDE transaction was still in progress, perhaps
> > a small wait could prove/disprove this assumption?
>
> Start adding printks to see whats going on. Try going ext2. Try
> killing sys_sync() from kernel/suspend.c.
>
> 									Pavel

This looks like the problem I've been reporting since 2.5.5x . On my machine 
(HP XE3GC) I get a rare chance that this happens. 
One raw hack I have been using to get around that, is my 'sleep' script (for 
S1):
/etc/init.d/ypbind stop 	#i.e. prepare the system
sleep 9		#allow me to lock the screen etc.

sync			#This is where I reduce the chance I have dirty buffers
sleep 1		# calm down
echo 1 >/proc/acpi/sleep	#sleep now

That won't fix the bug, of course, but shows what may go wrong..


