Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286419AbSABASy>; Tue, 1 Jan 2002 19:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286421AbSABASp>; Tue, 1 Jan 2002 19:18:45 -0500
Received: from mail016.syd.optusnet.com.au ([203.2.75.176]:11213 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S286419AbSABASd>; Tue, 1 Jan 2002 19:18:33 -0500
Date: Wed, 2 Jan 2002 11:18:16 +1100
From: Andrew Clausen <clausen@gnu.org>
To: linux-kernel@vger.kernel.org, bug-parted@gnu.org,
        evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] userspace discovery of partitions
Message-ID: <20020102111816.A869@gnu.org>
In-Reply-To: <20020102055735.C472@gnu.org> <20020101131817.J12868@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020101131817.J12868@lynx.no>; from adilger@turbolabs.com on Tue, Jan 01, 2002 at 01:18:17PM -0700
X-Accept-Language: en,pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2002 at 01:18:17PM -0700, Andreas Dilger wrote:
> On Jan 02, 2002  05:57 +1100, Andrew Clausen wrote:
> > As discussed a while ago (see thread starting at
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0105.2/0659.html), I
> > wrote a frontend to libparted that does nothing but probe all
> > block devices for partition tables, and tells the kernel what
> > partitions it finds.  It optionally prints a short summary.
> 
> This would mesh nicely with the filesystem (and other content) probing
> tool/lib that I wrote, blkid.  It probes filesystem types (and also
> label, uuid, fs size for common fs types).

Indeed.  To be honest, I think it's a mistake to have both libparted
and blkid.  OTOH, libparted isn't scaling down very well (yet).

> Hmm, it does seem a bit large for what it is doing.  Any idea where
> the bloat is coming from?

Mainly because the code is structured for editing.  Editing is much
harder than just reading.  There is a lot more information to parse,
that you could otherwise throw out.  For example, you don't care about
partition names, or whether the partition has some magic flag to
allow it to boot on architecture X.

Also, since you must provide an incremental editing system when
editting, it is often easier to use this system when you are
parsing.  That means you can't get rid of the editing system when
all you want to do is parse.  In libparted, this includes a
constraint solver (about 7k), code to verify that there's space
for metadata, code to set partition types, flags...

In practice, all this code is hard to separate out, and it all
adds up.  Perhaps this is an argument for maintaining two sets of
partition code.  Feel free to look at the code, and decide for
yourself ;)

Andrew

