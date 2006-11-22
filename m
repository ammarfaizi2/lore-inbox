Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753660AbWKVOop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbWKVOop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 09:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882AbWKVOop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 09:44:45 -0500
Received: from mgw-ext14.nokia.com ([131.228.20.173]:19837 "EHLO
	mgw-ext14.nokia.com") by vger.kernel.org with ESMTP
	id S1753660AbWKVOoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 09:44:44 -0500
Message-ID: <456462BB.6010103@indt.org.br>
Date: Wed, 22 Nov 2006 10:46:19 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Pierre Ossman <drzeus-list@drzeus.cx>, Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       ext David Brownell <david-b@pacbell.net>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: [patch 0/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2006 14:42:28.0328 (UTC) FILETIME=[6ED3AE80:01C70E44]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

New in this version:

- Comments from Russel, Pierre and Anderson Lizardo reviewed and applied.
- MMC_CAP_LOCK_UNLOCK capability removed.
- For more information track the discussion at linux-omap mailing list.

This series of patches add support for MultiMediaCard (MMC) password
protection, as described in the MMC Specification v4.1. This feature is
supported by all compliant MMC cards, and used by some devices such as
Symbian OS cell phones to optionally protect MMC cards with a password.

By default, a MMC card with no password assigned is always in "unlocked"
state. After password assignment, in the next power cycle the card
switches to a "locked" state where only the "basic" and "lock card"
command classes are accepted by the card. Only after unlocking it with
the correct password the card can be normally used for operations like
block I/O.

Password management and caching is done through the "Kernel Key
Retention Service" mechanism and the sysfs filesystem. A new sysfs
attribute was added to the MMC driver for unlocking the card, assigning
a password to an unlocked card, change a card's password, remove the
password and check locked/unlocked status.

A sample text-mode reference UI written in shell script (using the
keyctl command from the keyutils package), can be found at:

http://www.indt.org.br/10le/mmc_pwd/mmc_reference_ui-20060130.tar.bz2


TODO:

- Ongoing: Extend the MMC PWD Scheme to SD Cards.

- Password caching: when inserting a locked card, the driver should try
   to unlock it with the currently stored password (if any), and if it
   fails, revoke the key containing it and fallback to the normal "no
   password present" situation.

Known Issue:

- Some cards have an incorrect behaviour (hardware bug?) regarding
   password acceptance: if an affected card has password <pwd>, it
   accepts <pwd><xxx> as the correct password too, where <xxx> is any
   sequence of characters, of any length. In other words, on these cards
   only the first <password length> bytes need to match the correct
   password.


Comments and suggestions are always welcome.

-- 
Anderson Briglia,
Carlos Aguiar

Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
--
