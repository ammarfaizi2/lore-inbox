Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbUJ0BOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbUJ0BOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 21:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUJ0BOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 21:14:16 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:490
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261520AbUJ0BON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 21:14:13 -0400
Date: Tue, 26 Oct 2004 18:06:22 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Input: sunkbd concern
Message-Id: <20041026180622.14fc6268.davem@davemloft.net>
In-Reply-To: <200410221833.04057.dtor_core@ameritech.net>
References: <200410221833.04057.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 18:33:04 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> I have been looking at sunkbd.c and it seems that it attaches not only to
> ports that speak SUNKBD protocol but also to ports that do not specify any
> protocol:
> 
> 	if ((serio->type & SERIO_PROTO) && (serio->type & SERIO_PROTO) != SERIO_SUNKBD)
> 		return;
> 
> Was that an oversight or it was done intentionally?

I believe it is intentional.

If SERIO_PROTO bits are all clear, this is supposed to have
a special meaning in that any keyboard driver can claim
the serio line.

So if it's the "wildcard" zero value, or specifically SERIO_SUNKBD,
we'll attach to it.
