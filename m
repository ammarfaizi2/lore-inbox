Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314206AbSDVTd5>; Mon, 22 Apr 2002 15:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSDVTd5>; Mon, 22 Apr 2002 15:33:57 -0400
Received: from fungus.teststation.com ([212.32.186.211]:47880 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S314206AbSDVTd4>; Mon, 22 Apr 2002 15:33:56 -0400
Date: Mon, 22 Apr 2002 21:33:12 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: "Ivan G." <ivangurdiev@yahoo.com>
cc: Jeff Garzik <garzik@havoc.gtf.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Via-rhine minor issues
In-Reply-To: <02042117254803.01262@cobra.linux>
Message-ID: <Pine.LNX.4.33.0204222056480.9063-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Apr 2002, Ivan G. wrote:

> As for the Interrupts:
> Actually, RxNoBuf is handled by calling via_rhine_rx 
> but not enabled when setting interrupt mask. My patch will fix that.
> 
> However, RxOverflow is never handled at all and neither is RxEarly.
> Nor are they enabled when setting interrupt mask (patch enables).
> 
> How should RxOverflow be handled?

The public docs don't say.

You should probably add them to the list of reasons to call
via_rhine_error, and let them be caught by the "wicked" error rule. A
reason to use a term that doesn't try to be specific is that we don't
really know what is causing the event.


Before your patch IntrTxUnderrun would raise the tx threshold AND issue a
CmdTxDemand. After it will only do the first. Do you know that this is an
improvement?

Does merging this error handling change into the main kernel really help
you test other things for your timeout problem? Can't you just include
this bit in your other work?

/Urban

