Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316629AbSHASsJ>; Thu, 1 Aug 2002 14:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSHASsJ>; Thu, 1 Aug 2002 14:48:09 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:13842 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316629AbSHASsI>;
	Thu, 1 Aug 2002 14:48:08 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208011851.g71IpWA377111@saturn.cs.uml.edu>
Subject: Re: [PATCH] 2.5.29 IDE 110
To: martin@dalecki.de
Date: Thu, 1 Aug 2002 14:51:32 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org (Kernel Mailing List),
       torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <3D488361.4070604@evision.ag> from "Marcin Dalecki" at Aug 01, 2002 02:40:01 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Dalecki writes:

> - Eliminate support for "sector remapping". loop devices can handle
>     stuff like that. All the custom DOS high system memmory loaded
>     BIOS workaround tricks are obsolete right now. If anywhere it should
>     be the FAT filesystem code which should be clever enough to deal with
>     it by adjusting it's read/write methods.

Not suggesting this isn't too obsolete to care about, but...

I really don't think that would be right. Look at this crud
as an alternate partition table format that just happens
to contain something which looks like a PC partition table.

Support would best involve:

1. fdisk modified to read/write the crud
2. the kernel reading the crud

By #2 I don't mean doing an offset for the whole disk.
You have a partition table that occupies 64 (?) sectors,
containing values stored with offsets added to them.

BTW, you are dropping support for typical Pentium boxes.
If this is OK, then the f00f check can go, etc.
