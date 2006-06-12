Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWFLInM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWFLInM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWFLInM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:43:12 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:7967 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751030AbWFLInK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:43:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B1XGDLAYPSASmDact0MOsXXbapc4U2Jw/RnKsqWxLR5V2Y2tpIK2ZGfsgJM6ibb8ODLcRw/i9K7nW5n8tSOMgVckOGGHQgIr9MgfXujN9BQ5WZkEUw5GyFa1yD6xAWeJJbgRia7+o3CY74AobXIJ6wMqPFUKjfV2CItCwFKRVSo=
Message-ID: <b0943d9e0606120143w47a37f59j4325ff97c74f663@mail.gmail.com>
Date: Mon, 12 Jun 2006 09:43:10 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
	 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
	 <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/06, Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> On 12/06/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > > Can we fix this by looking for pointers to anywhere in the allocated
> > > memory block instead of just looking for the start?
>
> On Mon, 12 Jun 2006, Catalin Marinas wrote:
> > I thought about this as well (I think that's how Valgrind works) but
> > it would increase the chances of missing real leaks.
>
> Yeah but that's far better than adding bunch of 'not a leak' annotations
> around the kernel which is very impractical to maintain.  I would like to
> see your leak detector in the kernel so we can finally get rid of all
> those per-subsystem magic allocators.  This patch, however, is
> unacceptable for inclusion IMHO.

My initial hope was that simply tweaking the container_of macro would
be enough to get the inside-block pointers (or, at least, modify some
key places like net/core/dev.c) but it looks like it wasn't and I
introduced the memleak_not_leak() function which had to be added to
some individual drivers as well.

As I said, I'll do some tests first because looking at all the
locations inside a block might make the tool less useful.

-- 
Catalin
