Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318268AbSIKBN5>; Tue, 10 Sep 2002 21:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318269AbSIKBN5>; Tue, 10 Sep 2002 21:13:57 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:34963 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S318268AbSIKBN4>; Tue, 10 Sep 2002 21:13:56 -0400
Subject: the userspace side of driverfs
From: Nicholas Miell <nmiell@attbi.com>
To: mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Sep 2002 18:18:37 -0700
Message-Id: <1031707119.1396.30.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see documentation describing the kernel interface for driverfs, but
not much is available describing the userspace interface to driverfs --
i.e. the format of all those files that driverfs exports.

In order to prevent driverfs from becoming the maze of twisted files,
all different that is /proc, these details need to be specified now,
before it's too late.

Some issues I can think of off the top of my head:

- Can I safely assume that, for all normal files named X in driverfs,
that they have the exact same format and purpose?

- The "resource" files export resource structs, however the flags member
of the struct uses bits that aren't exported by the kernel and are
likely to change in the future. Also, some of the flags bits are
reserved for use by the bus that the resource lives on, but the bus type
isn't specified by the resource file, which requires the app to parse
the path name in order to figure out which bus the resource refers to.

- "name" isn't particularly consistent. Sometimes it requires parsing to
be useful ("PCI device 1234:1234", "USB device 1234:1234", etc.",
sometimes it's the actual device name, sometimes it's something strange
like "Hub/Port Status Changes".


- Nicholas

