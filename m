Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUDQMkd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 08:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263926AbUDQMkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 08:40:33 -0400
Received: from mproxy.gmail.com ([216.239.56.247]:52407 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S261998AbUDQMkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 08:40:32 -0400
Message-ID: <7FF8CDFE.64C50807@mail.gmail.com>
Date: Sat, 17 Apr 2004 08:40:31 -0400
From: Ross Biro <ross.biro@gmail.com>
To: ross@datscreative.com.au
Subject: Re: Kernel writes to RAM it doesn't own on 2.4.24
Cc: linux-kernel@vger.kernel.org, root@chaos.analogic.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200404171440.18829.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Apr 2004 14:40:18 +1000, Ross Dickson
<ross@datscreative.com.au> wrote:
> This is all most enlightening. If I am understanding correctly then every
> device driver that the author specifies to use a "mem=" command to
> reserve some memory for said drivers use at the upper part of physical
> memory is stuffed by design.

The problem is really that Linux doesn't trust the BARs assigned by
the PCI bios because some BIOSes do it incorrectly.  So it reprograms
them based on the memory map it got from the BIOS.  However, before it
does that the mem= parameter overrides the memory map from the BIOS.

I believe what I did was to save a copy of the e820 maps for later,
and then take then take the first free address as the max of the first
free address from the user supplied map and the bios supplied map. 
I'll send out a patch on Tuesday.

  Ross
