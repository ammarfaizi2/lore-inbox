Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265213AbSJWU4O>; Wed, 23 Oct 2002 16:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265223AbSJWU4O>; Wed, 23 Oct 2002 16:56:14 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:16196 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S265213AbSJWU4N>; Wed, 23 Oct 2002 16:56:13 -0400
Date: Wed, 23 Oct 2002 14:10:35 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Christoph Hellwig <hch@infradead.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: linux-kernel@vger.kernel.org, <lkcd-devel@lists.sourceforge.net>
Subject: Re: [PATCH] LKCD for 2.5.44 (3/8): kerntypes addition
In-Reply-To: <20021023201521.A21529@infradead.org>
Message-ID: <Pine.LNX.4.44.0210231259330.28800-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Christoph Hellwig wrote:
|>On Wed, Oct 23, 2002 at 10:52:35AM -0700, Matt D. Robinson wrote:
|>> On Wed, 23 Oct 2002, Christoph Hellwig wrote:
|>> |>On Wed, Oct 23, 2002 at 02:44:04AM -0700, Matt D. Robinson wrote:
|>> |>> This adds kerntypes into the build so that symbols can be
|>> |>> extracted from a single build object in the kernel.  This
|>> |>> also modifies the install process (where applicable) to
|>> |>> copy the Kerntypes file along with the kernel and map.
|>> |>
|>> |>Why can't you directly link in init/kerntypes.o?
|>> 
|>> We wanted to keep the bloat down, even as far as the
|>> file size is concerned.  Some people have problems with
|>> making the kernel image larger than it already is.  If
|>> Kerntypes adds another 100K to the image, that isn't a
|>> good thing in the eyes of some people.
|>
|>I meant using init/kerntypes.o directly instead of copying it
|>to Kerntypes.  But after looking more into the build process
|>I've now noticed that Kerntypes isn't actually linked into
|>vmlinux at all.  But as it's a separate file you don't need
|>the ifdef CONFIG_CRASH_DUMP - people not wanting on their
|>potentially small root filesystems just don't have to copy
|>it.  That would be the last ifdef on CONFIG_CRASH_DUMP, so
|>dump.o can now be loaded into any kernel with the patch
|>applied.  cool! :)

Okay, so I've removed the $(TOPDIR)/Makefile CONFIG_CRASH_DUMP
changes so that Kerntypes is never in $(TOPDIR), and if a 'make
install' is done that the init/kerntypes.o gets copied into
$(INSTALL_PATH) under the name 'Kerntypes'.

The Makefiles for i386, s390 and s390x needed changing for
$(TOPDIR)/Kerntypes to $(TOPDIR)/init/kerntypes.o.  That and
$(TOPDIR)/Makefile is now the original.  The init/Makefile changes
stay (per Kai's original comments).

Putting this one on the patch web site.  Done.

--Matt

