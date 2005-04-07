Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVDGKPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVDGKPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 06:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVDGKPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 06:15:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31386 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262417AbVDGKOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 06:14:51 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0504070210430.24723@goblin.wat.veritas.com> 
References: <Pine.LNX.4.61.0504070210430.24723@goblin.wat.veritas.com>  <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com> 
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] freepgt2: sys_mincore ignore FIRST_USER_PGD_NR 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Thu, 07 Apr 2005 11:14:24 +0100
Message-ID: <19283.1112868864@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:

> 
> Remove use of FIRST_USER_PGD_NR from sys_mincore: it's inconsistent (no
> other syscall refers to it), unnecessary (sys_mincore loops over vmas
> further down) and incorrect (misses user addresses in ARM's first pgd).

You should make it use FIRST_USER_ADDRESS instead. This check allows NULL
pointers and suchlike to be weeded out before having to take the semaphore.

Also, just because no other syscall refers to such a value doesn't mean that
this one shouldn't and that others shouldn't.

David
