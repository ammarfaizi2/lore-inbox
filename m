Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270810AbTHNQ3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271030AbTHNQ3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:29:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5107 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S270810AbTHNQ3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:29:36 -0400
Subject: Re: [PATCH] cryptoapi: Fix sleeping
From: Robert Love <rml@tech9.net>
To: Matt Mackall <mpm@selenic.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, James Morris <jmorris@intercode.com.au>,
       "David S. Miller" <davem@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030814015820.GH325@waste.org>
References: <20030813233957.GE325@waste.org> <3F3AD5F1.8000901@pobox.com>
	 <1060821251.4709.449.camel@lettuce>  <20030814015820.GH325@waste.org>
Content-Type: text/plain
Message-Id: <1060878560.4709.474.camel@lettuce>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Thu, 14 Aug 2003 09:29:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-13 at 18:58, Matt Mackall wrote:

> This is part of cryptoapi and given the large chunks of work you could
> potentially hand to it, it's probably a good idea for it to work this
> way. You hand it a long list of sg segments, it does the transform and
> reschedules if it thinks it's safe. But its test of when it was safe
> was not complete.

Right.  My concern is that you said sometimes it is called when
preemption is disabled.

I assume because it is accessing per-processor data.

It is illegal to reschedule -- regardless of kernel preemption -- while
in the middle of a critical section accessing per-processor data.

	Robert Love


