Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265833AbUEZWB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUEZWB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 18:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265834AbUEZWB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 18:01:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11140 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265833AbUEZWB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 18:01:27 -0400
Date: Wed, 26 May 2004 15:00:40 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: net_device->queue_lock contention on 32-way box
Message-Id: <20040526150040.25b9ec51.davem@redhat.com>
In-Reply-To: <200405262147.i4QLlFF23657@unix-os.sc.intel.com>
References: <20040526135436.657df321.davem@redhat.com>
	<200405262147.i4QLlFF23657@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 14:47:15 -0700
"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:

> Could netif_schedule() take long time to run?

No, it's a series of a few atomic operations.

1) test_and_set_bit()
2) disable cpu interrupts
3) Link list insertion
4) Set a local-cpu flag
5) re-enable cpu interrupts
