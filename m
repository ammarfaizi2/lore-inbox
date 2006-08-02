Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWHBWzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWHBWzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWHBWzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:55:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23174 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932296AbWHBWzK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:55:10 -0400
Subject: Re: frequent slab corruption (since a long time)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       jbaron@redhat.com
In-Reply-To: <20060802222321.GH3639@redhat.com>
References: <20060802021617.GH22589@redhat.com>
	 <20060801.220538.89280517.davem@davemloft.net>
	 <20060801.223110.56811869.davem@davemloft.net>
	 <20060802222321.GH3639@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Aug 2006 00:14:21 +0100
Message-Id: <1154560462.23655.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-02 am 18:23 -0400, ysgrifennodd Dave Jones:
> None of the code manipulating tty->count seems to be under
> the tty_mutex.  Should it be ?
> Or is this protected through some other means?

Its old lock_kernel() code so its a prime suspect for most offences.

Given the age of the reports it appears that the tty buffering changes
are too new. The ldisc locking changes are a candidate but shouldn't be
doing anything that breaks the kernel lock stuff. Will look tomorrow see
if anything strikes me about that lot.

The tty_mutex primarily protected current->signal.tty (except if you are
using SELinux which has some extremely dubious looking code for tty
handling). Someone ought to review flush_unauthorized_files() although
it doesn't fit this problem.

Alan

