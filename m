Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVCPWk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVCPWk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVCPWk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:40:56 -0500
Received: from smtp04.auna.com ([62.81.186.14]:18073 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S261759AbVCPWjT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:39:19 -0500
Date: Wed, 16 Mar 2005 22:39:17 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.11-mm4
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20050316040654.62881834.akpm@osdl.org>
	<1110985632l.8879l.0l@werewolf.able.es>
	<20050316132600.3f6e4df2.akpm@osdl.org>
In-Reply-To: <20050316132600.3f6e4df2.akpm@osdl.org> (from akpm@osdl.org on
	Wed Mar 16 22:26:00 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1111012757l.17756l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.16, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > On 03.16, Andrew Morton wrote:
> >  > 
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/
> >  > 
> >  ...
> >  >
> >  > +revert-gconfig-changes.patch
> >  > 
> >  >  Back out a recent change which broke gconfig.
> >  > 
> > 
> >  What was broken ?
> 
> hm.  I emailed you twice, and had a feeling that things weren't getting
> through.
> 
> The patch caused those little pixmap buttons across the top of the main
> window to vanish when using gtk+-1.2.10-28.1.  See
> http://www.zip.com.au/~akpm/linux/patches/stuff/x.jpg.
> 
> I now note that scripts/kconfig/gconf.c doesn't compile at all with the
> above backout patch.  Drat.
> 

But gconf is not supposed to build with gtk-1.2, it needs 2.x,
at least reding this:

 linux/scripts/kconfig/Makefile:

HOSTLOADLIBES_gconf = `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --libs`
HOSTCFLAGS_gconf.o  = `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags` \
                          -D LKC_DIRECT_LINK

...
# GTK needs some extra effort, too...
$(obj)/.tmp_gtkcheck:
    @if `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --exists`; then       \
        if `pkg-config gtk+-2.0 --atleast-version=2.0.0`; then          \
            touch $@;                               \
        else                                    \
            echo "*";                           \
            echo "* GTK+ is present but version >= 2.0.0 is required."; \
            echo "*";                           \
            false;                              \
        fi                                  \
    else                                        \
        echo "*";                               \
        echo "* Unable to find the GTK+ installation. Please make sure that";   \
        echo "* the GTK+ 2.0 development package is correctly installed...";    \
        echo "* You need gtk+-2.0, glib-2.0 and libglade-2.0.";         \
        echo "*";                               \
        false;                                  \
    fi
endif

I can try just to make it compile, and then polish all the edges...
If you swear to me it does not have to build under gtk-1.2 (which with
current Makefile I do not know how can it be done), there are many stock
things that can be done automagically in 2.x, and not manually like in gtk-1.2.

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam5 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-6mdk)) #1


