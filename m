Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281360AbRKEVnR>; Mon, 5 Nov 2001 16:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281361AbRKEVnI>; Mon, 5 Nov 2001 16:43:08 -0500
Received: from mxout1.netvision.net.il ([194.90.9.20]:37782 "EHLO mxout1")
	by vger.kernel.org with ESMTP id <S281360AbRKEVnE>;
	Mon, 5 Nov 2001 16:43:04 -0500
Date: Mon, 05 Nov 2001 23:45:05 +0200
From: Etay Meiri <cl1@netvision.net.il>
Subject: keeping the socket open in the kernel
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <20011105234505.B17086@amber>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Consider the following scenario:
A daemon is waiting on accept() on a socket in the user space.
It receives a new connection and sends the socket descriptor down
to a module waiting for it in the kernel using ioctl().
The module gets the socket behind the descriptor using fget()
and socki_lookup() on the inode.
The module spawns a kernel thread that now reads from that socket.

Everything is working great even if the daemon now closes the new socket.
The session remains open and there is data transfer.

The problem is that if the deamon dies for whatever reason, the kernel thread
returns from the read with ERESTARTSYS and the socket can no longer be used.
I tried several things including raising the count on the inode and the file
structure. Nothing helped. I'de like my module to continue functioning even
after the daemon dies.

I'de appreciate any ideas.

TIA

-- 
************************************************
"When in doubt, use brute force."
									Ken Thompson
Etay Meiri
cl1@netvision.net.il
************************************************
