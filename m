Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVACDR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVACDR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 22:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVACDR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 22:17:29 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:42181 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261285AbVACDR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 22:17:26 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Jim Nelson <james4765@cwazy.co.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Coywolf Qi Hunt <coywolf@gmail.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       David Howells <dhowells@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk loglevel policy? 
In-reply-to: Your message of "Sun, 02 Jan 2005 13:41:34 -0800."
             <41D86A8E.9090400@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Jan 2005 14:17:07 +1100
Message-ID: <28707.1104722227@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jan 2005 13:41:34 -0800, 
"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>Jim Nelson wrote:
>> Or does printk() do some tracking that I didn't see as to where in the 
>> kernel the strings are coming from?
>
>That kind of garbled output has been known to happen, but
>the <console_sem> is supposed to prevent that (along with
>zap_locks() in kernel/printk.c).

Using multiple calls to printk to print a single line has always been
subject to the possibility of interleaving on SMP.  We just live with
the risk.  Printing a complete line in a single call to printk is
protected by various locks.  Print a line in multiple calls is not
protected.  If it bothers you that much, build up the line in a local
buffer then call printk once.

