Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129776AbRBCAHE>; Fri, 2 Feb 2001 19:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129645AbRBCAGy>; Fri, 2 Feb 2001 19:06:54 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:12305 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129356AbRBCAGk>; Fri, 2 Feb 2001 19:06:40 -0500
Message-ID: <3A7B440F.12B7BE77@namesys.com>
Date: Sat, 03 Feb 2001 02:34:39 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: Alan Cox <alan@redhat.com>, Chris Mason <mason@suse.com>,
        Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com,
        "Yury Yu . Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
In-Reply-To: <200102022213.f12MDCR27812@devserv.devel.redhat.com> <3A7B30FB.C63DBD11@namesys.com> <20010203004003.A2962@werewolf.able.es>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would agree with you, and I was about to write something saying that trusting
that rpm is installed is bad, except that then I realized, only RedHat made this
error, and only RedHat installs need this protection.

Now, if we want to have a more general bad gcc's list, and we envision this code
evolving, then yes, Alan's code is way too specific, and we should do it
differently so as to force them to increment what gcc -v returns whenever they
want anybody to pay attention to their having fixed a bug.  I was trying to be
sociable for once though....

Hans


"J . A . Magallon" wrote:
> 
> On 02.02 Hans Reiser wrote:
> > Alan Cox wrote:
> > > Run a small shell check and let it fail if the shell stuff errors.
> > >
> > > The fragment you want is
> > >
> > > if [ -e /bin/rpm ]; then
> > >         X=`rpm -q gcc`
> > >         if [ "$X" = "gcc-2.96-54" ]; then
> > >                 echo "*** GCC 2.96-54 will miscompile Reiserfs. Please
> > update your compiler"
> > >                 echo "See http://www.redhat.com/support/errata/RHBA-2000-132.html"
> > >                 exit 255
> > >         fi
> > > fi
> > Ok, thanks Alan, we'll use it, Yura, write something resembling or equal to
> > this, test it, and check it into our CVS branch.
> >
> 
> Please, do not do so. That depends on the PACKAGE name and version, and there
> is no standard way of versioning a patched gcc.
> The -54 is a RH'ism, for example Mandrake Cooker includes patches from
> different sources, and gcc is versioned like
> 
> werewolf:~# rpm -q gcc
> gcc-2.96-0.33mdk
> 
> and ChangeLog is:
> 
> werewolf:~# rpm -q --changelog gcc
> * Mon Jan 15 2001 David BAUDENS <baudens@mandrakesoft.com> 2.96-0.33mdk
> 
> - Fix build on PPC
> 
> * Mon Jan 15 2001 Chmouel Boudjnah <chmouel@mandrakesoft.com> 2.96-0.32mdk
> 
> - Try to fix when alternatives is broken in %post.
> - Merge with RH package (rel70) of Jakub :
>                         ^^^^^^^
> ..
> 
> so it suits a 2.96-70 gcc.
> 
> --
> J.A. Magallon                                                      $> cd pub
> mailto:jamagallon@able.es                                          $> more beer
> 
> Linux werewolf 2.4.1-ac1 #2 SMP Fri Feb 2 00:19:04 CET 2001 i686
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
