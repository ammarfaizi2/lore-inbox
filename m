Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbRDFHAE>; Fri, 6 Apr 2001 03:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131308AbRDFG7y>; Fri, 6 Apr 2001 02:59:54 -0400
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:6274
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S131307AbRDFG7o>; Fri, 6 Apr 2001 02:59:44 -0400
Message-ID: <3ACD68FF.637D8958@math.ethz.ch>
Date: Fri, 06 Apr 2001 08:58:08 +0200
From: Giacomo Catenazzi <cate@math.ethz.ch>
Reply-To: cate@debian.org
X-Mailer: Mozilla 4.75C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: johan.adolfsson@axis.com
CC: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Arch specific/multiple Configure.help files?
In-Reply-To: <fa.ggqkpgv.9g0c0b@ifi.uio.no> <fa.k6fq96v.nhaq06@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

johan.adolfsson@axis.com wrote:
> 
> I went ahead and implemented the change last night anyway and I
> will submit the patches and see if it will be accepted or not.
> The idea is that it first check in arch/$ARCH/Configure.help
> and if the file or the help is not found there,
> check Documentation/Configure.help.
> 
> I believe there is an advantage from a maintenance point of view.
> It least for our CRIS architecture, I don't think it's any benefit to
> "bloat" the Documentation/Configure.help with a lot of
> CONFIG_ETRAX entries for the various hardware inerfaces
> when the help and config can be kept locally.
> 

This was already discussed on kbuild list.
It is better to have only 1 Configure.help. This help
translation of
the file and help busy developers. They should not rewrite
texts
in every Configure.help.

If you should provide a special help on a specific ARCH you
could
modify the symbols:
instead of
: bool 'std IPC support' CONFIG_IPC
you can do:
: bool 'arch specific IPC help' CONFIG_IPC_STRANGE_ARCH
: define_bool CONFIG_IPC CONFIG_IPC_STRANGE_ARCH


ESR CML2 have the defualt path for Configure.help build in
the rules files, but it can be overriden by command options
to use an other Configure.help (the format do not change).

It is also designed so that a distribution can include
a translation of Configure.help. (But we don't expect
to include translation in std linux kernel)


> BTW: I added this to scripts/Configure and scripts/Menuconfig
> but I know to little tcl/tk to get it to work for the xconfig case.
> The variable $ARCH was not found and I don't know how to make
> it get it from the environment variables.
> 

$ARCH is set on the top of the main Makefile. You can copy
the small shell script from here.


	giacomo

> /Johan
>
