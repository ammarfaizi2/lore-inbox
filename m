Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVE0BEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVE0BEP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 21:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVE0BEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 21:04:15 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:56204 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261350AbVE0BEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 21:04:09 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [patch 4/8] irq code: Add coherence test for PREEMPT_ACTIVE
Date: Fri, 27 May 2005 03:06:09 +0200
User-Agent: KMail/1.7.2
Cc: user-mode-linux-devel@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, linux-sh@m17n.org,
       dhowells@redhat.com
References: <20050527003843.433BA1AEE88@zion.home.lan>
In-Reply-To: <20050527003843.433BA1AEE88@zion.home.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505270306.09425.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 May 2005 02:38, blaisorblade@yahoo.it wrote:
> After porting this fixlet to UML:
>
> http://linux.bkbits.net:8080/linux-2.5/cset@41791ab52lfMuF2i3V-eTIGRBbDYKQ
>
> , I've also added a warning which should refuse compilation with insane
> values for PREEMPT_ACTIVE... maybe we should simply move PREEMPT_ACTIVE out
> of architectures using GENERIC_IRQS.
Ok, a grep shows that possible culprits (i.e. giving success to
grep GENERIC_HARDIRQS arch/*/Kconfig, and using 0x4000000 as PREEMPT_ACTIVE, 
as given by grep PREEMPT_ACTIVE include/asm-*/thread_info.h) are (at a first 
glance): frv, sh, sh64.

After a bit of checking, I also verified if they had overriden the value of 
HARDIRQ_BITS. Which they haven't (it seems it's defined exactly where 
CONFIG_HARDIRQS is not used, i.e. nobody is using the ability to override it 
currently).

This was not a very deep investigation, however, so feel free to verify this 
better.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
