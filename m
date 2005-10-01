Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVJALS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVJALS5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 07:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVJALS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 07:18:56 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:57094 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750794AbVJALS4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 07:18:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o7c+g57EtAWtA6s+UriGs+XaDBbv9NLijaVIMeljyKO2ffbZzfcK1aiTS+UeRkLNiTq3XywvL2QqaTfAl6kmXljroRY4/3TYdN0wjy9xcv8d62tR57gfZw1+aarLqFZhz1RHQMS9zeFvSzKaPhH6ZWtZR+LWI/w5ENT+8CphaHQ=
Message-ID: <3888a5cd0510010418w4d31481fy757950a0ff32d764@mail.gmail.com>
Date: Sat, 1 Oct 2005 13:18:55 +0200
From: Jiri Slaby <lnx4us@gmail.com>
Reply-To: Jiri Slaby <lnx4us@gmail.com>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] [IDE] kmalloc + memset -> kzalloc conversion
Cc: dsaxena@plexity.net, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <433E6E26.5030305@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051001074415.GL25424@plexity.net> <433E6E26.5030305@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/05, Jiri Slaby <jirislaby@gmail.com> wrote:
> Deepak Saxena napsal(a):
>
> >Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
> >
> >diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> >--- a/drivers/ide/ide-cd.c
> >+++ b/drivers/ide/ide-cd.c
> >@@ -3449,7 +3449,7 @@ static int ide_cd_probe(struct device *d
> >               printk(KERN_INFO "ide-cd: passing drive %s to ide-scsi emulation.\n", drive->name);
> >               goto failed;
> >       }
> >-      info = (struct cdrom_info *) kmalloc (sizeof (struct cdrom_info), GFP_KERNEL);
> >+      info = (struct cdrom_info *) kzalloc (sizeof (struct cdrom_info), GFP_KERNEL);
> >
> >
> no need to cast and 80 chars on a line is upper bound.
>
> >       if (info == NULL) {
> >               printk(KERN_ERR "%s: Can't allocate a cdrom structure\n", drive->name);
> >               goto failed;
> >@@ -3463,8 +3463,6 @@ static int ide_cd_probe(struct device *d
> >
> >       ide_register_subdriver(drive, &ide_cdrom_driver);
> >
> >-      memset(info, 0, sizeof (struct cdrom_info));
> >-
> >       kref_init(&info->kref);
> >
> >       info->drive = drive;
> >diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> >--- a/drivers/ide/ide-disk.c
> >+++ b/drivers/ide/ide-disk.c
> >@@ -1215,7 +1215,7 @@ static int ide_disk_probe(struct device
> >       if (drive->media != ide_disk)
> >               goto failed;
> >
> >-      idkp = kmalloc(sizeof(*idkp), GFP_KERNEL);
> >+      idkp = kzalloc(sizeof(*idkp), GFP_KERNEL);
> >       if (!idkp)
> >               goto failed;
> >
> >@@ -1228,8 +1228,6 @@ static int ide_disk_probe(struct device
> >
> >       ide_register_subdriver(drive, &idedisk_driver);
> >
> >-      memset(idkp, 0, sizeof(*idkp));
> >-
> >       kref_init(&idkp->kref);
> >
> >       idkp->drive = drive;
> >diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> >--- a/drivers/ide/ide-floppy.c
> >+++ b/drivers/ide/ide-floppy.c
> >@@ -2146,7 +2146,7 @@ static int ide_floppy_probe(struct devic
> >               printk("ide-floppy: passing drive %s to ide-scsi emulation.\n", drive->name);
> >               goto failed;
> >       }
> >-      if ((floppy = (idefloppy_floppy_t *) kmalloc (sizeof (idefloppy_floppy_t), GFP_KERNEL)) == NULL) {
> >+      if ((floppy = (idefloppy_floppy_t *) kzalloc (sizeof (idefloppy_floppy_t), GFP_KERNEL)) == NULL) {
> >
> >
> detto
>
> >               printk (KERN_ERR "ide-floppy: %s: Can't allocate a floppy structure\n", drive->name);
> >               goto failed;
> >       }
> >@@ -2159,8 +2159,6 @@ static int ide_floppy_probe(struct devic
> >
> >       ide_register_subdriver(drive, &idefloppy_driver);
> >
> >-      memset(floppy, 0, sizeof(*floppy));
> >-
> >       kref_init(&floppy->kref);
> >
> >       floppy->drive = drive;
> >diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> >--- a/drivers/ide/ide-probe.c
> >+++ b/drivers/ide/ide-probe.c
> >@@ -596,14 +596,13 @@ static inline u8 probe_for_drive (ide_dr
> >        *      Also note that 0 everywhere means "can't do X"
> >        */
> >
> >-      drive->id = kmalloc(SECTOR_WORDS *4, GFP_KERNEL);
> >+      drive->id = kzalloc(SECTOR_WORDS *4, GFP_KERNEL);
> >       drive->id_read = 0;
> >       if(drive->id == NULL)
> >       {
> >               printk(KERN_ERR "ide: out of memory for id data.\n");
> >               return 0;
> >       }
> >-      memset(drive->id, 0, SECTOR_WORDS * 4);
> >       strcpy(drive->id->model, "UNKNOWN");
> >
> >       /* skip probing? */
> >@@ -1097,14 +1096,13 @@ static int init_irq (ide_hwif_t *hwif)
> >               hwgroup->hwif->next = hwif;
> >               spin_unlock_irq(&ide_lock);
> >       } else {
> >-              hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
> >+              hwgroup = kzalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
> >                                       hwif_to_node(hwif->drives[0].hwif));
> >               if (!hwgroup)
> >                       goto out_up;
> >
> >               hwif->hwgroup = hwgroup;
> >
> >-              memset(hwgroup, 0, sizeof(ide_hwgroup_t));
> >               hwgroup->hwif     = hwif->next = hwif;
> >               hwgroup->rq       = NULL;
> >               hwgroup->handler  = NULL;
> >diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> >--- a/drivers/ide/ide-tape.c
> >+++ b/drivers/ide/ide-tape.c
> >@@ -4844,7 +4844,7 @@ static int ide_tape_probe(struct device
> >               printk(KERN_WARNING "ide-tape: Use drive %s with ide-scsi emulation and osst.\n", drive->name);
> >               printk(KERN_WARNING "ide-tape: OnStream support will be removed soon from ide-tape!\n");
> >       }
> >-      tape = (idetape_tape_t *) kmalloc (sizeof (idetape_tape_t), GFP_KERNEL);
> >+      tape = (idetape_tape_t *) kzalloc (sizeof (idetape_tape_t), GFP_KERNEL);
> >
> >
> ... and so on
>
> regards,
>
> --
> Jiri Slaby         www.fi.muni.cz/~xslaby
> ~\-/~      jirislaby@gmail.com      ~\-/~
> 241B347EC88228DE51EE A49C4A73A25004CB2A10

And one more time, the mail to some of recipients was rejected by their
server, sorry.
