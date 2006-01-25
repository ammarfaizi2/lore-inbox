Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWAYK2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWAYK2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 05:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWAYK2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 05:28:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30116 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751103AbWAYK2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 05:28:20 -0500
To: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, ebiederm@xmission.com, vgoyal@in.ibm.com,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH 1/5] stack overflow safe kdump (2.6.16-rc1-i386) -
 safe_smp_processor_id
References: <1138171868.2370.62.camel@localhost.localdomain>
	<20060124231052.7c9fcbec.akpm@osdl.org>
	<200601250853.48193.ak@suse.de>
	<20060124235901.719aa375.akpm@osdl.org>
	<1138176439.3001.26.camel@laptopd505.fenrus.org>
	<1138179017.7159.13.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 25 Jan 2006 03:27:17 -0700
In-Reply-To: <1138179017.7159.13.camel@localhost.localdomain> (Fernando Luis
 Vazquez Cao's message of "Wed, 25 Jan 2006 17:50:17 +0900")
Message-ID: <m164o8k3ga.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> writes:

> On Wed, 2006-01-25 at 09:07 +0100, Arjan van de Ven wrote:
>> On Tue, 2006-01-24 at 23:59 -0800, Andrew Morton wrote:
>> > Andi Kleen <ak@suse.de> wrote:
>> > >
>> > > On Wednesday 25 January 2006 08:10, Andrew Morton wrote:
>> > > 
>> > > > It assumes that all x86 SMP machines have APICs.  That's untrue of
> Voyager.
>> > > > I think we can probably live with this assumption - others would know
>> > > > better than I.
>> > > 
>> > > Early x86s didn't have APICs and they are still often disabled on not so 
>> > > old mobile CPUs.  I don't think it's a good assumption to make for i386.
>> > > 
>> > 
>> > But how many of those do SMP?
>> 
>> even on SMP boxes you regularly need to (runtime) disable apics. Several
>> boards out there just have busted apics, or at least when used with
>> linux. "noapic" is one of the more frequent things distro support people
>> tell customers over the phone....
> Checking whether ioapic_setup_disabled is set should suffice, right?
> Does the patch below look good?

Actually hard_smp_processor_id should only care about local apics.
Disabling the io_apics should have no affect, on this code path.

So I believe testing for io_apics being enabled is actively wrong.

If the local apics are disabled the feature flag should be cleared,
and we are uniprocessor anyway.

Eric
