Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbSJWQxe>; Wed, 23 Oct 2002 12:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265086AbSJWQxe>; Wed, 23 Oct 2002 12:53:34 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:11278 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265077AbSJWQxd>; Wed, 23 Oct 2002 12:53:33 -0400
Date: Wed, 23 Oct 2002 17:59:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Matt D. Robinson" <yakker@aparity.com>
Cc: linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
Subject: Re: [PATCH] LKCD for 2.5.44 (3/8): kerntypes addition
Message-ID: <20021023175938.A16547@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Matt D. Robinson" <yakker@aparity.com>,
	linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
References: <Pine.LNX.4.44.0210230241050.27315-100000@nakedeye.aparity.com> <Pine.LNX.4.44.0210230243480.27315-100000@nakedeye.aparity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210230243480.27315-100000@nakedeye.aparity.com>; from yakker@aparity.com on Wed, Oct 23, 2002 at 02:44:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 02:44:04AM -0700, Matt D. Robinson wrote:
> This adds kerntypes into the build so that symbols can be
> extracted from a single build object in the kernel.  This
> also modifies the install process (where applicable) to
> copy the Kerntypes file along with the kernel and map.
> 
>  Makefile                   |   15 +++++++++++++--
>  arch/i386/boot/Makefile    |    2 +-
>  arch/i386/boot/install.sh  |   24 +++++++++++++++++-------
>  arch/s390/boot/install.sh  |   24 +++++++++++++++++-------
>  arch/s390x/boot/install.sh |   24 +++++++++++++++++-------
>  init/Makefile              |    5 +++++
>  init/kerntypes.c           |   24 ++++++++++++++++++++++++
>  7 files changed, 94 insertions(+), 24 deletions(-)
> 
> diff -Naur linux-2.5.44.orig/Makefile linux-2.5.44.lkcd/Makefile
> --- linux-2.5.44.orig/Makefile	Fri Oct 18 21:01:12 2002
> +++ linux-2.5.44.lkcd/Makefile	Sat Oct 19 12:53:45 2002
> @@ -273,6 +273,17 @@
>  MODLIB	:= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
>  export MODLIB
>  
> +#
> +# For crash dumps, pull out the Kerntypes copying for now.  We may
> +# still build init/kerntypes.o, but we don't copy it every time.
> +#
> +ifdef CONFIG_CRASH_DUMP
> +vmlinux-extra += Kerntypes
> +
> +Kerntypes:	init/kerntypes.o
> +	/bin/cp $< $@
> +endif

Why can't you directly link in init/kerntypes.o?

