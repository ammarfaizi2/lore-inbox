Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265206AbUF1VAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUF1VAE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbUF1VAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:00:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50650 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265206AbUF1U74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:59:56 -0400
Date: Mon, 28 Jun 2004 13:58:21 -0700
From: "David S. Miller" <davem@redhat.com>
To: Scott Wood <scott@timesys.com>
Cc: scott@timesys.com, oliver@neukum.org, zaitcev@redhat.com, greg@kroah.com,
       arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
       mdharm-usb@one-eyed-alien.net, david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-Id: <20040628135821.6b38e377.davem@redhat.com>
In-Reply-To: <20040628204857.GA5321@yoda.timesys>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<200406270631.41102.oliver@neukum.org>
	<20040626233423.7d4c1189.davem@redhat.com>
	<200406271242.22490.oliver@neukum.org>
	<20040627142628.34b60c82.davem@redhat.com>
	<20040628141517.GA4311@yoda.timesys>
	<20040628132531.036281b0.davem@redhat.com>
	<20040628204857.GA5321@yoda.timesys>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004 16:48:57 -0400
Scott Wood <scott@timesys.com> wrote:

> However, what if it were to be run on a machine that can't address
> smaller quantities than 64-bit?  Such a machine sounds silly, but it
> could happen (just as early Alphas couldn't directly load or store
> smaller than 32-bit quantities),

You are still hitting right at the heart of why I think all of
this talk is madness and silly, you're staying in the realm of
"what ifs".

Cross that bridge when we get there and no sooner, ok? :-)

As a side note, even though early Alpha's could not address smaller
than word quantities directly with loads and stores, the structure
layout defined by the Alpha ABIs did not pad such elements inside
of structures.  It simply emitted word sized loads, then extracted
the byte or half-word using shifts and masks.

So even if such a maniac machine as you described were created, it
would likely shift+mask out from 64-bit loads the elements it needed
instead of padding structures uselessly.  Structure padding eats memory
which is why ABI designers avoid it like the plague.

