Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUHZAyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUHZAyh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUHZAyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 20:54:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51123 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266561AbUHZAyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:54:13 -0400
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/14] kexec: apic-virtwire-on-shutdown.i386.patch
References: <m1vffd667r.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58L.0408231411480.19572@blysk.ds.pg.gda.pl>
	<m1u0uu2d4b.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58L.0408252118150.18088@blysk.ds.pg.gda.pl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Aug 2004 18:52:37 -0600
In-Reply-To: <Pine.LNX.4.58L.0408252118150.18088@blysk.ds.pg.gda.pl>
Message-ID: <m1vff6vhyi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" <macro@linux-mips.org> writes:

> On Mon, 23 Aug 2004, Eric W. Biederman wrote:
> 
> > The local apic still needs to be put into virtual wire mode in that
> > case.
> 
>  Well, depending on actual wiring you may need to mask LINT0 in this case
> to avoid duplicate interrupts.  I think the safest approach would be
> remembering the initial values of LVT0 and LVT1 registers of the BSP --
> they are just four bytes each, so it would not be a terrible memory waste.

If I was seeing problems I guess I would worry about it.  As I have
tested on both Opteron's which require the ioapic to be in
virtual wire mode, and on Xeons which require the local apic to be in
virtual wire mode and both work I am not too concerned.

I don't think the configuration you are worrying about where
both the ioapic and the local apic can both be put into virtual
wire mode is valid according to the mp specification.  Although that
is probably a grey area in the specification.

It is more code to save off and then restore the registers,
then simply hard coding a value into them.

It is nice to have hard coded values when you can as then
you don't have to guess how something was configured on this occasion.

As my code is simpler than your suggestion and it works I'm not
a fan of changing it until I see a case where it breaks.

Eric
