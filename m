Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265177AbUELTYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbUELTYV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265176AbUELTYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:24:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12258 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265193AbUELTLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 15:11:03 -0400
Date: Wed, 12 May 2004 12:10:13 -0700
From: "David S. Miller" <davem@redhat.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suze.cz
Subject: Re: Why pass pt_regs throughout the input system?
Message-Id: <20040512121013.0b5f3d63.davem@redhat.com>
In-Reply-To: <20040512185026.28373.qmail@web80508.mail.yahoo.com>
References: <20040512185026.28373.qmail@web80508.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004 11:50:26 -0700 (PDT)
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> As far as multiple keyboards issue going - SysRq is a debug tool and
> I relly do not see you hitting SysRq on the two keyboards at the very
> same time to mess up the call traces.

Maybe to get two backtraces on two different cpus?
Be creative :-)

> Anyway, my "problem" is the following: SysRq register dump and call
> trace require keyboard.c event handler to be caled from hard interrupt
> context which is not always feasible.

USB handles this fine, and I seem to remember it does use tasklets.
You can save the pt_regs value at hardware interrupt and pass that
in during the tasklet run perhaps?
