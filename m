Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWGJMs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWGJMs5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 08:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbWGJMs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 08:48:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:57322 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161008AbWGJMs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 08:48:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CmGfWoomhmxXU8eHH14LrZXGRROBHd2iReOWh13CzzDMBcnTQQKB9i+zQ0b2mf2qjN9ae7DHZ2iWloblayA1meYiq9jPDo9rfJLtaRKJoVA+9dJUdIa/vJFDVd5wVG2hVkyAsPfTqcOudV3vIXR8cMvJZ6s25MGOcHfUbOK1omc=
Message-ID: <9a8748490607100548o14dbe684j40bde90eb19a7558@mail.gmail.com>
Date: Mon, 10 Jul 2006 14:48:55 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(arrgh, for some reason this just won't hit LKML - trying a third
time, this time without a Cc: list, I hope the people on Cc: got the
mail originally)...


Hi,

I've been down this road before, with mixed reception, but I think it's
worth doing, so I'll try again.

What I want to do is make the kernel build cleanly with -Wshadow.
Shadowing a symbol from an enclosing scope is an easy way to create
bugs and from a "keep namespaces seperate" viewpoint it's messy.
So, I propose that we clean it up so that in the future we can have
-Wshadow enabled in the top-level Makefile and avoid it.

If I just add -Wshadow to the top-level Makefile (as [PATCH 1/9] does)
I get the following results for some different configs :

allnoconfig     :       1224 -Wshadow related warnings.
allmodconfig    :       39886 -Wshadow related warnings.
allyesconfig    :       32358 -Wshadow related warnings.
my own config   :       5271 -Wshadow related warnings.

After applying the patches in this series the warnings are reduced to :

allnoconfig     :       112             (~9%)
allmodconfig    :       9633    (~24%)
allyesconfig    :       9612    (~30%)
my own config   :       1296    (~25%)

In addition, the patches clean up a few shadow warnings generated when
running  make all[no|mod|yes]config && make menuconfig .

So with just a few patches the vast majority of the warnings are gone,
and most of the remaining ones look fairly trivial as well.
This is only for x86, but I suspect that once that arch is cleaned up,
what's left for the others should be minor.

I'm willing to do a complete cleanup, but before I do more than these
initial 9 patches I would like to be sure that such patches are wanted.
It's not exactely interresting work and it's going to take some time
so if it's not wanted I'd rather not waste my time on it.

By posting these initial patches I hope people will comment on the
usefulness of this, my choice of (new) variable names etc. so that I
can create the best possible cleanup patches going forward.

If these patches are acceptable as-is then getting them merged into -mm
would be great (possibly excluding [PATCH 1/9] for now) so that I can
continue working against -mm going forward. Then when all (or almost all)
warnings are gone we can add -Wshadow to the Makefile in -mm for a few
releases and then eventually merge with mainline.

The patches in this series are :

0/9 -Wshadow: Making the kernel build clean with -Wshadow
1/9 -Wshadow: Add -Wshadow to toplevel Makefile
2/9 -Wshadow: Fix warnings in mconf
3/9 -Wshadow: lxdialog warning fixes
4/9 -Wshadow: fix warnings caused by jiffies.h
5/9 -Wshadow: variables named 'up' clash with up()
6/9 -Wshadow: 'map_bh' and 'wbc' shadow fixes
7/9 -Wshadow: fixes for checksum.h
8/9 -Wshadow: vgacon fixes
9/9 -Wshadow: fixes for drivers/char/keyboard.c

So, what do people say?


/Jesper Juhl <jesper.juhl@gmail.com>
