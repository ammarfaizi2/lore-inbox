Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264958AbUFAJZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264958AbUFAJZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 05:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUFAJZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 05:25:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23731 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264958AbUFAJZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 05:25:35 -0400
Date: Tue, 1 Jun 2004 02:24:44 -0700
From: "David S. Miller" <davem@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
Subject: Re: compat syscall args
Message-Id: <20040601022444.4c5264cf.davem@redhat.com>
In-Reply-To: <200406011107.46096.arnd@arndb.de>
References: <20040529122319.49eaafe1.davem@redhat.com>
	<20040601150633.5f708220.sfr@canb.auug.org.au>
	<200406011107.46096.arnd@arndb.de>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2004 11:07:42 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Also, what should be the conversion for positive signed arguments like the
> futex 'op' value? Sign-extension would be the formally correct solution,
> but simply using the zero-extended value (like we do in most places) works
> just as well.

Personally I think it makes more sense to do what sparc64 does
which is:

1) The syscall32 entry code extends each arg in a fixed way.
   Ie. arg0-3 are zero-extended, arg4-5 are sign-extended
   or whatever.  I posted the choices we use on sparc64 just
   the other day.

2) For each syscall where this default set of extensions is
   not correct, little assembler or C stubs are used to correct
   the extensions made by the default code.

It is the most optimal solution.  We only need 13 or so stubs
on sparc64 with the defaults we've choosen.
