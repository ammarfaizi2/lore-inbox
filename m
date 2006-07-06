Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWGFSjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWGFSjl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWGFSjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:39:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21198 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750754AbWGFSjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:39:40 -0400
Date: Thu, 6 Jul 2006 11:39:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, bernds_cb1@t-online.de,
       sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] FRV: Fix FRV arch compile errors [try #3]
Message-Id: <20060706113922.ac32eff3.akpm@osdl.org>
In-Reply-To: <25855.1152210303@warthog.cambridge.redhat.com>
References: <20060706103134.197c8679.akpm@osdl.org>
	<20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com>
	<20060706124721.7098.50514.stgit@warthog.cambridge.redhat.com>
	<25855.1152210303@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2006 19:25:03 +0100
David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > - The __init-style tags on declarations don't actually do anything and
> >   the compiler doesn't check for consistency with the definition - it's
> >   best to just omit it from the declaration.
> 
> Well, you're wrong.  They *do* do something.  They stop the compiler using the
> register-relative addressing reserved for small data.  If this isn't in there,
> then the linker will spit out a relocation error.

Sigh.  So if we get this wrong (and we have, and we shall) then the error
gets silently accepted by the toolchain until someone comes along and tries
to link it on FVR.

Is there anything we can do about that?  Mangling the names with some macro
isn't attractive.  Teach sparse about it?  Dunno.

Right now we're showing a grand total of two identifiers tagged with
__initdata in all of include/.  Why isn't FRV blowing up all over the
place?  Is there something about nr_kernel_pages which made us get unlucky?
