Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUCASYf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 13:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUCASYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 13:24:34 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:17 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261389AbUCASYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 13:24:33 -0500
Date: Mon, 1 Mar 2004 15:23:12 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: Chuck Lever <cel@citi.umich.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Ibm Serveraid Problem with 2.4.25
In-Reply-To: <Pine.BSO.4.33.0403011215410.6255-100000@citi.umich.edu>
Message-ID: <Pine.LNX.4.44.0403011505150.5314-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Mar 2004, Chuck Lever wrote:

> hi marcelo-
> 
> your "fix" will break readahead again for NFS.  with the ">=" as you
> propose, the read ahead code will never be able to read the last page of
> the file as a coalesced read, it will always be a separate 4KB read.
> 
> the problem is not the readahead code, it is the driver code that tries
> to read beyond the end of the device.  my change merely exposed this
> misbehavior.
> 
> so there is a broken assumption somewhere about how the index of the last
> page of a file/device is computed.  i think it is a problem when the file
> ends exactly on a page boundary.
>
> alain, if you don't use the NFS client, marcelo's fix should work just
> fine for you.  but i believe that in general it is incorrect.

Okey, most drivers do no exhibit this problem indeed.

We should try to fix the problematic drivers, then.

If we can't do it easily and in a straightforward manner, I'm afraid we
will have to undo your change because even if the "read end beyond of
device" accesses are harmless (are they really harmless?), they must
fixed.

Agreed?

I'll take a look at them later today, but I'm no expert, so help is very
appreciated.

We know that these have problems:

- Promise ATA
- ips (serveraid)



