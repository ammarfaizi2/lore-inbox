Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSHBQhD>; Fri, 2 Aug 2002 12:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315513AbSHBQgj>; Fri, 2 Aug 2002 12:36:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:37628 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315525AbSHBQey>; Fri, 2 Aug 2002 12:34:54 -0400
Subject: Re: [PATCH] Toshiba Laptop Support and IRQ Locks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Weber <john.weber@linux.org>
Cc: linux-kernel@vger.kernel.org, jonathan@buzzard.org.uk
In-Reply-To: <3D4AAD53.7010008@linux.org>
References: <3D4AAD53.7010008@linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Aug 2002 18:55:39 +0100
Message-Id: <1028310939.18309.93.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 17:03, John Weber wrote:
> Hi,
> 
> Toshiba laptop support is broken.  Here's my rookie attempt at fixing it.

Looks basically sound. You probably want to use spinlock_irqsave - the
spin locks are less overhead than the reader/writer locks and you don't
really seem to be using it for anything else. I'm assuming we want the
irqsave to block interrupts because the I/O cycles might have to happen
one after another - if not they could be relaxed - perhaps Jonathan
knows ?

