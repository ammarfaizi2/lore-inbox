Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbTJ3PT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 10:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTJ3PT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 10:19:26 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:30089 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262580AbTJ3PTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 10:19:22 -0500
Date: Thu, 30 Oct 2003 15:18:31 +0000
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Post-halloween doc updates.
Message-ID: <20031030151831.GA11311@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <20031030141519.GA10700@redhat.com> <3FA128C4.5040502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA128C4.5040502@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 30, 2003 at 10:05:40AM -0500, Jeff Garzik wrote:

 > >  (usually notable by a NIC not getting a DHCP lease for eg, despite being
 > >   sent one by the server). Booting with "noapic" "acpi=off" or a 
 > >   combination
 > >  of both fixes this for most people. Additional breakage reports should go
 > >  to Jeff Garzik <jgarzik@pobox.com>
 > As this is a symptom of irq routing failure, I dunno if bug reports 
 > should necessarily go to me :)

Sorry, you just looked guilty 8-)
Removed that last bit.

 > >Stuff needing forward porting from 2.4.
 > >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 > >- HFSPlus
 > I think Roman Zippel updated this recently?


 > >- Direct booting from floppy is no longer supported.
 > >  You should now use a boot loader program instead.
 > hmmm, what does this mean?

it means you now need syslinux.

 > "make bzdisk" continues to work...  it requires syslinux, however, so 
 > that the makefile may install the syslinux bootloader on the floppy.

Added a note mentioning that.

 > >- For Red Hat users, there's another pitfall in "/etc/rc.sysinit".
 > > .... deletia 
 > Is this all still true?

Possibly not, I'll look into this.
 
 > >  o  Most PCMCIA devices have unload races and may oops on eject
 > >  o  Modular IDE does not yet work, modular IDE PCI modules sometimes
 > >     oops on loading
 > >  o  ide_scsi is completely broken in 2.6 currently. Known problem.
 > >     If you need it either use 2.4 or fix it 8)
 > also perhaps add a mention of new and spiffy Serial ATA drivers :)

See the very last line of of the doc 8-)

 > >- Jens Axboe added the ability to use DMA for writing CDs on
 > >  ATAPI devices. Writing CDs should be much faster than it
 > >  was in 2.4, and also less prone to buffer underruns and the like.
 > >- With a recent cdrecord, you also no longer need ide-scsi in order to use
 > >  an IDE CD writer.
 > Maybe add a pointer in the IDE section, pointing to this section?  Since 
 > they both mention ide-scsi...

Done.

 > >devfs.
 > >~~~~~~
 > >- devfs got somewhat stripped down and a lot of duplicate functionality
 > >  got removed. You now need to enable CONFIG_DEVPTS_FS=y and mount
 > >  the devpts filesystem in the same manner you would if you were not
 > >  using devfs.
 > Wasn't this mentioned elsewhere in the document?

briefly in the 'obsolete' section. the filesystem changes section
typically has more info.
 
 > >Improved BIOS table support.
 > >~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 > >- Linux now supports various new BIOS extensions.
 > 
 > This is a bit vague.  Even I have no idea what this refers to :)

Then read on...
SBF, EDD & IPMI

 > I dunno how much there is to add, but I just have a general feeling that 
 > software suspend and ACPI sleep state support has progressed since this 
 > was written.

last I tried both were quite dismal, that was a few months back though.


 > >Compiler issues.
 > >~~~~~~~~~~~~~~~~
 > >- The recommended compiler (for x86) is still 2.95.3.
 > 
 > I'm not sure this is still the case, in practice.  Recent times have 
 > seen people breaking 2.95.x, which did not support the C99/C++ style of 
 > mixing variable declarations and code.  People would forget this, and we 
 > only find out a few days later that the 2.95.x build was broken.

*nod*, more and more distros are now shipping gcc3 as their stock compiler,
so it's likely at some point things are going to change.

 > >  'process xxx using obsolete setsockopt SO_BSDCOMPAT' .
 > >  - Bind 9.2.2 checks for #ifdef SO_BSDCOMPAT in <asm/socket.h> correctly,
 > >    so a recompile is all that is needed.
 > >  - bind9-host from debian testing triggers, though the 'host' package 
 > >  doesn't.
 > >  - process `snmpd' is using obsolete setsockopt SO_BSDCOMPAT
 > >  - process `snmptrapd' is using obsolete setsockopt SO_BSDCOMPAT
 > >  - ntop uses obsolete (PF_INET,SOCK_PACKET)
 > 
 > Wasn't there a recent lkml thread relating to this?

not that I recall.

Thanks for the comments.

		Dave
