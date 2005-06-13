Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVFMQaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVFMQaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVFMQaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:30:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3762 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261671AbVFMQ3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:29:16 -0400
Subject: Re: Add pselect, ppoll system calls.
From: David Woodhouse <dwmw2@infradead.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Jakub Jelinek <jakub@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <42ADAFE5.5050206@redhat.com>
References: <1118444314.4823.81.camel@localhost.localdomain>
	 <1118616499.9949.103.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
	 <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg>
	 <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>
	 <42AD2640.5040601@redhat.com> <20050613091600.GA32364@outpost.ds9a.nl>
	 <1118655702.2840.24.camel@localhost.localdomain>
	 <20050613110556.GA26039@infradead.org>
	 <20050613111422.GT22349@devserv.devel.redhat.com>
	 <1118661848.2840.34.camel@localhost.localdomain>
	 <42ADA880.60303@redhat.com>
	 <1118678548.25956.200.camel@hades.cambridge.redhat.com>
	 <42ADAFE5.5050206@redhat.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 17:29:37 +0100
Message-Id: <1118680177.25956.213.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 09:10 -0700, Ulrich Drepper wrote:
> poll()'s timeout value is measrued in milliseconds.  Using a 32bit
> value, as implied by using 'int' for the type, limits the mximum
> timeout to be 2^31-1 milliseconds, which means about 24 days.

Ah, OK. I thought you were talking about the timespec in pselect(),
because that's what you quoted. 

Yes, we should make the time for ppoll() a 64-bit value, so you can
request a time period longer than 24 days. Shall we also switch to
microseconds?

>   Believe it or not, people are complaining about this.  Changing the
> timeout to a 64bit millisecond timeout would lift the limitation from
> the API's  POV.  I don't know what limitations exist in the kernel
> itself.

Indeed. The ABI will be set in stone, but we have some leeway to fix the
implementation details of the kernel's limitations -- such as the fact
that on a 32-bit box with HZ == 1000, any requested timeout above
MAX_LONG milliseconds (24 days) will actually end up being infinite.

-- 
dwmw2

