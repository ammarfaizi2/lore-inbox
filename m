Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129550AbRBCEYx>; Fri, 2 Feb 2001 23:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131010AbRBCEYn>; Fri, 2 Feb 2001 23:24:43 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:57735 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S129550AbRBCEYe>; Fri, 2 Feb 2001 23:24:34 -0500
Date: Sat, 3 Feb 2001 04:25:20 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: <paul@fogarty.jakma.org>
To: Jakub Jelinek <jakub@redhat.com>
cc: "J . A . Magallon" <jamagallon@able.es>, Hans Reiser <reiser@namesys.com>,
        Alan Cox <alan@redhat.com>, Chris Mason <mason@suse.com>,
        Jan Kasprzak <kas@informatics.muni.cz>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>,
        "Yury Yu . Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
In-Reply-To: <20010202191701.Y16592@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.31.0102030420031.20193-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Jakub Jelinek wrote:

> You can do:
> if [ "$CC" = gcc ]; then
>   echo 'inline void f(unsigned int n){int i,j=-1;for(i=0;i<10&&j<0;i++)if((1UL<<i)==n)j=i;if(j<0)exit(0);}main(){f(64);exit(1);}' > test.c
>   gcc -O2 -o test test.c
>   if ./test; then echo "*** Please don't use this compiler to compile kernel"; fi
>   rm -f test.c test
> fi
>
> (the $CC = gcc test is there e.g. so that the test is not done when
> cross-compiling or when there is a separate kernel compiler and userland
> compiler (e.g. on sparc64). This test will barf on gcc-2.96 up to -67 and
>
> 	Jakub

ehhmm..

[root@fogarty /tmp]# rpm -q gcc
gcc-2.96-70
[root@fogarty /tmp]# cat test.c
inline void f(unsigned int n){int
i,j=-1;for(i=0;i<10&&j<0;i++)if((1UL<<i)==n)j=i;if(j<0)exit(0);}main(){f(64);
exit(1);}
[root@fogarty /tmp]# gcc -o test test.c
[root@fogarty /tmp]# ./test

didn't barf here with 2.96-70.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
One person's error is another person's data.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
