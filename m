Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268803AbUIXPQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268803AbUIXPQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 11:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUIXPNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 11:13:46 -0400
Received: from spirit.analogic.com ([208.224.221.4]:32519 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S268803AbUIXPHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 11:07:00 -0400
From: "Johnson, Richard" <rjohnson@analogic.com>
Reply-To: "Johnson, Richard" <rjohnson@analogic.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 24 Sep 2004 11:10:23 -0400 (EDT)
Subject: Migration to linux-2.6.8 from linux-2.4.26
Message-ID: <Pine.LNX.4.53.0409241038250.24372@quark.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(1) I compiled the new module-init-tools-3.1-pre5.tar.gz. It
claimed to be backward-compatible. After installing it, it
complained about something then seg-faulted. Nevertheless
`insmod` seemed to work so I proceeded.

(2) `make oldconfig` didn't work after copying over the
linux-2.4.26 .config file. This meant that I had to answer
hundreds of questions.

(3) `make bzImage` required that I install a new 'C' compiler.
This took several hours.

(4) Eventually "bzImage" got made. I tried `make modules`.
This took over 2 hours, went through everything several times.
This is a 2.8 GHz system. It usually takes about 6 minutes
to compile the kernel and all the modules. There is something
very wrong with the new compile method when it takes 120
times longer to compile than previously.

(5) `make modules_install` and `make install` seemed to work.

(6)  The system would boot, but not find a file-system to mount.

(7)  Tried to reboot using previous kernel. It failed to
load the required drivers for my SCSI disks so I have no
root file-system there.

(8)  I am currently unable to use my main system. I will have
mount my main SCSI drive on this system, and replace the
module-init-tools with the previous modutils. This should
allow me to get "back" to my previous mounted root.

So much for "backwards compatibility".

The system that I use for development is not some "standard
distribution". Everything that runs on that system was built
on that system. That way, any embedded software developed
on that system is not likely to contain Trojan horses.

The latest module-init tools apparently assumes something
about the system, that it's some version of Red-Hat, perhaps?

Or some kernel functionality, necessary for a static version
of insmod to work, was removed!

In any event, it will not allow modules to be loaded from initrd.
The Red-Hat 'nash' that contains its own loader is not used.
Instead, the original ash.static plus a static version of
insmod is used.

As one of the `anonymous` developers who wrote the first module
code before taken over by Bas Laarhoven and Bjorn, I'm somewhat
pissed.

Richard B. Johnson
Project Engineer
Analogic Corporation
Penguin : Linux version 2.2.15 on an i586 machine (330.14 BogoMips).
