Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWAZICd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWAZICd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 03:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWAZICd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 03:02:33 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:13995 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S932106AbWAZICd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 03:02:33 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: 7eggert@gmx.de
Subject: Re: [PATCH] bttv: correct bttv_risc_packed buffer size
Date: Thu, 26 Jan 2006 09:02:29 +0100
User-Agent: KMail/1.9.1
Cc: mchehab@brturbo.com.br, Linux Kernel list <linux-kernel@vger.kernel.org>
References: <5yQ4M-7PJ-11@gated-at.bofh.it> <E1F1pWq-0001d1-JH@be1.lrz>
In-Reply-To: <E1F1pWq-0001d1-JH@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601260902.30382.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bodo,

> > This patch fixes the strange crashes I was seeing after using
> > my bttv card to watch television.  They were caused by a
> > buffer overflow in bttv_risc_packed.
> 
> <snip>
> 
> Would these errors e.g. cause a corruption of exactly four bytes at the start
> of random pages?

I don't think so.  It should cause either no corruption or at least 8 bytes worth
(it does pairs of 4 byte writes).  What you might see is an Oops when it tries to
write the first 4 bytes at the start of a page, because of a page fault, but then
the write doesn't happen and there is no corruption...

Best wishes,

Duncan.
