Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWIHWtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWIHWtH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWIHWtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:49:07 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:31695 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1751150AbWIHWtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:49:04 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Uses for memory barriers
Date: Sat, 9 Sep 2006 00:49:19 +0200
User-Agent: KMail/1.8
Cc: paulmck@us.ibm.com, David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0609081824190.8280-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0609081824190.8280-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609090049.20416.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 9. September 2006 00:25 schrieb Alan Stern:
> On Fri, 8 Sep 2006, Oliver Neukum wrote:
> 
> > > Again you have misunderstood.  The original code was _not_ incorrect.  I 
> > > was asking: Given the code as stated, would the assertion ever fail?
> > 
> > I claim the right to call code that fails its own assertions incorrect. :-)
> 
> Touche!
> 
> > > The code _was_ correct for my purposes, namely, to illustrate a technical 
> > > point about the behavior of memory barriers.
> > 
> > I would say that the code may fail the assertion purely based
> > on the formal definition of a memory barrier. And do so in a subtle
> > and inobvious way.
> 
> But what _is_ the formal definition of a memory barrier?  I've never seen 
> one that was complete and correct.

I' d say "mb();" is "rmb();wmb();"

and they work so that:

CPU 0

a = TRUE;
wmb();
b = TRUE;

CPU 1

if (b) {
	rmb();
	assert(a);
}

is correct. Possibly that is not a complete definition though.

	Regards
		Oliver
