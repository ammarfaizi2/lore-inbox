Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287627AbSALWlH>; Sat, 12 Jan 2002 17:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287625AbSALWk7>; Sat, 12 Jan 2002 17:40:59 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:11610 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S287619AbSALWkw>; Sat, 12 Jan 2002 17:40:52 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: trond.myklebust@fys.uio.no
Subject: Re: [NFS] some strangeness (at least) with linux-2.4.18-NFS_ALL patch
Date: Sat, 12 Jan 2002 23:40:44 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020111131528.44F8613E6@shrek.lisa.de> <20020112170111.12E601431@shrek.lisa.de> <15424.33959.99237.666877@charged.uio.no>
In-Reply-To: <15424.33959.99237.666877@charged.uio.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020112224046.4205F1433@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 12. January 2002 19:47, Trond Myklebust wrote:
> >>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:
>      > Somehow, gcc managed it to create an invalid link in the above
>      > sequence.  Really bad is, you cannot get around this within the
>      > client. After rm'ing lib/libsensors.so.1 on the server, make
>      > install succeeds on the client.
>
> <snip>
>
>      > I can reproduce this now. Do you?
>
> Nope.
>
> gcc -shared -Wl,-soname,libsensors.so.1 -o lib/libsensors.so.1.2.0
> lib/data.lo lib/general.lo lib/error.lo lib/chips.lo lib/proc.lo
> lib/access.lo lib/init.lo lib/conf-parse.lo lib/conf-lex.lo -lc
> rm -f lib/libsensors.so.1
> ln -sfn libsensors.so.1.2.0 lib/libsensors.so.1
> rm -f lib/libsensors.so
> ln -sfn libsensors.so.1.2.0 lib/libsensors.so
>
> Could you try just plain 2.4.18-pre3 + 2.4.18-NFS_ALL? That is what I
> am running (on both client + server).

Ok, done. Sad news, problem persist:
On compile:
gcc -shared -Wl,-soname,libsensors.so.1 -o lib/libsensors.so.1.2.0 
lib/data.lo lib/general.lo lib/error.lo lib/chips.lo lib/proc.lo 
lib/access.lo lib/init.lo lib/conf-parse.lo lib/conf-lex.lo -lc
rm -f lib/libsensors.so.1
ln -sfn libsensors.so.1.2.0 lib/libsensors.so.1
make: stat:lib/libsensors.so.1: Eingabe-/Ausgabefehler
rm -f lib/libsensors.so 
ln -sfn libsensors.so.1.2.0 lib/libsensors.so

On install:
make: stat:lib/libsensors.so.1: Eingabe-/Ausgabefehler
rm -f lib/libsensors.so.1
rm: Entfernen von »lib/libsensors.so.1« nicht möglich: Eingabe-/Ausgabefehler
make: *** [lib/libsensors.so.1] Error 1

Some system parameter:
server:
Dual Pentium 3/500, Asus P2B DS, 512 MB 
Linux version 2.4.18-pre3 (hp@shrek) (gcc version 2.95.3 20010315 (SuSE)) #2 
SMP Sam Jan 12 21:00:36 CET 2002
knfsd, reiserfs partition

client:
Athlon 1.2, Asus Via KT133, 768 MB
Linux version 2.4.18-pre3 (hp@elfe) (gcc version 2.95.3 20010315 (SuSE)) #3
Sam Jan 12 21:26:40 CET 2002
mount opt:
rw,nodev,v3,rsize=4096,wsize=4096,soft,intr,udp,lock,addr=shrek

Any more ideas? What's wrong with my setup?

Cheers,
Hans-Peter
