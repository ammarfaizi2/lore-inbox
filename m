Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbUKCPT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbUKCPT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 10:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUKCPTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 10:19:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:33200 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261640AbUKCPTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 10:19:39 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Andi Kleen <ak@suse.de>, Daniel Egger <degger@fhm.edu>
Subject: Re: 2.6.8 and 2.6.9 Dual Opteron glitches
Date: Wed, 3 Nov 2004 09:06:19 -0600
X-Mailer: KMail [version 1.2]
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <5AC1EEB8-2CD7-11D9-BF00-000A958E35DC@fhm.edu.suse.lists.linux.kernel> <8A4609E0-2D86-11D9-BF00-000A958E35DC@fhm.edu> <20041103110511.GA23808@wotan.suse.de>
In-Reply-To: <20041103110511.GA23808@wotan.suse.de>
MIME-Version: 1.0
Message-Id: <04110309061900.18266@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 05:05, Andi Kleen wrote:
> On Wed, Nov 03, 2004 at 11:53:05AM +0100, Daniel Egger wrote:
> > On 03.11.2004, at 06:06, Andi Kleen wrote:
> > >>   Replacing those panic(s) by printk make the machine boot just fine
> > >>   and also work (seemingly) without any problems under load.
> > >
> > >Can you print the two values? I've never seen such a problem.
> > >If it works then they must be identical, otherwise user space would
> > >break very quickly.
> >
> > printk("%p %p %p\n", (unsigned long) &vgettimeofday, &vgettimeofday,
> > VSYSCALL_ADDR(__NR_vgettimeofday));
> >
> > ffffffffff600000 ffffffffff600000 ffffffffff600000
> >
> > I've no idea why it still triggers. Also the next one BTW:
> > vtime link addr brokenIA32
> >
> > The compiler is: gcc version 3.4.0 20040111 (experimental)
>
> Looks like a compiler bug. I would talk to the gcc people.

Personally .. I think it is a type error - unsigned long is 32 bits.

It appears to be comparing it to an address - which is 64 bits.

There is no sign extension from 32bit to 64bit for an unsigned number.

This same problem occured in Kerberos when compiled on AMD in
64 bit mode. The solution was to use (void *).
