Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWILFuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWILFuL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 01:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWILFuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 01:50:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61574 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751221AbWILFuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 01:50:09 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] MMIO accessors & barriers documentation
References: <1157947414.31071.386.camel@localhost.localdomain>
	<1157965071.23085.84.camel@localhost.localdomain>
	<1157966269.3879.23.camel@localhost.localdomain>
	<1157969261.23085.108.camel@localhost.localdomain>
Date: Mon, 11 Sep 2006 23:48:33 -0600
In-Reply-To: <1157969261.23085.108.camel@localhost.localdomain> (Alan Cox's
	message of "Mon, 11 Sep 2006 11:07:41 +0100")
Message-ID: <m1pse17hzi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> > "Except where the underlying device is marked as cachable or
>> > prefetchable"
>> 
>> You aren't supposed to use MMIO accessors on cacheable memory, are you ?
>
> Why not. Providing it is in MMIO space, consider ROMs for example or
> write path consider frame buffers.

Frame buffers are rarely cachable as such, on x86 they are usually
write-combining.   Which means that the writes can be merged and
possibly reordered while they are being written but they can't be
cached.  Most arches I believe have something that roughly corresponds
to write combining.

Ensuring we can still use this optimization to mmio space is
moderately important.

Eric



