Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSIDUXJ>; Wed, 4 Sep 2002 16:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSIDUXJ>; Wed, 4 Sep 2002 16:23:09 -0400
Received: from 216-42-72-141.ppp.netsville.net ([216.42.72.141]:5019 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S315414AbSIDUXI>;
	Wed, 4 Sep 2002 16:23:08 -0400
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
From: Chris Mason <mason@suse.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Tomas Szepe <szepe@pinerecords.com>, "David S. Miller" <davem@redhat.com>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       aurora-sparc-devel@linuxpower.org, reiserfs-dev@namesys.com,
       linuxjfs@us.ibm.com
In-Reply-To: <200209042018.g84KI6612079@shaggy.austin.ibm.com>
References: <200209042018.g84KI6612079@shaggy.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Sep 2002 16:29:21 -0400
Message-Id: <1031171361.10959.179.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 16:18, Dave Kleikamp wrote:
> > >    Against 2.4.20-pre5 - fix up the type of nlink_t. This makes jfs and
> > >    reiserfs stop complaining about comparisons always turning up false
> > >    due to limited range of data type.
> > >
> > > If you change this, you change the types exported to userspace
> > > which will break everything.
> > 
> > Right.  Here's a corresponding reiserfs/jfs fix, then.  I've checked the
> > constants aren't used for anything else except nlink overflow alerts.
> 
> I don't like this fix.  I know 32767 is a lot of links, but I don't like
> artificially lowering a limit like this just because one architecture
> defines nlink_t incorrectly.  I'd rather get rid of the compiler warnings
> with a cast in the few places the limit is checked, even though that is
> a little bit ugly.
> 

The patch will probably cause reiserfs problems as well, we've already
got people with > 32767 links on disk, going to a lower number will
confuse things.

-chris


