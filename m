Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136736AbREHBr7>; Mon, 7 May 2001 21:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136737AbREHBrt>; Mon, 7 May 2001 21:47:49 -0400
Received: from chia.umiacs.umd.edu ([128.8.120.111]:23279 "EHLO
	chia.umiacs.umd.edu") by vger.kernel.org with ESMTP
	id <S136736AbREHBrf>; Mon, 7 May 2001 21:47:35 -0400
Date: Mon, 7 May 2001 21:47:33 -0400 (EDT)
From: Adam <adam@cfar.umd.edu>
X-X-Sender: <adam@chia.umiacs.umd.edu>
To: <linux-kernel@vger.kernel.org>
Subject: [ot] named sockets 
Message-ID: <Pine.GSO.4.33.0105072147230.24984-100000@chia.umiacs.umd.edu>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I kind of carelessly deleted /tmp/.X11-unix/X0. Now the thing is that
some programs which had not opened the socket before, can't connect to X.

The simplest solution would be just restart X, but that's too much effort
to me.

So I'm wondering, is there a way, kind of like "relink" system call which
coule take existing file descriptor (they are still so the fd is there,
just unlinked) and link it back to file name?

doing mksock  X0 [*], does not do the trick as the fd is different.

[*]
/* mksock - make a Unix domain socket */
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
int main(int argc, char **argv) {
	int sd; struct sockaddr_un sin;
	if ((sd = socket(AF_UNIX, SOCK_STREAM, 0))
	== -1) exit(1);
	strcpy(sin.sun_path, argv[1]);
	sin.sun_family = AF_UNIX;
	if ((bind(sd, &sin, sizeof(sin)) == -1))   exit(1);
	exit(0);
}

-- 
Adam
http://www.eax.com	The Supreme Headquarters of the 32 bit registers


