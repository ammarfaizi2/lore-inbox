Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312457AbSFEGSO>; Wed, 5 Jun 2002 02:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSFEGSN>; Wed, 5 Jun 2002 02:18:13 -0400
Received: from david.siemens.de ([192.35.17.14]:38625 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S312457AbSFEGSM>;
	Wed, 5 Jun 2002 02:18:12 -0400
Message-ID: <6134254DE87BD411908B00A0C99B044F0387211B@mowd019a.mow.siemens.ru>
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: How safe is to add a member to struct super_block?
Date: Wed, 5 Jun 2002 10:24:58 +0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem in media revalidation in current supermount - if
something tries to access device after media change before supermount (a
reported case was - close tray manually and do eject -t) a "media change"
flag is lost so supermount never remounts underlying fs.

The simplest way to fix it is to unmount filesystem in check_media_change
(actually in destroy_device where we get superblock). But this needs both a
"this fs is supermounted" flag and pointer to top-level fs so supermount can
properly clean up. So I intend to add a member to struct super_block that
points to super block of top-level (supermount) fs.

Are there any alignment/size constraints on struct super_block to be aware
of?

TIA

-andrej
