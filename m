Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbUJaVg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUJaVg3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbUJaVej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:34:39 -0500
Received: from canuck.infradead.org ([205.233.218.70]:15880 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261469AbUJaVdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:33:52 -0500
Subject: Re: unit-at-a-time...
From: Arjan van de Ven <arjan@infradead.org>
To: Roland Dreier <roland@topspin.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       pluto@pld-linux.org
In-Reply-To: <52wtx6vhbk.fsf@topspin.com>
References: <200410311541.i9VFf0ah023857@harpo.it.uu.se>
	 <52wtx6vhbk.fsf@topspin.com>
Content-Type: text/plain
Message-Id: <1099258421.14342.16.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sun, 31 Oct 2004 22:33:41 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-31 at 11:05 -0800, Roland Dreier wrote:
> By the way, does anyone know if Richard Henderson's work in gcc 4.0
> (http://gcc.gnu.org/ml/gcc-patches/2004-09/msg00333.html) on laying
> out stack variables means that -funit-at-a-time will be safe to use
> again for the kernel?

unfortunately that's only half the task. It takes care of explicit
variables in inlines, but not about spilled variables, which is the
problem on x86 due to the lack of general purpose registers..
(and which is why x86-64 can use unit-at-a-time just fine)

