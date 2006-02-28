Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWB1HE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWB1HE2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 02:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbWB1HE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 02:04:28 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19673 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751613AbWB1HE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 02:04:27 -0500
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ashok Raj <ashok.raj@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [patch 10/39] [PATCH] i386/x86-64: Dont IPI to offline cpus on
 shutdown
References: <20060227223200.865548000@sorel.sous-sol.org>
	<20060227223344.160102000@sorel.sous-sol.org>
	<200602272337.56509.ak@suse.de>
	<20060227231814.GN3883@sorel.sous-sol.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Feb 2006 00:02:01 -0700
In-Reply-To: <20060227231814.GN3883@sorel.sous-sol.org> (Chris Wright's
 message of "Mon, 27 Feb 2006 15:18:14 -0800")
Message-ID: <m1r75ot192.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@sous-sol.org> writes:

> * Andi Kleen (ak@suse.de) wrote:
>> On Monday 27 February 2006 23:32, Chris Wright wrote:
>> > -stable review patch.  If anyone has any objections, please let us know.
>> > ------------------
>> > 
>> > So why are we calling smp_send_stop from machine_halt?
>> 
>> I don't think that one is really suitable for stable since it's
>> a relative obscure problem and the fix is not fully clear. Also it might
>> have side effects. Shouldn't be merged.
>
> This was sent in by both Andrew and Ashok, and is upstream (although Eric
> notes there's more to the comprehensive solution).  It allegedly solves:
>
> http://bugzilla.kernel.org/show_bug.cgi?id=6077
>
> Although the reporter seems to have gone silent.  Unless there's some
> compelling evidence otherwise, I'm happy to drop it.

The comprehensive fix for 2.6.15.x is to remove -p from /sbin/halt
if your machine has this problem.  I have just updated the bugzilla
entry so we can remember this.

There are no security implications to this, either since this is a crash
when attempting to power off the machine.

Eric

