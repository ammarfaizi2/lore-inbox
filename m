Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbTLSPDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 10:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTLSPDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 10:03:55 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:864 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263228AbTLSPDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 10:03:53 -0500
Date: Fri, 19 Dec 2003 10:01:43 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Kallol Biswas <kbiswas@neoscale.com>, <linux-kernel@vger.kernel.org>,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
In-Reply-To: <Pine.LNX.4.58.0312031600460.2055@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0312190959440.11948-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003, Linus Torvalds wrote:

> And that in turn causes problems. You get all kinds of interesting
> deadlock schenarios when write-out requires more memory in order to
> succeed.

I suspect this should be fixable with just a simple mempool.

Opportunistic allocation of encrypt-and-IO buffers to keep
performance decent when there's lots of memory available,
fallback to the mempool when free memory is low.

In real emergencies the IO completion code could probably
free the encrypt-and-IO buffer into the mempool.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

