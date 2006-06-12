Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751870AbWFLLIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbWFLLIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 07:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWFLLII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 07:08:08 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:48841 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751863AbWFLLIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 07:08:06 -0400
Date: Mon, 12 Jun 2006 14:08:01 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Ingo Molnar <mingo@elte.hu>
cc: Catalin Marinas <catalin.marinas@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
In-Reply-To: <20060612105345.GA8418@elte.hu>
Message-ID: <Pine.LNX.4.58.0606121404080.7129@sbz-30.cs.Helsinki.FI>
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
 <20060611112156.8641.94787.stgit@localhost.localdomain>
 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
 <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI> <20060612105345.GA8418@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Mon, 12 Jun 2006, Ingo Molnar wrote:
> While it's always good to reduce the amount of false positives, i dont 
> think it's unacceptable for inclusion right now. A few dozen annotations 
> out of 7000+ allocation call sites isnt a big maintainance problem - and 
> the benefits of automatic leak-checking are really huge.

Did you look at the call sites?  It seems clear that kmemleak doesn't 
support existing kernel coding style yet (see below) which means we're not 
covering all false positives.

On Mon, 12 Jun 2006, Ingo Molnar wrote:
> What i'd like to see though are clear explanations about why an 
> allocation is not considered a leak, in terms of comments added to the 
> code. That will also help us reduce the number of annotations later on.

I found at least two unacceptable false positive classes:

  - arch/i386/kernel/setup.c:
    False positive because res pointer is stored in a global instance of
    struct resource.

  - drivers/base/platform.c and fs/ext3/dir.c:
    False positive because we allocate memory for struct + some extra
    stuff.

At least the latter can be fixed as outlined by Catalin in another mail.

					Pekka
