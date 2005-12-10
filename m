Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbVLJFMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbVLJFMd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 00:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbVLJFMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 00:12:33 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:16313 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964920AbVLJFMc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 00:12:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oU5xZzu1Bu085awFJShpHig8SpvgHBS0qwj0bHyV44X2Rj+jguHw9Xqdmbv6SEA/bIwbTosDoxGLZTZNA21rRRjJUkpRpQ6qClGROxuWZqXkzU+Me81jncjc5EtPL10SAAp8WTKWerSkH+o27bNXHKnYgLRreuIm11oIrs16fGE=
Message-ID: <78a518370512092112h7d2ff105od0dcd6d6880a7b02@mail.gmail.com>
Date: Sat, 10 Dec 2005 13:12:31 +0800
From: zja zja <zhangjianao@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: always return NULL in ata_probe function
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the ata_probe function is:
static struct kobject *ata_probe(dev_t dev, int *part, void *data)
{
        ide_hwif_t *hwif = data;
        int unit = *part >> PARTN_BITS;
        ide_drive_t *drive = &hwif->drives[unit];
        if (!drive->present)
                return NULL;

        if (drive->media == ide_disk)
                request_module("ide-disk");
        if (drive->scsi)
                request_module("ide-scsi");
        if (drive->media == ide_cdrom || drive->media == ide_optical)
                request_module("ide-cd");
        if (drive->media == ide_tape)
                request_module("ide-tape");
        if (drive->media == ide_floppy)
                request_module("ide-floppy");

        return NULL;
}

It will always return NULL, so it can't mount root device on boot time
in vmware, I don't know if it will work fine on other IDE disk. Is it
a problem?
