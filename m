Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263446AbSIQBU6>; Mon, 16 Sep 2002 21:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263448AbSIQBU6>; Mon, 16 Sep 2002 21:20:58 -0400
Received: from smtp.cogeco.net ([216.221.81.25]:43507 "EHLO fep6.cogeco.net")
	by vger.kernel.org with ESMTP id <S263446AbSIQBU5>;
	Mon, 16 Sep 2002 21:20:57 -0400
Subject: DoS ?
From: "Nix N. Nix" <nix@go-nix.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Sep 2002 21:25:54 -0400
Message-Id: <1032225955.21068.31.camel@tux.go-nix.ca>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a situation that might be considered a DoS (just like that
special arrangement of symlinks a while back):

I have 2 computers: achilles and tux (both Linux).  I mounted an SMB
shared by tux onto achilles.  Then I loop-mounted an ISO found on this
share on achilles.  I had to reboot tux.  

Now, on achilles, trying to ls -l the mount point of the loop-mounted
ISO or the SMB mount simply hangs the ls unkillably.  Not only that, but
all my cron jobs using those partitions have been hanging for days,
raising my load average considerably.

Umounting the ISO doesn't work (Device is busy), and neither does
umounting the SMB share.  I tried doing a kill -9 on the pid of
"mount.smbfs" and it died, but it didn't fix the ls problem.

On tux, I shut down smbd and nmbd, and that killed the tux side of the
SMB socket from achilles.  However, on achilles, netstat still says that
there's an ESTABLISHED socket to tux.  I tried using one of those
kill-a-socket utils to kill it (by sending it a RST packet), but it
didn't work.

achilles is running 2.4.18 vanilla.  It is an SMP box.
tux is running 2.4.19 vanilla.  It is an UP box.

I would appreciate any help.  Thanks.

