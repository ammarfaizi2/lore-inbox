Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933901AbWKTEY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933901AbWKTEY5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 23:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756858AbWKTEY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 23:24:57 -0500
Received: from isilmar.linta.de ([213.239.214.66]:53170 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1756854AbWKTEY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 23:24:56 -0500
Date: Sun, 19 Nov 2006 23:24:23 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: [git pull] PCMCIA fixes for 2.6.19-rc6
Message-ID: <20061120042423.GE26687@dominikbrodowski.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
References: <20061119163427.GA2924@dominikbrodowski.de> <20061119123636.6219351d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061119123636.6219351d.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 19, 2006 at 12:36:36PM -0800, Andrew Morton wrote:
> On Sun, 19 Nov 2006 11:34:27 -0500
> Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> 
> > Hej Linus,
> > 
> > Please pull from
> > 
> > 	
> > 
> > ...
> >
> >       pcmcia: fix 'rmmod pcmcia' with leftover devices
> 
> Is this the patch about which Daniel said "does not fix the problem:
> ds.c:ds_event() will never be called because s->callback is set to NULL
> just before send_event() which means send_event() does nothing at all.."?

Yes, this tree included this broken patch. I have re-created a new tree, now
including Daniel's proper patch instead of my broken one, and one other
bugfix to one of my patches (spotted by Randy Dunlap) which can be pulled
from

git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-fixes-new-2.6.git/

The diffstat and list of changes follows.

Thanks,
	Dominik

----
 drivers/ata/pata_pcmcia.c       |    2 
 drivers/char/pcmcia/cm4000_cs.c |    6 -
 drivers/char/pcmcia/cm4040_cs.c |    6 -
 drivers/ide/legacy/ide-cs.c     |    2 
 drivers/pcmcia/cs_internal.h    |    2 
 drivers/pcmcia/ds.c             |  170 +++++++++++++++++++++++-----------------
 drivers/pcmcia/pcmcia_ioctl.c   |    7 +
 drivers/pcmcia/pd6729.c         |    8 -
 drivers/pcmcia/socket_sysfs.c   |    4 
 include/pcmcia/ss.h             |    5 -
 10 files changed, 126 insertions(+), 86 deletions(-)
----
Akinobu Mita (1):
      cm4000_cs: fix return value check

Daniel Ritz (1):
      pcmcia: fix 'rmmod pcmcia' with unbound devices

Dominik Brodowski (3):
      pcmcia: start over after CIS override
      pcmcia: multifunction card handling fixes
      pcmcia: handle __copy_from_user() return value in ioctl

Komuro (1):
      pcmcia: allow shared IRQs on pd6729 sockets

Marcin Juszkiewicz (1):
      pcmcia: yet another IDE ID

Matt Reimer (1):
      pcmcia: Add an id to ide-cs.c

