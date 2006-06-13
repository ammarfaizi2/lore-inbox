Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbWFMG7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWFMG7y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 02:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932930AbWFMG7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 02:59:54 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:33123 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932552AbWFMG7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 02:59:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jul6Ng1ACpRpEUEbU4ej2kFMsX9VApehpN4NZhieWLRIoMnGhUTzxLr0rkmnLBCzC+2dOqDc0P6FKx3oPpmi/TOTiT+x9SUYttnPUWQLlndIbAFTBeBzW5/FzhsmF3gFJ6CnaqxoPoEQ9dW/MPDt1sk60tQl5+RiaNzbtzr0hbc=
Message-ID: <b0943d9e0606122359q6ffabdbdqada9a6c79642cf2a@mail.gmail.com>
Date: Tue, 13 Jun 2006 07:59:52 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0606130850430.15861@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
	 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
	 <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
	 <20060612105345.GA8418@elte.hu>
	 <b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com>
	 <20060612192227.GA5497@elte.hu>
	 <Pine.LNX.4.58.0606130850430.15861@sbz-30.cs.Helsinki.FI>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/06, Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> Hi Ingo,
>
> On Mon, 12 Jun 2006, Ingo Molnar wrote:
> > i dont know - i feel uneasy about the 'any pointer' method - it has a
> > high potential for false negatives, especially for structures that
> > contain strings (or other random data), etc.
>
> Is that a problem in practice?  Structures that contain data are usually
> allocated from the slab.  There needs to be a link to that struct from the
> gc roots to get a false negative.  Or am I missing something here?

The gc roots are the data and bss sections (and maybe task kernel
stacks) and all the slab-allocated blocks are scanned if a link to
them is found from the roots (and all of them are usually scanned). If
no link is found, they would be reported as memory leaks (and not
scanned). You can't really avoid the scanning of allocated blocks
since they may contain pointers to other blocks.

-- 
Catalin
