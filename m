Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUG1Plj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUG1Plj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbUG1Plj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:41:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64483 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267237AbUG1PlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:41:01 -0400
Date: Wed, 28 Jul 2004 08:38:58 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
Message-Id: <20040728083858.654d15ac.davem@redhat.com>
In-Reply-To: <m3acxkighj.fsf@averell.firstfloor.org>
References: <2mN94-3MP-9@gated-at.bofh.it>
	<m3acxkighj.fsf@averell.firstfloor.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004 12:16:40 +0200
Andi Kleen <ak@muc.de> wrote:

> Most architectures can use a generic wrapper for that, together
> with a standard macro that clears all the padding in user space.

They can't be seperate though, I don't want:

	fill_in_stat_bits();
	zero_out_padding_parts();

because that disturbs the ascending store stream which
I'm trying to retain.

What I really want to do on Sparc64 is a special inline
assembly that looks a lot like put_user() but uses one
exception table entry for all the stores into the stat{,64}
structure in userspace.

How would you wrapper look?  Perhaps I'm confused and it
allows what I want to do.
