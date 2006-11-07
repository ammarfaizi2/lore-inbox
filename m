Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752906AbWKGPLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbWKGPLZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753961AbWKGPLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:11:25 -0500
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:26294 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1752906AbWKGPLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:11:24 -0500
Date: Tue, 7 Nov 2006 15:11:29 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Paulo Marques <pmarques@grupopie.com>
cc: Rik Bobbaers <Rik.Bobbaers@cc.kuleuven.be>, linux-kernel@vger.kernel.org,
       linux-mm@vger.kernel.org
Subject: Re: very small code cleanup
In-Reply-To: <45509B97.2080104@grupopie.com>
Message-ID: <Pine.LNX.4.64.0611071505040.6764@blonde.wat.veritas.com>
References: <4550986C.8020802@cc.kuleuven.be> <45509B97.2080104@grupopie.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Nov 2006 15:11:11.0868 (UTC) FILETIME=[F5F0C3C0:01C7027E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006, Paulo Marques wrote:
> Rik Bobbaers wrote:
> > 
> > in mm/mlock.c , mm is defined as vma->vm_mm, why not use that one for the
> > decrement of pages?
> 
> Because vma can change here:
> 
> 	if (*prev) {
> 		vma = *prev;
> 		goto success;
> 	}

That's a good piece of cautious observation ...

> 
> and then mm won't be the same as vma->vm_mm..

... but it would be a bug if *prev's vm_mm were different from mm
and from the original vma->vm_mm: Rik's patch looks sensible to me.

Hugh
