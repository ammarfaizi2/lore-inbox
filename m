Return-Path: <linux-kernel-owner+w=401wt.eu-S964988AbWLTLCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWLTLCK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 06:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWLTLCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 06:02:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54739 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964988AbWLTLCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 06:02:09 -0500
Date: Wed, 20 Dec 2006 03:02:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: + down_write-preserve-local-irqs.patch added to -mm tree
Message-Id: <20061220030204.d070c807.akpm@osdl.org>
In-Reply-To: <1166612063.3365.1367.camel@laptopd505.fenrus.org>
References: <200612201038.kBKAcN4L026466@shell0.pdx.osdl.net>
	<1166612063.3365.1367.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 11:54:23 +0100
Arjan van de Ven <arjan@infradead.org> wrote:

> On Wed, 2006-12-20 at 02:38 -0800, akpm@osdl.org wrote:
> > The patch titled
> >      down_write(): preserve local irqs
> > has been added to the -mm tree.  Its filename is
> >      down_write-preserve-local-irqs.patch
> > 
> > See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> > out what to do about this
> > 
> > ------------------------------------------------------
> > Subject: down_write(): preserve local irqs
> 
> excuse me? Am I missing something here?

Lots.

> down_write() is a sleeping function, right? what business does it have
> to be *ever* called with irqs off?
> 
> if the answer is "none whatsoever", what good is saving irq state then?
> 

a) this patch is for testers to confirm that this fixes the hangs

b) there's plenty of precendent for this - powerpc won't boot if
   mutex_lock() enables interrupts, for example.  We just assume that
   during early boot these sleeping locks aren't contended.

yes, it does suck.
