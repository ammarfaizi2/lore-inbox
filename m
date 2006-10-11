Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030777AbWJKDnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030777AbWJKDnL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 23:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030782AbWJKDnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 23:43:10 -0400
Received: from tla.xelerance.com ([193.110.157.130]:43786 "EHLO
	tla.xelerance.com") by vger.kernel.org with ESMTP id S1030777AbWJKDnJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 23:43:09 -0400
Date: Wed, 11 Oct 2006 05:46:35 +0200 (CEST)
From: Paul Wouters <paul@xelerance.com>
To: Gabor Gombas <gombasg@sztaki.hu>
cc: fedora-xen@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: more random device badness in 2.6.18 :(
In-Reply-To: <20061010233214.GA20863@boogie.lpds.sztaki.hu>
Message-ID: <Pine.LNX.4.63.0610110538550.4781@tla.xelerance.com>
References: <Pine.LNX.4.63.0610101944010.21866@tla.xelerance.com>
 <20061010205051.GB14865@boogie.lpds.sztaki.hu> <Pine.LNX.4.63.0610102257100.27986@tla.xelerance.com>
 <20061010233214.GA20863@boogie.lpds.sztaki.hu>
X-Message-Flag: You should stop using Outlook and switch to Thunderbird
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-From: paul@xelerance.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006, Gabor Gombas wrote:

> > Why is this happening in userland?
>
> Because whether the provided data is "random enough" is a policy
> decision, and policy does not belong in the kernel.

So is POSIX compliance. I don't see that being ripped out :)

Is there anyone that disagrees that the quality of random should
be at minimum FIPS compliant? If everyone agrees, it seems to me
that it is more useful to have a stock kernel have proper hardware
random without additional software stirring kernel and hardware
internals.

> > How about xen guests who don't have
> > direct access to the host's hardware (or software) random?
>
> If they don't have access to the host's hardware, then they do not have a
> /dev/hw_random device. What's your question? And how that's different
> from machines not having a hw rng at all?

The xen issue is a seperate, but related, issue. My xen images have far less
entropy gathering then the host system they run on. This is causing /dev/random
to be extremely slow (empty). On hosts with hw_random, it seems I cannot get this
extra entropy from the host to the guest. Though I will try to see if running
rngd on the host helps the xenu's as well. Perhaps that will solve this problem.

> No. It only has to depend on /dev/(u)random. How the entropy is obtained
> (from /dev/hw_random, from the soundcard's white noise or from
> elsewhere) is none of Openswan's business.  Tha'ts up to the system
> administrator or distribution maker to decide and set up.

Yes, again, that has always been my opinion too. We just ran into practical
issues where we couldn't. I am now doing some tests on xen and regular kernels
using VIA and Intel rngs to see if those issues are resolved, so openswan can
indeed go back to only using /dev/random. I will also test to see if running
rngd on the dom0 will benefit the xenu's, and mail a summary to the lists.

Paul
