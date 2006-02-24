Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWBXUj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWBXUj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWBXUj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:39:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36776 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751086AbWBXUj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:39:27 -0500
To: Andi Kleen <ak@suse.de>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
	<43FF26A8.9070600@keyaccess.nl>
	<m17j7kda52.fsf@ebiederm.dsl.xmission.com>
	<200602241748.39949.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Feb 2006 13:38:02 -0700
In-Reply-To: <200602241748.39949.ak@suse.de> (Andi Kleen's message of "Fri,
 24 Feb 2006 17:48:38 +0100")
Message-ID: <m1wtfkbihh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Friday 24 February 2006 16:55, Eric W. Biederman wrote:
>> there, and... more invasiveness?
>> 
>> __pa stops working on kernel addresses.
>
> x86-64 always had this problem and it's not very hard to handle with a simple ?:

It has been several months but yes most of the pieces are simple.
Although you do loose the opportunities for several micro-optimizations,
that way.  The point was simply that working with relocations is even
less intrusive.  The changes stop at kernel/head.S if they even get
that far.  Plus the proof that you have not pessimized things is
trivial, because nothing has changed.

The fact that your kernel virtual addresses can be at different
2MB/4MB aligned boundaries is a downside, as is the fact that your
bzImage becomes 5-10% larger because of all of the relocations.

Eric
