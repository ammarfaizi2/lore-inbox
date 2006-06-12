Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWFLILK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWFLILK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWFLILK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:11:10 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:32130 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750783AbWFLILI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:11:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SuAlY1AKe7yHmOJzLRM1p//iS/LKjyBdkIubRO1fDs0UeApBbJanpoNfKfP8wPbL2BldSE3JOje/WT7tF3Fcn2DfTXyMPXmYkDoqa0oZTEG10SRzkA1P8EU5WggQGPKoumFk+ClZFgtoDp/nJAPdkEFx2L3NsSKVa8w8fQO2Y94=
Message-ID: <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
Date: Mon, 12 Jun 2006 09:11:07 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> Hi Catalin,
>
> On 6/11/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > There are allocations for which the main pointer cannot be found but they
> > are not memory leaks. This patch fixes some of them.
>
> Can we fix this by looking for pointers to anywhere in the allocated
> memory block instead of just looking for the start?

I thought about this as well (I think that's how Valgrind works) but
it would increase the chances of missing real leaks. It currently
looks for the start of the block and a few locations inside the block
(those from which the main pointer is computed using the
container_of() macro).

I need to do some tests to see how it works but I won't be able to use
the radix_tree (as storing each location in the block would lead to a
huge tree).

-- 
Catalin
