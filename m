Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272128AbTGYOdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 10:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272132AbTGYOdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 10:33:05 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:59777 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272128AbTGYOc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 10:32:59 -0400
Date: Fri, 25 Jul 2003 15:58:10 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307251458.h6PEwAMD001065@81-2-122-30.bradfords.org.uk>
To: ecki-lkm@lina.inka.de, Fabian.Frederick@prov-liege.be,
       rpjday@mindspring.com
Subject: RE: why the current kernel config menu layout is a mess
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> from my poking around in the whole Kconfig structure, it seems that the
> menu structure is tied awfully closely to the underlying directory
> structure.  this would make it overly difficult to shift parts of
> the config menu around without dragging the corresponding directories
> around as well.
> <Sources are located regarding programming hierarchy _but_
> <relevant Kconfig can tune situation using 'depends' feature
> <at ease so that menuconfig, kernelserver ... have an optimized view
> <over kernel tree.OTOH a major problem resides in lack of functionnalities
> <especially when you don't know where to look at (ie.alphabetical order,
> <search engine....I'm adding those functions to kernelServer (wconf) ASAP.

KernelServer is cool, but it would be even nicer if it had a gopher
interface, because then you could make interfaces to very simple
devices indeed that can't handle HMTL, such as wristwatches, so that
you could, in theory, administer your boxes from anywhere in the
world.

Anyway, going back to the re-design of the kernel configurator, maybe
we have simply reached the practical limit of the simple menu based
system?

There are now so many options that you either have a lot of options
under vague headings, (which I prefer because I think that once you're
used to it, it's quicker and simpler), or, (in my opinion), excessive
levels of abstraction, and options deep within submenus, like:

Buses -> Internal -> Legacy -> ISA

There are also complications with taking configurations from old
kernel versions, and using them with later kernels - a 2.4 config
typically won't work simply by using make oldconfig on a 2.6 tree.

Maybe a completely new, out of kernel tree configurator would be worth
thinking about, leaving the in-kernel configurator as a legacy option.
I know the config system underwent a major overhaul during 2.5, but I
think we could go even further.

Ultimately, any configurator generates a plain text .config file with
various options set.  There is no reason why we couldn't have a
modular system:


----------------------    ----------------
| Kernel .config     |    | Out of tree  |    ----------------
| options description|--->| configurator |--->| .config file |
| file               |    |              |    ----------------
----------------------    ----------------
                          / /   |  |   \ \
                         / /    |  |    \ \
                        ^ v     ^  v     ^ v
                       / /      |  |      \ \
                      / /       |  |       \ \
        ----------------  ----------------  ----------------
        |   MODULE 1   |  |   MODULE 2   |  |   MODULE 3   | 
        ----------------  ----------------  ----------------

The out of tree configurator on it's own would simply display all the
options in the kernel .config options description file, with their
descriptions, and allow them to be set to specific values.  The
display could be colour coded for yes/no values.

The modules could allow things like:

* Creating a config file using an existing config file - similar to
make oldconfig

* Turning groups of options on and off - similar to the existing make
menuconfig, but more flexible - you could just load a 'bus options'
module, which would provide verbose prompting for bus options, allow
the turning on and off of groups of .config options, and hide advanced
options, but which would leave the raw .config options editable for
everything that wasn't to do with 'bus options'.

* Creating a minimal .config file from the output of boottime dmesg
output - similar to the adjustkernel perl script that works with
NetBSD:

http://www.feyrer.de/Misc/adjustkernel

Distributions could create their own modules to customise the
configurator however they wanted to.

John.
