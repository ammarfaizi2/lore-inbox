Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUEBA03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUEBA03 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 20:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUEBA03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 20:26:29 -0400
Received: from piedra.unizar.es ([155.210.11.65]:34781 "EHLO relay.unizar.es")
	by vger.kernel.org with ESMTP id S262772AbUEBA0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 20:26:25 -0400
Date: Sun, 2 May 2004 02:26:19 +0200
From: Jorge Bernal <koke_lkml@amedias.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange delays on console logouts (tty != 1)
Message-ID: <20040502002619.GB31921@amedias.org>
References: <20040430195351.GA1837@amedias.org> <20040501222040.GA10780@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040501222040.GA10780@taniwha.stupidest.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 03:20:40PM -0700, Chris Wedgwood wrote:
> On Fri, Apr 30, 2004 at 09:53:51PM +0200, Jorge Bernal wrote:
> or perhaps try something like (not actually tested in this form):
> 
>    for i in `seq 1 1000` ; do \
>        echo before > /dev/tty7 ; \
>        strace -ttogetty-trace.$i getty 38400 tty7 linux ; \
>        echo after > /dev/tty7 ; \
>    done
> 

[02:11]~$ logout
after
before
after
before

Debian GNU/Linux testing/unstable tuxland.amedias.org tty9

tuxland.amedias.org login: koke
Password:
Last login: Sun May  2 02:11:06 2004 on tty9
Linux tuxland.amedias.org 2.6.5 #2 Sun Apr 11 14:20:11 CEST 2004 i686
GNU/Linux
No mail.

[02:11]~$ logout
after
before
after
before
after
before
after
before
after
before
after
before
after
before

...
And after 8 after/befores, the login appears again. The delay is after
the "before".

In the strace logs I can see a lot of alarms() and read(3,...). Note: fd
3 corresponds to /var/run/utmp

A bit of the log
02:11:08.850311 alarm(1)                = 0
02:11:08.850345 fcntl64(3, F_SETLKW, {type=F_RDLCK, whence=SEEK_SET,
start=0, len=0}) = 0
02:11:08.850386 read(3,
"\7\0\0\0\7\2\0\0tty9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 384) = 384
02:11:08.850442 fcntl64(3, F_SETLKW, {type=F_UNLCK, whence=SEEK_SET,
start=0, len=0}) = 0


> Please let me know what getty (version, etc) you are using and what
> distro and other relevant things as it might be a bug specific to some
> distro's and not others as few people have reported this.
> 

I don't know where to look at the getty version, but I'm using Debian
Sid with util-linux=2.12-6 (the package which contains getty)

Something curious: I have just discovered that:
tuxland:~/gettylog# ps aux | grep tty9
root       998  0.0  0.1  2080  712 tty4     R    02:25   0:00 grep tty9
tuxland:~/gettylog# last | head
koke     tty9                          Sun May  2 02:24    gone - no logout
koke     tty9                          Sun May  2 02:11 - 02:24  (00:12)
[...]


> 
> 
> Thanks,
> 
>   --cw
> 

-- 
"Sólo el éxito diferencia al genio del loco"

Blog: http://www.amedias.org/koke
Web Personal: http://sindominio.net/~koke/
JID: koke@zgzjabber.ath.cx
