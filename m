Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932701AbWGBQxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbWGBQxQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 12:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWGBQxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 12:53:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37850 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932701AbWGBQxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 12:53:16 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: remove unused exports
References: <20060629191940.GL19712@stusta.de>
	<20060629123608.a2a5c5c0.akpm@osdl.org>
	<20060629124400.ee22dfbf.akpm@osdl.org>
	<20060629195828.GF19712@stusta.de>
	<20060629130633.3da327b6.akpm@osdl.org>
	<20060629211807.GH19712@stusta.de>
Date: Sun, 02 Jul 2006 10:52:22 -0600
In-Reply-To: <20060629211807.GH19712@stusta.de> (Adrian Bunk's message of
	"Thu, 29 Jun 2006 23:18:08 +0200")
Message-ID: <m1ejx47xvd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> On Thu, Jun 29, 2006 at 01:06:33PM -0700, Andrew Morton wrote:
>> On Thu, 29 Jun 2006 21:58:28 +0200
>> Adrian Bunk <bunk@stusta.de> wrote:
>> 
>> > On Thu, Jun 29, 2006 at 12:44:00PM -0700, Andrew Morton wrote:
>> > > On Thu, 29 Jun 2006 12:36:08 -0700
>> > > Andrew Morton <akpm@osdl.org> wrote:
>> > > 
>> > > > On Thu, 29 Jun 2006 21:19:40 +0200
>> > > > Adrian Bunk <bunk@stusta.de> wrote:
>> > > > 
>> > > > > - EXPORT_SYMBOL_GPL's:
>> > > > >   - kernel_restart
>> > > > >   - kernel_halt
>> > > > 

So I can comment on kernel_restart and kernel_halt.
I think I come about as close as it comes to a maintainer
of the reboot infrastructure, and I did write those two functions.

The problem is they were created to address is several different
places in the kernel were performing reboots or halts and
did it inconsistently.  with the result that most localized bug
fixes would trigger a bug in another code path.

At the time the functions machine_halt, and machine_reboot were
exported functions.  So when I did the conversions I preserved
the presence of the export.

After all of the dust settled I think only the swap suspend
code calls into that and that code can't be built modular
so I think removing the exports are ok.

The other places that were calling into these code paths
are now calling emergency_restart().

Enough dust has settled and I can't spot any inappropriate
users in the kernel right now so removing those two exports sounds
fine with me.  We can always add them again if we get modular users.

As long as we are not encouraging people to reinvent this interface
badly again  I have no problems.  If I could think of an appropriate
reason why people would calls these interfaces other than in a watchdog driver
I would worry about people calling emergency_restart when the really wanted
kernel_restart, but didn't because they didn't have the export available.

Eric

