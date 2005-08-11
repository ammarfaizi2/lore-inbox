Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVHKR54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVHKR54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVHKR54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:57:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48839 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932323AbVHKR5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:57:55 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050811172312.GA10202@lst.de> 
References: <20050811172312.GA10202@lst.de> 
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] kill odd mm context pinning hack in frv 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Thu, 11 Aug 2005 18:57:43 +0100
Message-ID: <6466.1123783063@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> David, is that more than a debugging aid?   I'm trying to get rid of
> tasklist_lock users and this one looks really suspicios..

Yes. The FR451 CPU (the only one with an MMU at the moment) has accounting and
profiling aids that are enabled by the context number set in the CXNR
register. This context number also selectively enables TLB entries on a per-mm
context basis.

So to profile a process you pin a context number to that process, and then the
profiling h/w is only active for that process.

David
