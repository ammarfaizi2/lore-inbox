Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263437AbTC2QRM>; Sat, 29 Mar 2003 11:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263438AbTC2QRM>; Sat, 29 Mar 2003 11:17:12 -0500
Received: from CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com ([24.114.72.97]:64521
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id <S263437AbTC2QRL>; Sat, 29 Mar 2003 11:17:11 -0500
Subject: linux kernel IDE development process question
From: Jeremy Jackson <jerj@coplanar.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1048955308.1467.20.camel@contact.skynet.coplanar.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 29 Mar 2003 11:28:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello IDE people,

I'd like to get input from everyone involved in drivers/ide/ on the
current development process.

I would like to know what code is kept in sync between 2.4/2.5
(2.2/2.0?).  This way I can start by understanding what is already being
done. This is related to the recent "hdparm and removable IDE?" thread
on LKML.

I would like to start by declaring ide_hwifs[] static, and removing the
extern ide_hwifs from ide.h.  all references to ide_hwifs[] will be
converted to macros and/or access method functions, that return a
pointer to a particular ide_hwifs_t.  for_each_hwif() and replacements
for whatever else is in use will be provided as well, initially just
doing the same thing that is done now, ie iterating through ide_hwifs[].

There's more to my plan, that's just to get the discussion going.  I
will only address what can be easily merged into all currently supported
kernel trees, I just need to know what they are.

by creating a new file ide-kernel.[ch], and moving the ide_hwifs[] and
accessor functions to it, each kernel tree can implement it differently
without complicating backports for the common stuff.  Initially the
changes will *not* alter any behaviour, just jockeying stuff into place
to make that painless when the time comes.  (think about it: if the
access methods return pointers, who's going to notice when ide_hwifs[]
is replaced with a linked list?)

My motivation: I'd *really* like to be able to sell entry level PC
servers with hotswap raid1.  I'm not in a hurry, baby steps are ok, I
just want to get the ball rolling.  It's all negotiable.  I'm no expert
here.

Regards,

Jeremy
-- 
Jeremy Jackson <jerj@coplanar.net>

