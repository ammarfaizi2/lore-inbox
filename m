Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269292AbUI3OaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269292AbUI3OaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 10:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269294AbUI3OaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 10:30:20 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:60301 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269292AbUI3OaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 10:30:14 -0400
Subject: Re: [PATCH] overcommit symbolic constants
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: akpm@osdl.org, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040930141905.GA4077@apps.cwi.nl>
References: <UTC200409301341.i8UDfRi02421.aeb@smtp.cwi.nl>
	 <1096548791.19269.5.camel@localhost.localdomain>
	 <20040930141905.GA4077@apps.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096550863.19487.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 30 Sep 2004 14:27:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A few days ago I remarked that 2 is no good when there is no swap.
> OK. So, more modest aim - tighten things only in case there is
> plenty of swap. I like to return NULL for malloc(), that is
> something a good program tests for. I hate to fail a stack grow.
> So, must play a bit more, see whether I can find a mode much
> stricter than 0 that is still suitable as a general working
> environment for everybody.

What might work (if you've not already tried it) is to make the initial
stack something like 1 or 4Mbytes. Don't map the pages but install a vma
of that size. That would pre-reserve address space and perhaps avoid
this. I guess if that works then make it a /proc/sys tunable for
guaranteed stack.

