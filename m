Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbWCIAfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbWCIAfg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbWCIAfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:35:36 -0500
Received: from ozlabs.org ([203.10.76.45]:15772 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932655AbWCIAfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:35:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.30789.214209.462657@cargo.ozlabs.ibm.com>
Date: Thu, 9 Mar 2006 11:35:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@redhat.com>,
       akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2] 
In-Reply-To: <19984.1141846302@warthog.cambridge.redhat.com>
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
	<20060308184500.GA17716@devserv.devel.redhat.com>
	<20060308173605.GB13063@devserv.devel.redhat.com>
	<20060308145506.GA5095@devserv.devel.redhat.com>
	<31492.1141753245@warthog.cambridge.redhat.com>
	<29826.1141828678@warthog.cambridge.redhat.com>
	<9834.1141837491@warthog.cambridge.redhat.com>
	<11922.1141842907@warthog.cambridge.redhat.com>
	<14275.1141844922@warthog.cambridge.redhat.com>
	<19984.1141846302@warthog.cambridge.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells writes:

> On NUMA PowerPC, should mmiowb() be a SYNC or an EIEIO instruction then? Those
> do inter-component synchronisation.

We actually have quite heavy synchronization in read*/write* on PPC,
and mmiowb can safely be a no-op.  It would be nice to be able to have
lighter-weight synchronization, but I'm sure we would see lots of
subtle driver bugs cropping up if we did.  write* do a full memory
barrier (sync) after the store, and read* explicitly wait for the data
to come back before.

If you ask me, the need for mmiowb on some platforms merely shows that
those platforms' implementations of spinlocks and read*/write* are
buggy...

Paul.
