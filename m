Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272002AbTHNAeZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 20:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272008AbTHNAeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 20:34:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7417 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S272002AbTHNAeY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 20:34:24 -0400
Subject: Re: [PATCH] cryptoapi: Fix sleeping
From: Robert Love <rml@tech9.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matt Mackall <mpm@selenic.com>, James Morris <jmorris@intercode.com.au>,
       "David S. Miller" <davem@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F3AD5F1.8000901@pobox.com>
References: <20030813233957.GE325@waste.org>  <3F3AD5F1.8000901@pobox.com>
Content-Type: text/plain
Message-Id: <1060821251.4709.449.camel@lettuce>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Wed, 13 Aug 2003 17:34:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-13 at 17:21, Jeff Garzik wrote:

> Do you really want to schedule inside preempt_disable() ?

in_atomic() includes a check for preempt_disable() ... that is actually
all it checks (the preempt_count).  So this fix prevents that.

This patch is interesting, though, because if right now we are
scheduling in the middle of per-CPU code there is a bug (regardless of
kernel preemption -- and with kernel preemption off, the in_atomic()
check might return false even though the code is accessing per-processor
data).

So I think what we really want is to just never call this crypto_yield()
thing when in any sort of critical section, which includes any
per-processor data.

	Robert Love


