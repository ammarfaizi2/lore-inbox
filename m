Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWJRDnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWJRDnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 23:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWJRDnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 23:43:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7338 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751266AbWJRDnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 23:43:03 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cal Peake <cp@absolutedigital.net>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Undeprecate the sysctl system call
References: <453519EE.76E4.0078.0@novell.com>
	<20061017091901.7193312a.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0610171401130.10587@lancer.cnet.absolutedigital.net>
	<1161123096.5014.0.camel@localhost.localdomain>
	<20061017150016.8dbad3c5.akpm@osdl.org>
	<Pine.LNX.4.64.0610171853160.25484@lancer.cnet.absolutedigital.net>
Date: Tue, 17 Oct 2006 21:41:19 -0600
In-Reply-To: <Pine.LNX.4.64.0610171853160.25484@lancer.cnet.absolutedigital.net>
	(Cal Peake's message of "Tue, 17 Oct 2006 19:09:02 -0400 (EDT)")
Message-ID: <m1wt6y70kg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal Peake <cp@absolutedigital.net> writes:

> On Tue, 17 Oct 2006, Andrew Morton wrote:
>
>> yes, it appears that we screwed that up, but I haven't got around to thinking
> about
>> it yet.
>
> Well, here's a patch that hopefully solves the mess :)
>
> From: Cal Peake <cp@absolutedigital.net>
>
> Undeprecate the sysctl system call and default to always include it with 
> the option for embedded folks to exclude it. Also, remove it's entry from 
> the feature removal file.
>
> Signed-off-by: Cal Peake <cp@absolutedigital.net>

NAK on the grounds that it does not fix the related wording in sysctl.h

As for the rest of this I disagree with this direction as it is not
fixing the status quo, just attempting to maintain it.

The status quo is that there is one ridiculous user in glibc that
doesn't break when sys_sysctl is not compiled in.

The status quo is that we don't properly maintain sysctl.h and we arbitrarily
change the numbers.

The status quo is that sys_sysctl has been deprecated for longer than
feature-removal.txt

If we choose to maintain this and step up to maintaining the binary
ABI which no one uses then I am happy.

If we agree to remove the useless thing I am also happy.

It is wrong to maintain the status quo.  Who is volunteering to step
up to the plate and maintain this thing?

I have just about enough time and energy to finish killing sys_sysctl.


Contrary to Alan's assertion all of those binary numbers in sysctl.h
are not trivial to maintain or we would not have broken the ABI
several times in the 2.6 series.  Although I do agree it should be
simple (not trivial) to maintain if we decide it is important.

Eric
