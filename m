Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129593AbRBZSfC>; Mon, 26 Feb 2001 13:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129640AbRBZSew>; Mon, 26 Feb 2001 13:34:52 -0500
Received: from adsl-64-168-227-89.dsl.sntc01.pacbell.net ([64.168.227.89]:38148
	"HELO lustre.us.mvd") by vger.kernel.org with SMTP
	id <S129593AbRBZSel>; Mon, 26 Feb 2001 13:34:41 -0500
From: "Peter J. Braam" <braam@mountainviewdata.com>
To: "Alexander Viro" <viro@math.psu.edu>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc: "Ronald G. Minnich" <rminnich@lanl.gov>
Subject: RE: [PATCH][CFT] per-process namespaces for Linux
Date: Mon, 26 Feb 2001 08:26:23 -0800
Message-ID: <NEBBIIJKCMJGDLNAMBCBMEDKCEAA.braam@mountainviewdata.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <Pine.GSO.4.21.0102242253460.24312-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Very neat!

Ron Minnich and I built something similar: we built private namespaces for
login sessions.  Ours have slightly different semantics I think.

To do so we changed mount+chroot into "imount" (i = invisible).  This landed
a process in a file system that had no root in the Unix directory tree.
(see the "Private name spaces, PNS" project on SourceForge.

We added another goodie, which was called "memdev".  It provided a new block
device from a private, i.e. copy on write, memory mapped block device.  See
"memdev" on SourceForge.

We used it as follows:

 - when you login, you get imounted into an environment where you have full
priviliges (except mknod).  The "/" of your environment is not a directory
in the Unix tree.
 - in this environment the system file systems are available to you on a
copy on write private basis.
 - any files you change get out over a network file system to a server.  We
used InterMezzo backed by a ramfs cache.

When the user logs out, everything is gone, except possibly footprints in
swap.

- Peter J. Braam -

Mountain View Data, Inc.

