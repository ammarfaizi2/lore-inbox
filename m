Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbWJFHZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbWJFHZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 03:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWJFHZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 03:25:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37033 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161084AbWJFHZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 03:25:18 -0400
Subject: Re: Really good idea to allow mmap(0, FIXED)?
From: Arjan van de Ven <arjan@infradead.org>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <eg4624$be$1@taverner.cs.berkeley.edu>
References: <200610052059.11714.mb@bu3sch.de>
	 <eg4624$be$1@taverner.cs.berkeley.edu>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 06 Oct 2006 09:25:15 +0200
Message-Id: <1160119515.3000.89.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 23:55 +0000, David Wagner wrote:
> Michael Buesch  wrote:
> >Is is really a good idea to allow processes to remap something
> >to address 0?
> >I say no, because this can potentially be used to turn rather harmless
> >kernel bugs into a security vulnerability.
> 
> Let me see if I understand.  If the kernel does this somewhere:
> 
>     struct s *foo;
>     foo->x->y = 0;
> 
> and if there is some way that userland code can cause this to be
> executed with 'foo' set to a NULL pointer, then user-land code can
> do this:
> 
>     mmap(0, 4096, PROT_READ|PROT_EXEC|PROT_WRITE,
>         MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
>     struct s *bar = 0;

the question isn't if it's a good idea to allow mmap(0) but to allow
mmap PROT_WRITE | PROT_EXEC !


