Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbUKOPgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbUKOPgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 10:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbUKOPgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 10:36:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:45197 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261625AbUKOPgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 10:36:01 -0500
Date: Mon, 15 Nov 2004 07:35:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH] VM routine fixes 
In-Reply-To: <26123.1100524499@redhat.com>
Message-ID: <Pine.LNX.4.58.0411150733280.2222@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411132105240.12386@ppc970.osdl.org> 
 <20041112023817.247af548.akpm@osdl.org> <20041111143148.76dcaba4.akpm@osdl.org>
 <200411081432.iA8EWfmh023432@warthog.cambridge.redhat.com> <19844.1100255635@redhat.com>
 <20942.1100257558@redhat.com>  <26123.1100524499@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Nov 2004, David Howells wrote:
> 
> So not having an MMU, page tables or PTEs or any requirement for operations
> that act upon them is not enough?

No. It's a matter of abstraction. If you can _abstract_ the thing away, 
that's fine. I don't want more #ifdef's in source code, but you can have a 
totally different file that doesnt' do the things that aren't appropriate 
for non-MMU.

Yes, we've already got #ifdef's in code, but the point is that we don't 
add them unless there is serious _need_. And even then it's a sign of 
trouble. In this case, the sign of trouble is bigger than the need. 
uClinux might as well have a dummy "struct vm_operations", if only to make 
the damn thing look more like real Linux.

		Linus
