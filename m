Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbTFFOuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTFFOuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:50:23 -0400
Received: from mail0.lsil.com ([147.145.40.20]:58028 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261825AbTFFOuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:50:21 -0400
Message-Id: <0E3FA95632D6D047BA649F95DAB60E570185F235@EXA-ATLANTA.se.lsil.com>
From: "Mukker, Atul" <atulm@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>
Cc: Mark Haverkamp <markh@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH] megaraid driver fix for 2.5.70
Date: Fri, 6 Jun 2003 11:03:48 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Coming back to main issue, declaring complete mailbox would 
> be superfluous
> > since driver uses 16 bytes at most. The following patch 
> should fix the panic
> > 
> >  	mbox = (mbox_t *)raw_mbox;
> >  
> > -	memset(mbox, 0, sizeof(*mbox));
> > +	memset(mbox, 0, 16);
> >  
> >  	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
> >  
> 
> This, I think, is a bad idea.  It looks intrinsically wrong 
> to allocate
> storage and assign a pointer to it of a type that is longer than the
> allocated storage.  The initial buffer overrun was due to 
> problems with
> this.

IMO then, your original patch should be good.

