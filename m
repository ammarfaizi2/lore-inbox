Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVKWTXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVKWTXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVKWTXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:23:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21728 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932219AbVKWTXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:23:51 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0511231109040.13959@g5.osdl.org> 
References: <Pine.LNX.4.64.0511231109040.13959@g5.osdl.org>  <dhowells1132772387@warthog.cambridge.redhat.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, dalomar@serrasold.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 1/3] NOMMU: Provide shared-writable mmap support on ramfs 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 23 Nov 2005 19:23:29 +0000
Message-ID: <376.1132773809@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> >  (3) Not permitting a file to be shrunk if it would truncate any shared
> >      mappings (private mappings are copied).
> 
> Why?
> 
> Truncate is _supposed_ to get rid of any shared mmap stuff. 

Yeah... but under _NOMMU_ conditions, it can't. There's no MMU around to
enforce the fact that the mapping has been shrunk.

Imagine two processes: one creates a shmem file and makes it a certain size;
both processes mmap it; then one of the processes attempts to shrink it. The
process that shrank it knows it has been shortened and that the memory has
been release, but the second process may not. Splat.

David
