Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267467AbTAGScv>; Tue, 7 Jan 2003 13:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbTAGScv>; Tue, 7 Jan 2003 13:32:51 -0500
Received: from [81.2.122.30] ([81.2.122.30]:25094 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267467AbTAGScu>;
	Tue, 7 Jan 2003 13:32:50 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301071841.h07If7QJ002323@darkstar.example.net>
Subject: Virtual WORM device
To: root@chaos.analogic.com
Date: Tue, 7 Jan 2003 18:41:07 +0000 (GMT)
Cc: maxvaldez@yahoo.com, bulb@ucw.cz, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1030107131613.3523A-100000@chaos.analogic.com> from "Richard B. Johnson" at Jan 07, 2003 01:17:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a project waiting for someone who wants
> to contribute. It only slightly involves the kernel,
> but is quite useful.

> Somebody should then modify `rm` and the kernel unlink
> to `mv' files to the dumpster directory on the
> file-system, instead of really deleting them.

Another possibility would be to create a meta-device that works like a
cross between the loopback device, and WORM device, I.E. start at the
begining, and allocate sectors sequentially.  Whenever a sector would
normally be overwritten, a new one is allocated instead.  This way,
you could always access the filesystem as it was at any mount in time.

Hypothetically, you could do something like:

mkmetawormdevice /dev/mw0 /dev/hda2

to create a device /dev/mw0, which uses /dev/hda2 for physical
storage.

Then:

write foo to sector 0 of /dev/mw0 - actually writes foo to sector 0 of
/dev/hda2

write bar to sector 1 of /dev/mw0 - actually writes foo to sector 1 of
/dev/hda2

write foobar to sector 0 of /dev/mw0 - actually writes foobar to
sector 2 of /dev/hda2, and notes the date and time that the virtual
'overwrite' happened.

Due to the sequential nature of the writes, the data could even be
compressed quite easily.

John.
