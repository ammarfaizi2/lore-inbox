Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752762AbWKHHdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbWKHHdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 02:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbWKHHdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 02:33:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55244 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752762AbWKHHdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 02:33:37 -0500
Date: Tue, 7 Nov 2006 23:33:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Avi Kivity <avi@qumranet.com>
Cc: Roland Dreier <rdreier@cisco.com>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] KVM: Kernel-based Virtual Machine (v4)
Message-Id: <20061107233323.c984fa9b.akpm@osdl.org>
In-Reply-To: <455183EA.2020405@qumranet.com>
References: <454E4941.7000108@qumranet.com>
	<20061107204440.090450ea.akpm@osdl.org>
	<adafycuh77b.fsf@cisco.com>
	<455183EA.2020405@qumranet.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 09:14:50 +0200
Avi Kivity <avi@qumranet.com> wrote:

> Roland Dreier wrote:
> >  > That's gas 2.16.1.  I assume it needs some super-new binutils.
> >  > 
> >  > I'm not sure what to do about this.  What's the minimum version?
> >
> > According to http://kvm.sourceforge.net/howto.html :
> >     A recent enough binutils (>= 2.16.91.0.2) for vmx instruction support
> >   
> 
> Either that or a bunch of ugly .byte macros.
> 

I think we could live with the binutils requirement as long as we can find
some automagic way of not breaking people's `make allmodconfig'.  Because
quite a lot of those people who do cross-compilation tend to use older
binutilses.

But I don't know how to do that.  We _could_ do a trick similar to the
`cc-version' make rule, and then use the new `as-version' to make the whole
kvm.o compile down to an empty .o file.  But that's pretty hacky.  Would
really prefer something at Kconfig-time, but we have no way of letting the
assembler version feed into the Kconfig system (nor do we want it, I
suspect).

