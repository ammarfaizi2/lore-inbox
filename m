Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310749AbSCWSTy>; Sat, 23 Mar 2002 13:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310695AbSCWSTp>; Sat, 23 Mar 2002 13:19:45 -0500
Received: from ns1.pebbles.net ([209.49.196.21]:23309 "HELO pebbles.net")
	by vger.kernel.org with SMTP id <S310749AbSCWSTg>;
	Sat, 23 Mar 2002 13:19:36 -0500
Date: Sat, 23 Mar 2002 13:19:39 -0500
From: Kelly French <kfrench@pebbles.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: make rpm is not documented
Message-ID: <20020323131939.A9293@pebbles.net>
In-Reply-To: <20020320154100.D21789@pcmaftoul.esrf.fr> <E16nhv9-0002XX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 03:22:35PM +0000, Alan Cox wrote:
> > Second stuff, make rpm don't work for me on suse's kernel.
> 
> Ask SuSE 8)
> 
> > Didn't yet watched what is the problem, but seems to be related with
> > EXTRAVERSION or something like this.
> 
> At least some versions of the script didnt like multiple '-' symbols. 
> Gerald Britton fixed this for 2.4.18
> 
> > I will have further look and will try to say as much as I can with my
> > poor knowledge.
> 
> Basically the thing works with
> 
> make config/menuconfig/xconfig
> if you use make menu/xconfig then run make oldconfig (I dont trust xconfig..)
> make rpm
> 
> [wait.. wait.. wait.. ]
> 
> rpm --install
> 
> add to lilo.conf
> 
> enjoy

Any chance we can copy the .config to /boot/config-$version?

--- scripts/mkspec.orig	Sat Mar 23 13:13:19 2002
+++ scripts/mkspec	Sat Mar 23 13:13:37 2002
@@ -35,6 +35,7 @@
 echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
 echo 'cp arch/i386/boot/bzImage $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo 'cp .config $RPM_BUILD_ROOT'"/boot/config-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 echo ""
 echo "%clean"
 echo '#echo -rf $RPM_BUILD_ROOT'

	-kf
