Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWHRJWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWHRJWA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWHRJWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:22:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64733 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751317AbWHRJV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:21:59 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1155862063.2997.6.camel@raven.themaw.net> 
References: <1155862063.2997.6.camel@raven.themaw.net>  <1155743399.5683.13.camel@localhost> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <5910.1155741329@warthog.cambridge.redhat.com> <13319.1155744959@warthog.cambridge.redhat.com> 
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's list 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 18 Aug 2006 10:21:47 +0100
Message-ID: <1000.1155892907@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> Don't we need to return something like NULL here also?

Shouldn't do.  It should be reasonable to just continue into the rest of the
function - after all, after calling d_drop() we don't have a dentry any
more[*]...

[*] Lack of a dput() not withstanding.

I'm wondering if I actually need to discard the negative dentry I already have
since I then proceed to allocate a new one.

David
