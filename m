Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264411AbUFCWWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUFCWWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 18:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUFCWWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 18:22:18 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:21189 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S264411AbUFCWVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 18:21:30 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Oliver Neukum <oliver@neukum.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com, vojtech@suse.cz
Subject: Re: [RFC] Changing SysRq - show registers handling 
In-reply-to: Your message of "Thu, 03 Jun 2004 17:06:01 -0400."
             <20040603210601.GC6709@thunk.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 Jun 2004 08:21:18 +1000
Message-ID: <21192.1086301278@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2004 17:06:01 -0400, 
Theodore Ts'o <tytso@mit.edu> wrote:
>On Thu, Jun 03, 2004 at 09:44:01AM +0200, Oliver Neukum wrote:
>> Am Donnerstag, 3. Juni 2004 09:27 schrieb Dmitry Torokhov:
>> > I don't like the requirement of SysRq request processing being in hard
>> > interrupt handler - that excludes uinput-generated events and precludes
>> > moving keyboard handling to a tasklet for example.
>> 
>> SysRq should work even if bottom halfs don't.
>
>Indeed; one of the times when SysRq-p is used in the field is when the
>machine is completely wedged.  Sometimes it's the only way to figure
>out where the machine is wedged.  It would be unfortunate if the
>number of cases (when the kernel is four feet in the air and
>twitching) where SysRq worked decreases as a result of the proposed
>change.

KDB has a similar problem, it needs struct pt_regs as a starting point
for backtraces and that is not always available.  I get around the lack
of a pt_regs by using KDB_ENTER() which generates a software interrupt.
We could define a software interrupt for SYSRQ_ENTER(key).  This would
remove all the overhead of saving and tracking pt_regs from the fast
paths.  The downside is that it needs a software interrupt to be
defined for every arch :(.

