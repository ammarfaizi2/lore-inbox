Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265165AbSJWTJN>; Wed, 23 Oct 2002 15:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265166AbSJWTJM>; Wed, 23 Oct 2002 15:09:12 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:6671 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265165AbSJWTJL>; Wed, 23 Oct 2002 15:09:11 -0400
Date: Wed, 23 Oct 2002 20:15:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Matt D. Robinson" <yakker@aparity.com>
Cc: linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
Subject: Re: [PATCH] LKCD for 2.5.44 (3/8): kerntypes addition
Message-ID: <20021023201521.A21529@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Matt D. Robinson" <yakker@aparity.com>,
	linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
References: <20021023175938.A16547@infradead.org> <Pine.LNX.4.44.0210231051250.28800-100000@nakedeye.aparity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210231051250.28800-100000@nakedeye.aparity.com>; from yakker@aparity.com on Wed, Oct 23, 2002 at 10:52:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 10:52:35AM -0700, Matt D. Robinson wrote:
> On Wed, 23 Oct 2002, Christoph Hellwig wrote:
> |>On Wed, Oct 23, 2002 at 02:44:04AM -0700, Matt D. Robinson wrote:
> |>> This adds kerntypes into the build so that symbols can be
> |>> extracted from a single build object in the kernel.  This
> |>> also modifies the install process (where applicable) to
> |>> copy the Kerntypes file along with the kernel and map.
> |>
> |>Why can't you directly link in init/kerntypes.o?
> 
> We wanted to keep the bloat down, even as far as the
> file size is concerned.  Some people have problems with
> making the kernel image larger than it already is.  If
> Kerntypes adds another 100K to the image, that isn't a
> good thing in the eyes of some people.

I meant using init/kerntypes.o directly instead of copying it
to Kerntypes.  But after looking more into the build process
I've now noticed that Kerntypes isn't actually linked into
vmlinux at all.  But as it's a separate file you don't need
the ifdef CONFIG_CRASH_DUMP - people not wanting on their
potentially small root filesystems just don't have to copy
it.  That would be the last ifdef on CONFIG_CRASH_DUMP, so
dump.o can now be loaded into any kernel with the patch
applied.  cool! :)

