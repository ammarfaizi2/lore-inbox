Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130664AbRBBXkh>; Fri, 2 Feb 2001 18:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130692AbRBBXk2>; Fri, 2 Feb 2001 18:40:28 -0500
Received: from jalon.able.es ([212.97.163.2]:25047 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130682AbRBBXkP>;
	Fri, 2 Feb 2001 18:40:15 -0500
Date: Sat, 3 Feb 2001 00:40:03 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Hans Reiser <reiser@namesys.com>
Cc: Alan Cox <alan@redhat.com>, Chris Mason <mason@suse.com>,
        Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com,
        "Yury Yu . Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
Message-ID: <20010203004003.A2962@werewolf.able.es>
In-Reply-To: <200102022213.f12MDCR27812@devserv.devel.redhat.com> <3A7B30FB.C63DBD11@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A7B30FB.C63DBD11@namesys.com>; from reiser@namesys.com on Fri, Feb 02, 2001 at 23:13:15 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.02 Hans Reiser wrote:
> Alan Cox wrote:
> > Run a small shell check and let it fail if the shell stuff errors.
> > 
> > The fragment you want is
> > 
> > if [ -e /bin/rpm ]; then
> >         X=`rpm -q gcc`
> >         if [ "$X" = "gcc-2.96-54" ]; then
> >                 echo "*** GCC 2.96-54 will miscompile Reiserfs. Please
> update your compiler"
> >                 echo "See http://www.redhat.com/support/errata/RHBA-2000-132.html"
> >                 exit 255
> >         fi
> > fi
> Ok, thanks Alan, we'll use it, Yura, write something resembling or equal to
> this, test it, and check it into our CVS branch.
> 

Please, do not do so. That depends on the PACKAGE name and version, and there
is no standard way of versioning a patched gcc.
The -54 is a RH'ism, for example Mandrake Cooker includes patches from
different sources, and gcc is versioned like

werewolf:~# rpm -q gcc
gcc-2.96-0.33mdk

and ChangeLog is:

werewolf:~# rpm -q --changelog gcc
* Mon Jan 15 2001 David BAUDENS <baudens@mandrakesoft.com> 2.96-0.33mdk

- Fix build on PPC

* Mon Jan 15 2001 Chmouel Boudjnah <chmouel@mandrakesoft.com> 2.96-0.32mdk

- Try to fix when alternatives is broken in %post.
- Merge with RH package (rel70) of Jakub :
                        ^^^^^^^
..

so it suits a 2.96-70 gcc.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac1 #2 SMP Fri Feb 2 00:19:04 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
