Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266320AbUANNkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 08:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266327AbUANNkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 08:40:45 -0500
Received: from ms-smtp-02-qfe0.nyroc.rr.com ([24.24.2.56]:24022 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S266320AbUANNkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 08:40:43 -0500
Subject: Re: kmail slowdown on 2.6.* +reiserFS (v3)
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
In-Reply-To: <400544D8.5090005@namesys.com>
References: <200401112109.22027.ciaby@autistici.org>
	 <20040111182739.0686fbee.akpm@osdl.org>
	 <1074086445.32706.1013.camel@tiny.suse.com>  <400544D8.5090005@namesys.com>
Content-Type: text/plain
Message-Id: <1074087727.32704.1018.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 14 Jan 2004 08:42:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-14 at 08:32, Hans Reiser wrote:
> Chris Mason wrote:
> 
> >On Sun, 2004-01-11 at 21:27, Andrew Morton wrote:
> >  
> >
> >>Ciaby <ciaby@autistici.org> wrote:
> >>    
> >>
> >>>I all!
> >>>I've recently upgraded from 2.4 to 2.6 and I've noticed a strange thing:
> >>>on the 2.4 kernel, kmail run decently (i've an old k6-200).
> >>>On the 2.6 kernel, kmail slowdown and take a very long time to read a mailbox.
> >>>I think something changed in the reiserFS during this time...
> >>>I'm not the only experiencing this problem, read this:
> >>>http://kerneltrap.org/node/view/1844
> >>>      
> >>>
> >>A buglet in kmail was tripped up by some optimisations which went into
> >>reiserfs.
> >>
> >>Upgrading kmail should fix it up.  Or mount the reiserfs filesystems with
> >>the `nolargeio=1' mount option.
> >>    
> >>
> >
> >Actually, we've hit other problems with v3 largeio, it can confuse rpm
> >badly.  The real bug is apparently in bdb, the larger io size suggested
> >by the filesystem lead bdb to corrupt its own files.  I spent some time
> >neck deep in the db code but couldn't track the problem down.
> >
> >I seem to remember the XFS folks hitting exactly the same bug.
> >
> >Hans, can I talk you into having v3 export an io size of 4k to userspace
> >again?  Applications that send large ios would still use Oleg's
> >optimized file write paths.
> >
> why is it you don't want to "fix" bdb to lie to itself about the result 
> of statfs?

Because I'm worried that bdb isn't the only app having problems ;-)  And
it's important enough as a legacy app that I don't want to tell everyone
they must upgrade to some hacked bdb version in order for v3 to work
under 2.6.x

-chris


