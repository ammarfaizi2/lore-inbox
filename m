Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWIFN0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWIFN0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWIFN0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:26:25 -0400
Received: from nef2.ens.fr ([129.199.96.40]:17162 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1750926AbWIFN0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:26:24 -0400
Date: Wed, 6 Sep 2006 15:26:23 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060906132623.GA15665@clipper.ens.fr>
References: <20060905212643.GA13613@clipper.ens.fr> <20060906002730.23586.qmail@web36609.mail.mud.yahoo.com> <20060906100610.GA16395@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906100610.GA16395@clipper.ens.fr>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Wed, 06 Sep 2006 15:26:23 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 10:06:35AM +0000, David Madore wrote:
> On Wed, Sep 06, 2006 at 12:27:50AM +0000, Casey Schaufler wrote:
> > The current work in progress to support
> > capability set on files will address this
> > longstanding issue.
> 
> It seems to me that the issues of the capability inheritance semantics
> and the capability filesystem support are quite orthogonal.  My patch
> provides the first, and will quite happily live with a patch such as
> <URL: http://lwn.net/Articles/142507/ > providing filesystem support.
> 
> Even in the absence of filesystem support, there is no reason for
> capabilities not to be inheritable: this is what my patch addresses.
> Of course, it is even more interesting in the presence of filesystem
> support.  (I could provide a combined patch that would do both, with
> xattrs, as a proof of concept.)

Followup on this: maybe you were referring to the patch in <URL:
http://groups.google.com/group/fa.linux.kernel/msg/61d191383c8b19f9
 > (= <URL: http://lkml.org/lkml/2006/7/29/221 >), by Serge E. Hallyn,
which adds filesystem support for capabilities.  I haven't actually
checked in detail, but reading throught it, it appears to be quite
compatible with my own patch (one merely needs to do something about
the new bunch of capabilities I've introduced, but it should be easy
to hack something which makes sure no programs are surprised or
broken).  I'll try to come up with a combined patch soon, which will
add both the inheritability support I suggest *and* filesystem
support.

I emphasize that the filesystem support patch described above, alone,
will *not* solve the inheritability problem (as my patch does), since
unmarked executables continue to inherit no caps at all.  With my
patch, they behave as though they had a full inheritable set,
something which is required if we want to make something useful of
capabilities on non-caps-aware programs.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
