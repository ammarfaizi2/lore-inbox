Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129168AbRBCJsz>; Sat, 3 Feb 2001 04:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRBCJsp>; Sat, 3 Feb 2001 04:48:45 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:61523 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129168AbRBCJsd>; Sat, 3 Feb 2001 04:48:33 -0500
Date: Sat, 3 Feb 2001 04:48:09 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Paul Jakma <paul@clubi.ie>
Cc: "J . A . Magallon" <jamagallon@able.es>, Hans Reiser <reiser@namesys.com>,
        Alan Cox <alan@redhat.com>, Chris Mason <mason@suse.com>,
        Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com,
        "Yury Yu . Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
Message-ID: <20010203044809.Z16592@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20010202191701.Y16592@devserv.devel.redhat.com> <Pine.LNX.4.31.0102030420031.20193-100000@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0102030420031.20193-100000@fogarty.jakma.org>; from paul@clubi.ie on Sat, Feb 03, 2001 at 04:25:20AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2001 at 04:25:20AM +0000, Paul Jakma wrote:
> On Fri, 2 Feb 2001, Jakub Jelinek wrote:
> 
> > You can do:
> > if [ "$CC" = gcc ]; then
> >   echo 'inline void f(unsigned int n){int i,j=-1;for(i=0;i<10&&j<0;i++)if((1UL<<i)==n)j=i;if(j<0)exit(0);}main(){f(64);exit(1);}' > test.c
> >   gcc -O2 -o test test.c
> >   if ./test; then echo "*** Please don't use this compiler to compile kernel"; fi
> >   rm -f test.c test
> > fi
> >
> > (the $CC = gcc test is there e.g. so that the test is not done when
> > cross-compiling or when there is a separate kernel compiler and userland
> > compiler (e.g. on sparc64). This test will barf on gcc-2.96 up to -67 and
> >
> > 	Jakub
> 
> ehhmm..
> 
> [root@fogarty /tmp]# rpm -q gcc
> gcc-2.96-70
> [root@fogarty /tmp]# cat test.c
> inline void f(unsigned int n){int
> i,j=-1;for(i=0;i<10&&j<0;i++)if((1UL<<i)==n)j=i;if(j<0)exit(0);}main(){f(64);
> exit(1);}
> [root@fogarty /tmp]# gcc -o test test.c
> [root@fogarty /tmp]# ./test
> 
> didn't barf here with 2.96-70.

I used a wrong word (the test originally had abort() instead of exit(0) and
exit(0) instead of exit(1)). The test will exit with 0 if it was
miscompiled, 1 if it was not. And on 2.96-70 it should exit with 1 as it
should not be miscompiled.

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
