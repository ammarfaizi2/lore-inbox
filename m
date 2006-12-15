Return-Path: <linux-kernel-owner+w=401wt.eu-S1753175AbWLOSwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbWLOSwM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 13:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753178AbWLOSwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 13:52:11 -0500
Received: from smtp.nokia.com ([131.228.20.172]:53085 "EHLO
	mgw-ext13.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbWLOSwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 13:52:10 -0500
Message-ID: <4582EF66.5010507@indt.org.br>
Date: Fri, 15 Dec 2006 14:54:30 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       Tony Lindgren <tony@atomide.com>,
       ext David Brownell <david-b@pacbell.net>
Subject: [PATCH 0/4] Add MMC Password Protection (lock/unlock) support V9
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2006 18:49:44.0400 (UTC) FILETIME=[C950DD00:01C72079]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

New in this version:

- mmc_sysfs.c: minor adjustment. Unused variable "zap" deleted from the patch.
- OMAP specific patch not include on this series.
- Version according the latest mainline git repository.

This series of patches add support for MultiMediaCard (MMC) password protection, as described in the MMC Specification
v4.1. This feature is supported by all compliant MMC cards, and used by some devices such as Symbian OS cell phones to
optionally protect MMC cards with a password.

By default, a MMC card with no password assigned is always in "unlocked" state. After password assignment, in the next
power cycle the card switches to a "locked" state where only the "basic" and "lock card" command classes are accepted by
the card. Only after unlocking it with the correct password the card can be normally used for operations like block I/O.

Password management and caching is done through the "Kernel Key Retention Service" mechanism and the sysfs filesystem. A
new sysfs attribute was added to the MMC driver for unlocking the card, assigning a password to an unlocked card, change
a card's password, remove the password and check locked/unlocked status.

A sample text-mode reference UI written in shell script (using the keyctl command from the keyutils package), can be
found at:

http://www.indt.org.br/10le/mmc_pwd/mmc_reference_ui-20060130.tar.bz2

TODO:

- Ongoing: Extend the MMC PWD Scheme to SD Cards.

- Password caching: when inserting a locked card, the driver should try to unlock it with the currently stored password
(if any), and if it fails, revoke the key containing it and fallback to the normal "no password present" situation.

Known Issue:

- Some cards have an incorrect behaviour (hardware bug?) regarding password acceptance: if an affected card has password
<pwd>, it accepts <pwd><xxx> as the correct password too, where <xxx> is any sequence of characters, of any length. In
other words, on these cards only the first <password length> bytes need to match the correct password.

Comments and suggestions are always welcome.

-- 
Anderson Briglia

Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
