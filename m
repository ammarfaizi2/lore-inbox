Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277387AbRJEOGr>; Fri, 5 Oct 2001 10:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277386AbRJEOGj>; Fri, 5 Oct 2001 10:06:39 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:35757 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S277364AbRJEOG3>;
	Fri, 5 Oct 2001 10:06:29 -0400
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linux Bigot <linuxopinion@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
In-Reply-To: <200110032244.f93MiI103485@localhost.localdomain>
From: Jes Sorensen <jes@sunsite.dk>
Date: 05 Oct 2001 16:06:31 +0200
In-Reply-To: James Bottomley's message of "Wed, 03 Oct 2001 17:44:18 -0500"
Message-ID: <d3n136tc48.fsf@lxplus014.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "James" == James Bottomley <James.Bottomley@HansenPartnership.com> writes:

Linux> All programmers I am relatively new to linux kernel. Please
Linux> advise what is the safe way to get the original virtaul address
Linux> from dma address e.g.,

>> You have to store the address you pass to pci_map_single()
>> somewhere in your data structures together with the dma address.

James> Yes, but speaking as someone who had to use a large hammer to
James> convert his driver from bus_to_virt et al., it does seem rather
James> hard not to have the equivalent for the new pci_dma paradigm.
James> It does present an obstacle persuading people to convert
James> drivers, particularly if the hardware is going to present a
James> linked list of addresses (as SCSI hardware often does).

Because as DaveM pointed out, some hardware can't do it, and as I said
earlier, it's a lot cheaper and easier for driver writers to just
store the extra pointer in their data structures than it is to
implement a database to maintain it.

Remember you often need this address in the hot path (say TX interrupt
handler) so you don't want to introduce any unnecessary function calls.

Jes
