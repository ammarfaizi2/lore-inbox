Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWCCQw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWCCQw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 11:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWCCQw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 11:52:56 -0500
Received: from mail.fieldses.org ([66.93.2.214]:29872 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932101AbWCCQwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 11:52:55 -0500
Date: Fri, 3 Mar 2006 11:52:51 -0500
To: David Howells <dhowells@redhat.com>
Cc: Sam Vilain <sam@vilain.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [PATCH 3/5] NFS: Abstract out namespace initialisation [try #2]]
Message-ID: <20060303165251.GE32552@fieldses.org>
References: <44074CFD.7050708@vilain.net> <20060302084448.GA21902@infradead.org> <440613FF.4040807@vilain.net> <3254.1141299348@warthog.cambridge.redhat.com> <5923.1141333943@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5923.1141333943@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.11+cvs20060126
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 09:12:23PM +0000, David Howells wrote:
> No. It has to be permissable to make a series of patches that depend one upon
> another for at least three reasons:
> 
>  (1) Patches can be unmanageably large in one lump, so splitting them up is a
>      sensible option, even through the individual patches won't work or even
>      compile independently.

That breaks git-bisect.

>  (2) It may make sense to place linked changes to two logically separate units
>      in two separate patches, for instance I'm changing the core kernel to add
>      an extra argument to get_sb() and the get_sb_*() convenience functions in
>      one patch and then supplying another patch to change all the filesystems.
> 
>      This makes it much easier for a reviewer to see what's going on. They know
>      the patches are interdependent, but they can see the main core of the
>      changes separated out from the massively repetative but basically less
>      interesting changes that are a side effect of the main change.

It's also much easier to read a series of patches if each patch depends
only on the previous patches.  Then if I want to verify that they don't
break anything, I just need to read them through in order and verify
that each one is correct.

If earlier patches depend on later patches, then I may not be able to
verify correctness until I've read and understand the whole series,
which defeats somewhat the purpose of splitting up the patches.  Though
the above example wouldn't really be a problem.

And of course it seems rather silly to complain about splitting out a
function before adding the new caller.

--b.
