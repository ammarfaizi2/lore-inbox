Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWCBVMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWCBVMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWCBVMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:12:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39352 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932550AbWCBVMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:12:31 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <44074CFD.7050708@vilain.net> 
References: <44074CFD.7050708@vilain.net>  <20060302084448.GA21902@infradead.org> <440613FF.4040807@vilain.net> <3254.1141299348@warthog.cambridge.redhat.com> 
To: Sam Vilain <sam@vilain.net>
Cc: David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [PATCH 3/5] NFS: Abstract out namespace initialisation [try #2]] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 02 Mar 2006 21:12:23 +0000
Message-ID: <5923.1141333943@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain <sam@vilain.net> wrote:

> AIUI, each patch must stand on its own in every regard.  I guess you 
> need to make it inline in the later patch - or not at all given the 
> marginal speed difference vs. core size increase.

No. It has to be permissable to make a series of patches that depend one upon
another for at least three reasons:

 (1) Patches can be unmanageably large in one lump, so splitting them up is a
     sensible option, even through the individual patches won't work or even
     compile independently.

 (2) It may make sense to place linked changes to two logically separate units
     in two separate patches, for instance I'm changing the core kernel to add
     an extra argument to get_sb() and the get_sb_*() convenience functions in
     one patch and then supplying another patch to change all the filesystems.

     This makes it much easier for a reviewer to see what's going on. They know
     the patches are interdependent, but they can see the main core of the
     changes separated out from the massively repetative but basically less
     interesting changes that are a side effect of the main change.

 (3) A series of patches may form a set of logical steps (for instance my
     patches 1-2 are the first step and patches 3-5 the second). It may be (and
     it is in my case) that each step will build and run, provided all the
     previous steps are applied; but that a step won't build or run without the
     preceding steps.

Remember: one of the main reasons for splitting patches is to make it easier
for other people to appreciate just how sublimely terrific your work is:-)

David
