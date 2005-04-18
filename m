Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVDRLas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVDRLas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 07:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVDRLas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 07:30:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43220 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262039AbVDRLam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 07:30:42 -0400
Date: Mon, 18 Apr 2005 07:30:32 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Chris Wedgwood <cw@f00f.org>
cc: Paul Jackson <pj@sgi.com>, ikebe.takashi@lab.ntt.co.jp,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
In-Reply-To: <20050418092505.GA2206@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com>
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org>
 <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org>
 <42636285.9060405@lab.ntt.co.jp> <20050418075635.GB644@taniwha.stupidest.org>
 <20050418021609.07f6ec16.pj@sgi.com> <20050418092505.GA2206@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2005, Chris Wedgwood wrote:
> On Mon, Apr 18, 2005 at 02:16:09AM -0700, Paul Jackson wrote:
> 
> > The call switching folks have been doing live patching at least
> > since I worked on it, over 25 years ago.  This is not just
> > marketing.
> 
> That still doesn't explain *why* live patching is needed.

I suspect it was needed in the past, on embedded computers so
small they could only run one program at a time.

I see no reason why changing programs on the fly couldn't be
done nicer with SHM segments today - just start up the new
program in parallel with the old one, have it attach to the
SHM region and handshake with the old program to take over
operations.

At that point the old program can let go of file descriptors
(eg. those to devices), yield the CPU and the new program can
open those file descriptors.  The SHM area contains all of the
state information needed, so the program can continue running
like it always would.

This may well be lower latency than live patching, and probably
lower complexity/risk too...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
