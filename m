Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWC1UpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWC1UpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWC1UpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:45:16 -0500
Received: from cantor2.suse.de ([195.135.220.15]:17611 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932196AbWC1UpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:45:14 -0500
From: Andi Kleen <ak@suse.de>
To: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: RFC - Approaches to user-space probes
Date: Tue, 28 Mar 2006 22:44:47 +0200
User-Agent: KMail/1.9.1
Cc: prasanna@in.ibm.com, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <20060327065447.GA25745@in.ibm.com> <20060328145441.GA25465@in.ibm.com> <y0m64lye28w.fsf@ton.toronto.redhat.com>
In-Reply-To: <y0m64lye28w.fsf@ton.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603282244.48900.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 March 2006 22:35, Frank Ch. Eigler wrote:
> Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:
> 
> > [...]
> > If the executable is mmaped shared, then those mappings will get written
> > back to the disk.
> > Writting to the disk is not the requirement for user-space probes, it is
> > just the side effect [...]
> 
> It's pretty clear that writing the dirtied pages to disk is an
> *undesirable* side-effect, and should be eliminated.  (Among many
> other scenarios, imagine a kernel shutting down without all the probes
> being cleanly removed.  Then the executables are irretrievably
> corrupted.)

That's pretty hard unfortunately. There are plenty of operations
that just access the page cache directly for IO 
(like sendfile or mmap or other IO) 

And allocating bounce buffers is tricky because the IO paths
cannot allocate memory reliably without deadlocks (or rather 
it would require mempool and other inefficient measures)

Doing forced COW like ptrace is probably more practical.

-Andi
