Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTCORmi>; Sat, 15 Mar 2003 12:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261487AbTCORmi>; Sat, 15 Mar 2003 12:42:38 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:50436 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S261486AbTCORmg>; Sat, 15 Mar 2003 12:42:36 -0500
Subject: Re: [patch] NUMAQ subarchification
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
In-Reply-To: <247240000.1047693951@flay>
References: <1047676332.5409.374.camel@mulgrave>
	<3E7284CA.6010907@us.ibm.com> <3E7285E7.8080802@us.ibm.com> 
	<247240000.1047693951@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 15 Mar 2003 11:53:15 -0600
Message-Id: <1047750799.1964.72.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-14 at 20:05, Martin J. Bligh wrote:
> No, *please* don't do this. Subarch for .c files is *broken*.

It is the place designed for code belonging only to one subarch.

> Last time I looked (and I don't think anyone has fixed it since) 
> it requires copying files all over the place, making an unmaintainable
> nightmare. Either subarch needs fixing first, or we don't use it.

It's design is identical to the arch directories, except that it has far
fewer hooks.  People grumble about having to change 20 arch files when
they want to alter the interface, but no-one's yet called it
unmaintainable.

The subarch split is designed to support machines with radically
different architectures like voyager and to a lesser extent visws.  Just
because summit isn't a radically different architecture doesn't make the
subarch concept broken.  I think other people have mentioned before that
what you probably need for summit is a modular apic driver.  However, if
you want to propose changes to the subarch setup, you're welcome to do
that too.

The problem you have (your setup.c and topology.c are identical to the
default) was originally going to be solved using VPATH.  Unfortunately,
that got broken along the way in the new build scheme, so the best I
think you can do is add this to the summit Makefile

$(obj)/setup.c: $(src)/../mach-default/setup.c
	cat $< $@

etc.

Kai isn't going to like this, but hopefully he will be able to come up
with a better solution.

However, you could also take this opportunity to remove the NUMA
pollution from mach-generic/topology.c.

> Let's just stick with your original patch - it's fine.

No, it's not.  The object of the subarch is to remove all subarch
specific files from the main i386/kernel directory.

James


