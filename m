Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132862AbREHQV5>; Tue, 8 May 2001 12:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132886AbREHQVr>; Tue, 8 May 2001 12:21:47 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:33183 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S132862AbREHQVd>;
	Tue, 8 May 2001 12:21:33 -0400
Date: Tue, 8 May 2001 18:21:28 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200105081621.SAA14493@harpo.it.uu.se>
To: adam@cfar.umd.edu, linux-kernel@vger.kernel.org
Subject: Re: [ot] named sockets
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2001 21:47:33 -0400 (EDT), Adam <adam@cfar.umd.edu> wrote:

>So I'm wondering, is there a way, kind of like "relink" system call which
>coule take existing file descriptor (they are still so the fd is there,
>just unlinked) and link it back to file name?

POSIX' fattach(int fd, const char *path) library call does that,
although it's often limited to STREAMS fd:s. It's usually
implemented as mounting "namefs" at the path (SVR4) or setting
a magic mount option (OSF1), with the fd passed in as mount-point
specific data. Regular users are allowed to do this special mount().

Linux currently doesn't have this functionality, but it could
probably be implemented as a pseudo-fs in 2.4, assuming the 2.4
VFS properly supports stacking of file systems. (There's some
gotchas concerning chown/chmod changes and restoring the original
object after the fd is unmounted.)

Not that I think Linux really needs this creeping featurism ...

/Mikael
