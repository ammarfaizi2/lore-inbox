Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272803AbTG3Hoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 03:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272804AbTG3Hog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 03:44:36 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:44181 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id S272803AbTG3Hoe (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.Org>);
	Wed, 30 Jul 2003 03:44:34 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Adrian Bunk" <bunk@fs.tum.de>
Cc: "Linux Kernel" <Linux-Kernel@Vger.Kernel.Org>
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Date: Wed, 30 Jul 2003 08:44:25 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAOEMMFBAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030729195932.GR28767@fs.tum.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian.

 > - I do prefer BROKEN, Alan prefers OBSOLETE
 >   a s/BROKEN/OBSOLETE/g is acceptable for me

To me at least, BROKEN and OBSOLETE have different meanings,
and choice of which to use should depend on the circumstances.
Here's my choice of definitions for the cases that I can see:

 * Driver has been replaced by a newer driver, and the old
   driver is currently retained for cases that don't yet
   work with the replacement. Driver will be removed in a
   future kernel once the replacement handles all reported
   cases.

		CONFIG_OBSOLETE

 * Driver is for hardware that is not supported in modern
   computers, and is retained for use with older computers
   only. Driver will not be removed, but is not expected to
   be compiled by most users.

		CONFIG_ANTIQUE

 * Driver does not work, and is thus disabled. If it is not
   fixed in the near future, it will be considered to be
   OBSOLETE as well.

		CONFIG_BROKEN

 * Driver works on uniprocessor but not on SMP and is thus
   disabled when compiling for SMP. It is assumed that the
   driver will be fixed for SMP if relevant.

		CONFIG_BROKEN_ON_SMP

 * Driver was BROKEN some considerable number of releases
   ago, and has never been fixed. It is thus assumed that
   the driver is for some device that none of the kernel
   developers is using. The driver will be removed in the
   transition to the next major release if it retains this
   status.

		CONFIG_BROKEN && CONFIG_OBSOLETE

Personally, I'd like to see CONFIG_ANTIQUE (defaulting to "n")
as a dependency for all drivers matching the description above
simply to cut down on the amount of irrelevant choices in the
configuration process.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.504 / Virus Database: 302 - Release Date: 24-Jul-2003

