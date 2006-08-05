Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbWHEVKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWHEVKi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 17:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWHEVKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 17:10:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46774 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030277AbWHEVKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 17:10:37 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: David Smith <dsmith@redhat.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, prasanna@in.ibm.com, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [PATCH] module interface improvement for kprobes
References: <1154704652.15967.7.camel@dhcp-2.hsv.redhat.com>
	<20060804155711.GA13271@infradead.org>
	<1154716239.15967.22.camel@dhcp-2.hsv.redhat.com>
	<20060805113538.GA21135@infradead.org>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 05 Aug 2006 17:10:10 -0400
In-Reply-To: <20060805113538.GA21135@infradead.org>
Message-ID: <y0mmzaianyl.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig <hch@infradead.org> writes:

> [...]
> > Why shouldn't I put a probe into a module other than at a symbol I can
> > find with kallsyms?  For example, I'm interested when a particular
> > module hits an error condition that occurs.  [...]
>
> How do you find that offset?  

The same way one would find an address now: by a mixture of
online/offline processing of symbol tables, debugging data, and/or
disassembly.

> You'll probably mention the S-Word but we really want something that
> works with the latest kernel, not just the vendor trees.

Why are you under the impression that systemtap doesn't work with any
particular "latest kernel"?

> [...] Adding another field to struct kprobe to specify an offset
> into the symbol would be the logical extension of that.

At the top you ask rhetorically about how an offset would be found (as
if it were difficult) ...  and here you assert that it is a logical
extension to put it into the API?  I'm confused - which is it?

> > Your example works for a very small number of symbols, but with a large
> > number it could take a long time to register the kprobes.  [...]
> Registering a kprobe is everything but a fastpath, and you definitly
> should not have a lot of probes anyway.  [...]

It is not difficult to imagine situations where one wants to have
hundreds or thousands of active probes: one is function entry/exit
tracing; another is assertion checking.  (If only there was a system
for conveniently expressing these ... oh never mind.)

The idea behind module_get_byname() was to avoid changes in kprobes
etc., and keeping in mind that the same sort of module-name lookup is
already available to userspace via sysfs.  If folks insist that
instead, kprobes be extended to do this step of the probe address
calculations internally, I guess we could use that too.  It would have
to punt if !CONFIG_KALLSYMS, which is too bad, since systemtap and
kprobes work fine without kallsyms now.

- FChE
