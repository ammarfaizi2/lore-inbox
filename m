Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318518AbSHUR4m>; Wed, 21 Aug 2002 13:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318536AbSHUR4m>; Wed, 21 Aug 2002 13:56:42 -0400
Received: from imailg3.svr.pol.co.uk ([195.92.195.181]:40238 "EHLO
	imailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S318518AbSHUR4l>; Wed, 21 Aug 2002 13:56:41 -0400
Date: Wed, 21 Aug 2002 19:00:44 +0100
From: Dave Wilson <lkml@botanicus.net>
To: linux-kernel@vger.kernel.org
Subject: fchmod on a socket?
Message-ID: <20020821190044.A2639@dw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Setup: Linux 2.4.19-grsec, et:tw=75
X-WWW: http://botanicus.net/dw/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
I'm unsure as to whether this is a bug or not, but if I try to do an
fchmod() on an fd for a UNIX domain socket, it returns success (0), but
does not actually change the permission mode.

--- strace
socket(PF_UNIX, SOCK_DGRAM, 0)          = 3
bind(3, {sin_family=AF_UNIX, path="/tmp/log.extended"}, 110) = 0
setsockopt(3, SOL_SOCKET, SO_PASSCRED, [1], 4) = 0
fcntl64(3, F_SETFL, O_RDONLY|O_ASYNC)   = 0
fchmod(3, 0666)                         = 0
---

--- socket
  File: "/tmp/log.extended"
  Size: 0               Blocks: 0          Socket
Device: 1601h/5633d     Inode: 193160      Links: 1    
Access: (0755/srwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/   wheel)
---

Thanks,
Dave.
