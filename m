Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272044AbTGYMc4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 08:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272045AbTGYMcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 08:32:55 -0400
Received: from tomts23-srv.bellnexxia.net ([209.226.175.185]:39344 "EHLO
	tomts23-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S272044AbTGYMcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 08:32:50 -0400
Date: Fri, 25 Jul 2003 08:46:29 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Bernd Eckenfels <ecki-lkm@lina.inka.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: why the current kernel config menu layout is a mess
In-Reply-To: <E19frN3-00025I-00@calista.inka.de>
Message-ID: <Pine.LNX.4.53.0307250820320.25867@localhost.localdomain>
References: <E19frN3-00025I-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003, Bernd Eckenfels wrote:

> In article <Pine.LNX.4.53.0307242020140.23200@localhost.localdomain> you wrote:

> > "Multiple devices (RAID and LVM)"
> 
> Well, if we go along the line of using unix naming, then MD can be moved ot
> block devices, not to filesystems.

i'm still not keen on the notion of having an entire menu category
called "block devices".  apart from the hard-core kernel coders here,
i don't think mere mortals think this way.  but there's another concern
with any menu re-org.

from my poking around in the whole Kconfig structure, it seems that the
menu structure is tied awfully closely to the underlying directory
structure.  this would make it overly difficult to shift parts of
the config menu around without dragging the corresponding directories
around as well.

so, as much as i'd like to see a more intuitive menu layout, i'm
starting to think that this may not be all that easy anymore.
it's one thing to shift menu entries around.  it's quite another
to start moving entire directories around in the kernel source
tree, and it seems that that's what would be necessary.  unless
i'm misreading something badly.

rday

p.s.  since i'm sure there's at least a couple people here i haven't
annoyed intensely thus far :-), let me toss out two more thoughts.

checkboxes at the top level
---------------------------

  some time ago, i suggested it would be nice to be able to deselect
entire submenus right at the top level.  for example, it's clearly
inefficient to have to select "Parallel port support" and bring
up its corresponding submenu, if your only goal is to *deselect*
that option.

  it would be really terrific to have checkboxes for deselecting
entire subsystems right at the top level, but i suspect that would
require a major rewrite of Kconfig, wouldn't it?  bummer.

who defines a menu?
-------------------

  the other problem i noticed is the restrictions imposed when a
Kconfig file defines its own menu title.  just as one example, 
consider ../drivers/acpi/Kconfig.  that Kconfig file defines itself
at the very top as the menu for "ACPI Support".  but who's to say
that someone else might not write another set of drivers in another
directory that relate to some other feature of ACPI?

  that will be inconvenient since the Kconfig file i refer to has
already taken the inflexible position of claiming, "*i*, and only i,
shall handle ACPI, and i shall be the ACPI support menu."

  frankly, i don't think Kconfig files should define their own
menu names.  that should be done by their *including* files,
which gives the including files the flexibility to decide how to
name and include menus.

  if this were done consistently, re-ordering the menu layout
would be a breeze.  in short, if i use ACPI as an example, whoever
wrote the ACPI stuff would be responsible for writing the Kconfig
file to describe options and dependencies, but would leave the
menu name and how those menu entries were included in the overall
structure to a higher-level Kconfig file, all the way back to
the top-level Kconfig file, whose job would be to simply define
the top-level menu and include the appropriate next-level
Kconfig files.

  although, i will admit, there may be limitations to this
i haven't thought of yet.
