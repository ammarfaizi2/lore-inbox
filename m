Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVCTQsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVCTQsS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 11:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVCTQsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 11:48:17 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:64943 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261236AbVCTQsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 11:48:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=adxhV3pdBQ5Dgfp47w2UoHm/dqNRERksurSbOBfBzbF2uce+zd8iCZSnQJ+wW384ZBGGwh3TawxBYabUc8YKUemN4nO0NWU4GWFrSZ/nc51pWKBuoweVqeDUf6vomCDh4NXrbU1iWbOvXjrNTSJpaWookIrwcr0UJCJbwenV6CI=
Message-ID: <aec7e5c305032008487f378246@mail.gmail.com>
Date: Sun, 20 Mar 2005 17:48:13 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ide-xxx.c and KBUILD_MODNAME
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

The KBUILD_MODNAME problem with af_unix.c is sort of also affecting
the ide code, but with another twist. "unix" is not a problem, but
KBUILD_MODNAME collides with constants defined in <linux/ide.h>:

[snip]
/*
 * Now for the data we need to maintain per-drive:  ide_drive_t
 */

#define ide_scsi	0x21
#define ide_disk	0x20
#define ide_optical	0x7
#define ide_cdrom	0x5
#define ide_tape	0x1
#define ide_floppy	0x0
[snip]

this results in wierd KBUILD_MODNAME preprocessing:
- KBUILD_MODNAME in ide-disk.c equals "0x20"
- KBUILD_MODNAME in ide-tape.c equals "0x1"
- KBUILD_MODNAME in ide-floppy.c equals "0x0"

Why again are we using lowercase constants?

/ magnus
