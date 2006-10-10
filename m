Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWJJVN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWJJVN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWJJVN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:13:26 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:17642
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1030409AbWJJVNY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:13:24 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Paul Wouters <paul@xelerance.com>
Subject: Re: more random device badness in 2.6.18 :(
Date: Tue, 10 Oct 2006 23:13:02 +0200
User-Agent: KMail/1.9.4
References: <Pine.LNX.4.63.0610101944010.21866@tla.xelerance.com> <20061010205051.GB14865@boogie.lpds.sztaki.hu> <Pine.LNX.4.63.0610102257100.27986@tla.xelerance.com>
In-Reply-To: <Pine.LNX.4.63.0610102257100.27986@tla.xelerance.com>
Cc: linux-kernel@vger.kernel.org, Gabor Gombas <gombasg@sztaki.hu>,
       fedora-xen@redhat.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610102313.02783.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 October 2006 23:03, Paul Wouters wrote:
> On Tue, 10 Oct 2006, Gabor Gombas wrote:
> 
> > Why should Openswan touch /dev/hw_random directly?
> 
> Because using /dev/random whlie /dev/hw_random is available does not always
> work (eg with padlock)

Oh, wait wait. I don't really understand your sentence.
Why can't you use /dev/random?

> > There is a good reason why /dev/hw_random is different from /dev/random...
> 
> Why is this happening in userland? Will rng-tools run on every bare Linux
> system now? Including embedded systems? How about xen guests who don't have
> direct access to the host's hardware (or software) random?
> 
> Why is this entropy management not part of the kernel? So for Openswan to
> work correctly, it would need to depend on another daemon that may or may
> not be available and/or running?
> 
> I still believe /dev/random should just give the best random possible for
> the machine. Wether that is software random, or a piece of hardware, should
> not matter. That's the kernel's internal state and functioning.

/dev/hw_random should never be touched by anything else than rngd.
rngd takes the data from /dev/hw_random, _verifys_ it and puts it into
the normal /dev/random pools.
The verification step is really important.
So I would like to ask the other way around. Why should be put this code
into the kernel, while it works in userspace as good (or, some people may
argue it is even better in userspace, because it can more easily be exchanged,
debugged and configured. Whatever)

-- 
Greetings Michael.
