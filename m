Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965294AbWHOIaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965294AbWHOIaE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 04:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbWHOIaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 04:30:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8068 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965294AbWHOIaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 04:30:00 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <p734pwea07b.fsf@verdi.suse.de> 
References: <p734pwea07b.fsf@verdi.suse.de>  <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com> <20060814211507.27190.61876.stgit@warthog.cambridge.redhat.com> 
To: Andi Kleen <ak@suse.de>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org#
Subject: Re: [RHEL5 PATCH 1/4] Provide fallback full 64-bit divide/modulus ops for gcc 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 15 Aug 2006 09:29:57 +0100
Message-ID: <7510.1155630597@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:

> At least Linus' traditional argument against this is that it's better
> to open code these (do_div) so that it's clear to the coder that they
> are really costly.

do_div() is not a full replacement for __udivdi3(), __umoddi3() or
__udivmoddi4(), though I suspect we don't need divisor >= 2^32 anywhere atm.

There are places where the compiler emits these that aren't entirely obvious,
one of which IIRC is in ext2 inode allocation.

David
