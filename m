Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTJOFTT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 01:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbTJOFTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 01:19:18 -0400
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:22687 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S262362AbTJOFTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 01:19:17 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Andrew Morton <akpm@osdl.org>, Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: 2.6.0-test7: saa7134 breaks on gcc 2.95
Date: Wed, 15 Oct 2003 07:16:58 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <3F8C9705.26CA0B63@eyal.emu.id.au> <20031014175938.04d94087.akpm@osdl.org>
In-Reply-To: <20031014175938.04d94087.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310150716.58737.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 October 2003 02:59, Andrew Morton wrote:
> Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
> > This compiler does not like dangling comma in funcs, so this patch
> >  is needed. For:
> >
> >  #define dprintk(fmt, arg...)    if (core_debug) \
> >  	printk(KERN_DEBUG "%s/core: " fmt, dev->name, ## arg)
> >
> >  Lines like this:
> >
> >  	dprintk("hwinit1\n");
> >
> >  should be hacked like this:
> >
> >  	dprintk("hwinit1\n", "");
>
> I couldn't find a sane way.  Ended up doing this:
[splitting the printk]


GCC 2.95 doesn't like no space BEFORE AND AFTER the comma in the argument right
before the "## arg".

So just having a space there should work without splitting the printk. Not
compile tested, since I need to go now.

Regards

Ingo Oeser


