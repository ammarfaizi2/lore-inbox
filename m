Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751751AbVHGL4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbVHGL4M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 07:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbVHGL4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 07:56:11 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:7807 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751751AbVHGL4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 07:56:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=x2FO0FjHRqqXp0wqmjhrdpLJ4LelkZUYiDrmBCnivGLtgEcfW7rqW/IjP43imV+W60Zt7gPPPmAe+vsQSOlZ9D2D21P5hox6QkS/4QlnC7BGG4PDscT8mvZc/tZdlb9TPaV1uVN6s5ryGAzUZ6StvPa2RhQg73CH0yAunLv1HXA=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [PATCH] ARCH_HAS_IRQ_PER_CPU avoids dead code in __do_IRQ()
Date: Sun, 7 Aug 2005 13:56:07 +0200
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <200508061814.31719.annabellesgarden@yahoo.de> <200508071225.21825.annabellesgarden@yahoo.de> <200508071307.26221.ioe-lkml@rameria.de>
In-Reply-To: <200508071307.26221.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508071356.07139.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 7. August 2005 13:07 schrieb Ingo Oeser:
> Last argument: Many kernel developers -- including Linus -- 
> don't like "#if" in C files and prefer them in headers. 
> Their reasons might be similiar to my own.

What about writing
	if(CHECK_IRQ_PER_CPU(desc->status)) {
		...
	}
in __do_IRQ(),
and
	#if defined(ARCH_HAS_IRQ_PER_CPU)
		#define IRQ_PER_CPU	256	/* IRQ is per CPU */
		#define CHECK_IRQ_PER_CPU(var) ((var) & IRQ_PER_CPU)
	#else
		#define CHECK_IRQ_PER_CPU(var) 0
	#endif
in "include/linux/irq.h" then?

   Gruesse,
   Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
