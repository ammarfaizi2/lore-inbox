Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTJNWaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 18:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTJNWaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 18:30:06 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:39040 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S261936AbTJNWaC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 18:30:02 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Question on atomic_inc/dec
Date: Tue, 14 Oct 2003 15:29:56 -0700
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AED78656@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on atomic_inc/dec
Thread-Index: AcOSnjFHMBD1D97NQhit07OeAK9eFgAA4KYA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Tim Hockin" <thockin@hockin.org>
Cc: "sankar" <san_madhav@hotmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Oct 2003 22:29:56.0532 (UTC) FILETIME=[B201B740:01C392A2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Tim Hockin [mailto:thockin@hockin.org]
> 
> On Tue, Oct 14, 2003 at 02:17:49PM -0700, Perez-Gonzalez, Inaky wrote:
> > It will be in include/asm/atomic.h; however, it is not wise to
> > use directly the kernel stuff unless you are coding kernel stuff.
> 
> Is there any reason NOT to use the atomic ops in user-space?  I mean, are
> they privileged on some architectures, or ...?  It seems like some
> user-space apps might really benefit from simple atomic ops.  Or at least,
> kernel-coders writing in userspace could sure use simple atomic ops :)

Well, you are right; functionally speaking, there are no concerns,
however, there are problems.

Not all architectures have really simple atomic operations like
for example, ia32 or PPC. For example, Sparc has to do this ugly 
spinlock thinguie and that's why you can only count on 24 bits 
out of the whole atomic data type; another example is ARM,
you just disables irqs and preemption, I guess, and operates), there
is no way they will work in user space

When you have implementations like this, where ia32 is one of the 
lucky exceptions because you can do it with a couple of asm opcodes,
it is really impossible to offer something that can float up to
user space.

PS: hey, how's Mike doing? Say hi from me, pls

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
