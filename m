Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWHBQ5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWHBQ5o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWHBQ5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:57:44 -0400
Received: from iona.labri.fr ([147.210.8.143]:6834 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1751250AbWHBQ5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:57:43 -0400
Date: Wed, 2 Aug 2006 18:57:42 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix initialization of runqueues
Message-ID: <20060802165742.GI4460@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20060802122743.GF4460@implementation.labri.fr> <20060802152419.GA31970@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060802152419.GA31970@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar, le Wed 02 Aug 2006 17:24:19 +0200, a écrit :
> 
> * Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> 
> > Hi,
> > 
> > There's an odd thing about the nr_active field in arrays of 
> > runqueue_t: it is actually never initialized to 0!...  This doesn't 
> > yet trigger a bug probably because the way runqueues are allocated 
> > make it so that it is already initialized to 0, but that's not a safe 
> > way.  Here is a patch:
> 
> we do rely on zero initialization of bss (and percpu) data in a number 
> of places.

The rest of runqueue initialization doesn't rely on that, and as
a result people might think that it is safe to allocate runqueues
dynamically.

Samuel
