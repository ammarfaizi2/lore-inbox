Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWCCQqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWCCQqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 11:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWCCQqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 11:46:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20666 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932321AbWCCQqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 11:46:07 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <32518.1141401780@warthog.cambridge.redhat.com> 
References: <32518.1141401780@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, jblunck@suse.de,
       bcrl@linux.intel.com, matthew@wil.cx, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Memory barriers and spin_unlock safety 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 03 Mar 2006 16:45:46 +0000
Message-ID: <1146.1141404346@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> 	WRITE mtx
> 	--> implies SFENCE

Actually, I'm not sure this is true. The AMD64 Instruction Manual's writeup of
SFENCE implies that writes can be reordered, which sort of contradicts what
the AMD64 System Programming Manual says.

If this isn't true, then x86_64 at least should do MFENCE before the store in
spin_unlock() or change the store to be LOCK'ed. The same may also apply for
Pentium3+ class CPUs with the i386 arch.

David
