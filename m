Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263297AbUKAOWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263297AbUKAOWG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 09:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbUKAOWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:22:05 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:14782 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263546AbUKAOU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:20:56 -0500
Date: Mon, 1 Nov 2004 15:20:54 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: John M Collins <jmc@xisl.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fchown on unix domain sockets?
In-Reply-To: <200410312255.00621.jmc@xisl.com>
Message-ID: <Pine.LNX.4.53.0411011517570.29275@yvahk01.tjqt.qr>
References: <200410312255.00621.jmc@xisl.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Please CC any reply to jmc AT xisl.com as I'm not subscribed.
>
>I wanted to change the ownership on a unix domain socket in a program (running
>as root) I was writing and I was wondering if "fchown" worked on the socket
>descriptor (after I'd run "bind" of course).
>
>It doesn't, you have to use "chown" on the path name - however "fchown"
>silently does nothing, it doesn't report an error.

I think that's normal, because chown() applies to an object in the filesystem,
while fchown() applies to the FD. (In fact, it applies to an inode.)
However, socket fd of any kind don't have an associated inode, because, well
sockets are not stored on the filesystem.

As some manpage might say, the socket thing you see in "ls -l" is just a
reference thing. When you connect to it, ls -l /proc/pidofprogram/fd/ does not
show the path, but [socket:xxxx] which shows that the filesystem object is not
used anymore.

>I don't mind it not working but I think it should report an error. This is on
>2.6.3 kernel.

What would you like it to do? EINVAL like the others or change the actual
inode's permission?



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
