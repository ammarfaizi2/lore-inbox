Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbTJORdW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTJORdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:33:22 -0400
Received: from sea2-dav70.sea2.hotmail.com ([207.68.164.205]:59921 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263750AbTJORc7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:32:59 -0400
X-Originating-IP: [12.145.34.101]
X-Originating-Email: [san_madhav@hotmail.com]
From: "sankar" <san_madhav@hotmail.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "Tim Hockin" <thockin@hockin.org>
Cc: <linux-kernel@vger.kernel.org>
References: <A20D5638D741DD4DBAAB80A95012C0AED78656@orsmsx409.jf.intel.com>
Subject: Re: Question on atomic_inc/dec
Date: Wed, 15 Oct 2003 10:28:34 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <Sea2-DAV70ztBOZvchi0000368d@hotmail.com>
X-OriginalArrivalTime: 15 Oct 2003 17:32:54.0434 (UTC) FILETIME=[5D9F2020:01C39342]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 any solution to the original problem???
(atomic_inc() defintion not there in redhat 9.0 asm/atomic.h)
----- Original Message -----
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Tim Hockin" <thockin@hockin.org>
Cc: "sankar" <san_madhav@hotmail.com>; <linux-kernel@vger.kernel.org>
Sent: Tuesday, October 14, 2003 3:29 PM
Subject: RE: Question on atomic_inc/dec


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

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
