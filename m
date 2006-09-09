Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWIIFNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWIIFNV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 01:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWIIFNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 01:13:21 -0400
Received: from 1wt.eu ([62.212.114.60]:23058 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932146AbWIIFNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 01:13:20 -0400
Date: Sat, 9 Sep 2006 07:10:14 +0200
From: Willy Tarreau <w@1wt.eu>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Patrick McHardy <kaber@trash.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops after 30 days of uptime
Message-ID: <20060909051014.GC541@1wt.eu>
References: <200609011852.39572.linux@rainbow-software.org> <200609032203.23003.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609032203.23003.linux@rainbow-software.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Sun, Sep 03, 2006 at 10:03:22PM +0200, Ondrej Zary wrote:
> > On Friday 01 September 2006 19:00, Patrick McHardy wrote:
> > > Ondrej Zary wrote:
> > > > Hello,
> > > > my home router crashed after about a month. It does this sometimes but
> > > > this time I was able to capture the oops. Here is the result of running
> > > > ksymoops on it (took a photo of the screen and then manually converted
> > > > to plain-text). Does it look like a bug or something other?
> > > >
> > > >
> > > > Code;  c01eeb9e <init_or_cleanup+15e/160>
> > > > 00000000 <_EIP>:
> > > > Code;  c01eeb9e <init_or_cleanup+15e/160>   <=====
> > > >    0:   8b 5e 18                  mov    0x18(%esi),%ebx   <=====
> > > > Code;  c01eeba1 <ip_conntrack_protocol_register+1/70>
> > > >    3:   11 d8                     adc    %ebx,%eax
> > >
> > > This looks like a bug in some out of tree protocol module (2.4 only
> > > contains the built-in protocols). Did you apply any netfilter patches?
> >
> > No patches, it's clean 2.4.31.
> > Hopefully I typed all the numbers correctly...
> 
> Checked all numbers and it's correct. Can this be a hardware problem?

Given that esi was 0xc1ffffe8, the oops was triggered by a crossed page
boundary (0xc2000000). This does not look like a hardware problem, but
rather a bug somewhere with too small a malloc for some structure. It
is really hard to tell where. I would suspect some classical bugs such
as kmalloc(sizeof(p)) instead of kmalloc(sizeof(*p)), but it's just
pure guess. I'll try to figure out what the code section was to find
the structure name and check its allocation path.

> -- 
> Ondrej Zary

Regards,
Willy

