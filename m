Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVAMVK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVAMVK5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVAMVIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:08:38 -0500
Received: from mail.joq.us ([67.65.12.105]:29110 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261519AbVAMVDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:03:42 -0500
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       Lee Revell <rlrevell@joe-job.com>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050111214152.GA17943@devserv.devel.redhat.com>
	<200501112251.j0BMp9iZ006964@localhost.localdomain>
	<20050111150556.S10567@build.pdx.osdl.net>
	<87y8ezzake.fsf@sulphur.joq.us>
	<20050112074906.GB5735@devserv.devel.redhat.com>
	<87oefuma3c.fsf@sulphur.joq.us>
	<20050113072802.GB13195@devserv.devel.redhat.com>
From: "Jack O'Quin" <joq@io.com>
Date: Thu, 13 Jan 2005 15:04:26 -0600
In-Reply-To: <20050113072802.GB13195@devserv.devel.redhat.com> (Arjan van de
 Ven's message of "Thu, 13 Jan 2005 08:28:02 +0100")
Message-ID: <878y6x9h2d.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > On Tue, Jan 11, 2005 at 07:43:29PM -0600, Jack O'Quin wrote:
>> >> Arjan just means crashing the system which forces reboot to run
>> >> fsck.

>> Arjan van de Ven <arjanv@redhat.com> writes:
>> > I actually meant data corruption.

> On Wed, Jan 12, 2005 at 06:44:23PM -0600, Jack O'Quin wrote:
>> Are you concerned about something different from the "normal" risk of
>> data corruption when the kernel panics or someone trips over the power
>> cord?

Arjan van de Ven <arjanv@redhat.com> writes:
> yes; the "normal" risk is time limited, eg the kernel will wait at most 30
> seconds before writing back your dirty data, 5 seconds for ext3 actually.
> With the "RT-abuse" hang, this 30 second thing goes on hold (because it's
> done from those kernel threads that cause you those hickups in sound :-) and
> you can starve a far longer period of time.. which may well mean a far
> larger dataset not hitting the disk.

Ah, good point.

Just thinking about this naively, I come up with two scenarios:

  (1) SMP -- RT thread hangs one CPU.  Kernel threads can still run on
  other processors.  Rest of system continues running (degraded) until
  more RT threads hang the remaining CPUs at which time we end up
  with...

  (2) UP -- RT thread hangs the last remaining CPU.  Kernel threads
  can't run.  User processes can no longer write data to FS.

(Probably, this simplistic analysis misses some other, more subtle,
factors.)

RT threads should not do FS writes of their own.  But, a badly broken
or malicious one could, I suppose.  So, that might provide a mechanism
for losing more data than usual.  Is that what you had in mind?
-- 
  joq
