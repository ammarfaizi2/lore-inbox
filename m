Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVIENrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVIENrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 09:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVIENrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 09:47:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14250 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932278AbVIENrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 09:47:39 -0400
Date: Mon, 5 Sep 2005 09:47:30 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/2] fix for -mm add-sem_is_read-write_locked.patch 
In-Reply-To: <26510.1125913723@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.63.0509050946190.4369@cuia.boston.redhat.com>
References: <Pine.LNX.4.63.0509031134240.567@cuia.boston.redhat.com> 
 <26510.1125913723@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2005, David Howells wrote:

> | Index: linux-2.6.13/include/asm-ppc64/rwsem.h

> This uses the function wrong name. And:

I really shouldn't make patches like this in the morning on weekends, 
when I'm still sleepy.  Well, here is the trivial fix...

Signed-off-by: Rik van Riel <riel@redhat.com>

Index: linux-2.6.13/include/asm-ppc64/rwsem.h
===================================================================
--- linux-2.6.13.orig/include/asm-ppc64/rwsem.h
+++ linux-2.6.13/include/asm-ppc64/rwsem.h
@@ -163,7 +163,7 @@ static inline int rwsem_atomic_update(in
 	return atomic_add_return(delta, (atomic_t *)(&sem->count));
 }
 
-static inline int sem_is_read_locked(struct rw_semaphore *sem)
+static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
 	return (sem->count != 0);
 }
