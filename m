Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270551AbUJTWgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270551AbUJTWgT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270334AbUJTWdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:33:54 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:9179 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270440AbUJTTqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:46:55 -0400
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: bgagnon@coradiant.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041019143522.GA8688@logos.cnet>
References: <OFDDC77A23.4D34536B-ON85256F2D.00514F15-85256F2D.00517F52@coradiant.com>
	 <20041015182352.GA4937@logos.cnet>
	 <1097980764.13226.21.camel@localhost.localdomain>
	 <20041019143522.GA8688@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098297838.12366.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 20 Oct 2004 19:43:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-10-19 at 15:35, Marcelo Tosatti wrote:
> > That isnt sufficient. Consider anything else taking a reference to the
> > page and the refcount going negative. 
> 
> You mean not going negative? The problem here as I understand here is 
> we dont release the count if the PageReserved is set, but we should.

Drivers like the OSS audio drivers move page between Reserved and 
unreserved. The count can thus be corrupted.


