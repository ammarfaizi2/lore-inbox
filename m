Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030495AbWJJWGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030495AbWJJWGV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030562AbWJJWGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:06:20 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:145
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1030495AbWJJWGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:06:19 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Paul Wouters <paul@xelerance.com>
Subject: Re: more random device badness in 2.6.18 :(
Date: Wed, 11 Oct 2006 00:05:54 +0200
User-Agent: KMail/1.9.4
References: <Pine.LNX.4.63.0610101944010.21866@tla.xelerance.com> <200610102313.02783.mb@bu3sch.de> <Pine.LNX.4.63.0610102334470.27986@tla.xelerance.com>
In-Reply-To: <Pine.LNX.4.63.0610102334470.27986@tla.xelerance.com>
Cc: linux-kernel@vger.kernel.org, Gabor Gombas <gombasg@sztaki.hu>,
       fedora-xen@redhat.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610110005.54322.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 October 2006 23:50, Paul Wouters wrote:
> On Tue, 10 Oct 2006, Michael Buesch wrote:
> 
> > > > Why should Openswan touch /dev/hw_random directly?
> > >
> > > Because using /dev/random whlie /dev/hw_random is available does not always
> > > work (eg with padlock)
> >
> > Oh, wait wait. I don't really understand your sentence.
> > Why can't you use /dev/random?
> 
> We have noticed in the past that on VIA's with the padlock, that
> /dev/random stopped working when hw_random got loaded, while we could
> get random from /dev/hw_random. So we assumed that was the design.

This would be a bug. But I have no idea on how this is possible to happen.

> If only a single process should ever touch a device, I wonder why it is
> a device visible to all of userland.

Oh, well. Why do we have /dev/hda, if touching it creates a damn mess. ;)
The device node is there so userspace can access it. Yes. You can read
random data from /dev/hw_random. No problem, really, if you are aware of,
that there is _NO_ guarantee that the data returned is _really_ random.
It may just return 0xFFFFFFFF for some broken piece of overheated (or
something else) hardware.
So the suggested way to use /dev/hw_random is to let rngd access it and
put the data back into the kernel entropy buffers after verifying it.

-- 
Greetings Michael.
