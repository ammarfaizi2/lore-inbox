Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266802AbRGKV7f>; Wed, 11 Jul 2001 17:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbRGKV7Z>; Wed, 11 Jul 2001 17:59:25 -0400
Received: from [199.26.153.10] ([199.26.153.10]:14089 "HELO fourelle.com")
	by vger.kernel.org with SMTP id <S266802AbRGKV7V>;
	Wed, 11 Jul 2001 17:59:21 -0400
Message-ID: <3B4CCBB5.21FC36AE@fourelle.com>
Date: Wed, 11 Jul 2001 14:57:09 -0700
From: "Adam D. Scislowicz" <adams@fourelle.com>
Organization: Fourelle Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE0(Primary)/Slave Detection Problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While looking through ide-probe.c I came across the following code:
        /*
         * Prevent long system lockup probing later for non-existant
         * slave drive if the hwif is actually a flash memory card of
some variety:
         */
        if (drive_is_flashcard(drive)) {
                ide_drive_t *mate =
&HWIF(drive)->drives[1^drive->select.b.unit];
                if (!mate->ata_flash) {
                        mate->present = 0;
                        mate->noprobe = 1;
                }
        }

In my case I am using a flash card with a normal harddrive as the slave,
but
this code does not allow for that combination. Their must be a better
way to
handle this, or it should at least print, "Flash Disk Detected, Ignoring
Slave"...

 -Adam Scislowicz <adams@fourelle.com>

