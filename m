Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267730AbUHMXfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267730AbUHMXfh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267737AbUHMXfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:35:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61335 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267730AbUHMXff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:35:35 -0400
Date: Fri, 13 Aug 2004 16:35:27 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Neil Horman <nhorman@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mike_phillips@urscorp.com, zaitcev@redhat.com
Subject: Re: [Patch} to fix oops in olympic token ring driver on media
 disconnect
Message-Id: <20040813163527.17aec0b5@lembas.zaitcev.lan>
In-Reply-To: <1092434830.25002.25.camel@localhost.localdomain>
References: <411D126B.6090303@redhat.com>
	<1092434830.25002.25.camel@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004 23:07:16 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Gwe, 2004-08-13 at 20:11, Neil Horman wrote:
> > the olympic_close routine was waiting on.  This patch cleans that up.
> > 
> > Tested by me, on 2.4 and 2.6 with good, working results, and no more oopses.
> 
> Should it not be blocking the IRQs on the chip as well ?

I assumed that old olympic_close() did, but perhaps it didn't after all.
There is nothing like the following in it:

+#define DISABLE_IRQS(base_addr) do { \
+   writel(LISR_LIE,(base_addr)+LISR_RWM);\
+   writel(SISR_MI,(base_addr)+SISR_RWM);\
+} while(0)

This is curious. If something was never used, how do we know if it works?
Maybe it's safer just to leave things as Neil did.

-- Pete
