Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbVHPBxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbVHPBxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 21:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbVHPBxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 21:53:17 -0400
Received: from smtp.istop.com ([66.11.167.126]:6567 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S965073AbVHPBxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 21:53:16 -0400
From: Daniel Phillips <phillips@arcor.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Tue, 16 Aug 2005 11:53:58 +1000
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, hugh@veritas.com
References: <200508130534.54155.phillips@arcor.de> <3521.1123757360@warthog.cambridge.redhat.com> <8985.1124111717@warthog.cambridge.redhat.com>
In-Reply-To: <8985.1124111717@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508161153.59476.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 August 2005 23:15, David Howells wrote:
> I want to know when a page is going to be modified so that I
> can predict the state of the cache as much as possible. I don't want
> userspace processes corrupting the cache in unrecorded ways.

There are two cases:

  1) Metadata.  If anybody is doing racy writes to metadata pages, it is
     your filesystem, and you have a bug.

  2) Data.  In Linux practice and Posix, racy writes to files have
     undefined semantics, including the possibility that data may end up
     interleaved on a disk block.

You seem to be trying to define (2) as "corruption" and setting out to prevent 
it.  But it is not the responsibility of a filesystem to prevent this, it is 
the responsibility of the application.

Could you please explain why it is not ok to end up with a half-written page 
in your cache, if the client was in fact halfway through writing it when it 
crashed?

Regards,

Daniel
