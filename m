Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVBWLnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVBWLnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 06:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVBWLnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 06:43:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15827 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261464AbVBWLm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 06:42:59 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050222134010.4c286e64.akpm@osdl.org> 
References: <20050222134010.4c286e64.akpm@osdl.org>  <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org> 
To: Andrew Morton <akpm@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, olof@austin.ibm.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 23 Feb 2005 11:42:47 +0000
Message-ID: <5410.1109158967@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> wrt this down_read/down_write/down_read deadlock: iirc, the reason why
> down_write() takes precedence over down_read() is to avoid the permanent
> writer starvation which would occur if there is heavy down_read() traffic.

down_write() doesn't actually take precedence over down_read() as such. The
rwsems try to implement a strict FIFO queue (the fairness thing).

David
