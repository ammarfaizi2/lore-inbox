Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130263AbRBCARp>; Fri, 2 Feb 2001 19:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130450AbRBCARf>; Fri, 2 Feb 2001 19:17:35 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:19997 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130263AbRBCARY>; Fri, 2 Feb 2001 19:17:24 -0500
Date: Fri, 2 Feb 2001 19:17:01 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Hans Reiser <reiser@namesys.com>, Alan Cox <alan@redhat.com>,
        Chris Mason <mason@suse.com>, Jan Kasprzak <kas@informatics.muni.cz>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        "Yury Yu . Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
Message-ID: <20010202191701.Y16592@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <200102022213.f12MDCR27812@devserv.devel.redhat.com> <3A7B30FB.C63DBD11@namesys.com> <20010203004003.A2962@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010203004003.A2962@werewolf.able.es>; from jamagallon@able.es on Sat, Feb 03, 2001 at 12:40:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2001 at 12:40:03AM +0100, J . A . Magallon wrote:
> Please, do not do so. That depends on the PACKAGE name and version, and there
> is no standard way of versioning a patched gcc.
> The -54 is a RH'ism, for example Mandrake Cooker includes patches from
> different sources, and gcc is versioned like

You can do:
if [ "$CC" = gcc ]; then
  echo 'inline void f(unsigned int n){int i,j=-1;for(i=0;i<10&&j<0;i++)if((1UL<<i)==n)j=i;if(j<0)exit(0);}main(){f(64);exit(1);}' > test.c
  gcc -O2 -o test test.c
  if ./test; then echo "*** Please don't use this compiler to compile kernel"; fi
  rm -f test.c test
fi

(the $CC = gcc test is there e.g. so that the test is not done when
cross-compiling or when there is a separate kernel compiler and userland
compiler (e.g. on sparc64). This test will barf on gcc-2.96 up to -67 and
on 2.97 until end of November or so).
Similarly a testcase for the reload bug which caused in 2.95.2
miscompilation of some long long stuff in the kernel could be added as well
if you want to go that way.

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
