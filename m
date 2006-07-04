Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWGDQw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWGDQw2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWGDQw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:52:28 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:24229 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932281AbWGDQw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:52:28 -0400
Date: Tue, 4 Jul 2006 18:52:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] s390 zcrypto driver rewrite / secure key crypto extension.
Message-ID: <20060704165229.GA6202@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
we have finally completed the rewrite of the z90crypt device driver.
The new driver is called zcrypt, just to make a fresh start. The patches
do not contain the removal of the old z90xxx files since this would be a
waste of bandwidth.
The main reason for the rewrite has been the secure key crypto extension.
We have found it next to impossible to add that extension to the old
driver. The new code implements a proper bus and has a device driver
for each card type. On top of the drivers is the user space interface.
The layering looks like this:

     User space         Card drivers            Bus
     interface

                   |--> zcrypt_pcica  <--|
                   |                     |
                   |--> zcrypt_cex2a  <--|
     zcrypt_api <--|                     |-->  ap_bus
                   |--> zcrypt_pcicc  <--|
                   |                     |
                   |--> zcrypt_pcixcc <--|

The defails of the messages for the different cards are peculiar, the
overall structure is straight forward.
I want to push this new driver upstream soon, provided that nobody finds
any major bugs.

--
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
