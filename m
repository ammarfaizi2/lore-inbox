Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269622AbUJLLiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269622AbUJLLiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 07:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269632AbUJLLit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 07:38:49 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:16521 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S269622AbUJLLiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 07:38:25 -0400
Subject: Re: Totally broken PCI PM calls
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <1097580477.26690.5.camel@gaston>
References: <1097455528.25489.9.camel@gaston>
	 <200410110915.33331.david-b@pacbell.net> <1097533363.13795.22.camel@gaston>
	 <200410111946.03634.david-b@pacbell.net>  <1097553724.7778.34.camel@gaston>
	 <1097578189.3728.14.camel@desktop.cunninghams>
	 <1097580477.26690.5.camel@gaston>
Content-Type: text/plain
Message-Id: <1097581104.4350.3.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Oct 2004 21:38:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-10-12 at 21:27, Benjamin Herrenschmidt wrote:
> > > In the first case, it makes even sense to keep the driver operating
> > > while the device is D1, the driver would then just wake the device on an
> > > incoming request (provided this is allowed by the policy). In the later
> > > case, the driver state is the only thing that matters.
> > 
> > Not quite - you have to be able to get the device into a matching state
> > at resume time. Probably not a problem in most cases, I realise, but
> > thought it was worth a mention.
> 
> Wait, I'm not talking about swsusp here, that's exactly my distinction
> between driver state and device state :) Only system suspend like swsusp
> and suspend-to-ram require a completely coherent and frozen memory
> "image".

Oh ok. I thought suspend was one application of what you were talking
about (not necessarily the only one, but one...)

> All sorts of dynamic PM, including system-wide "idle" can deal with
> scenarios where the driver can stay functional and decide by itself to
> wake up the device upon incoming requests.
> 
> > [...]
> > 
> > > Yup, with the exception that it becomes hell when those devices are
> > > anywhere on the VM path... which makes userspace policy unuseable for
> > > system suspend.
> > 
> > A device on the VM path? I don't follow here. Can I have a hand please?
> 
> Any block device basically, I don't even want to think about the issues
> between NFS & suspend :)

> That is anything that userspace potentially requires to operate (device on
> the path to an mmap'd file, swap, whatever)...

Ah.. I'm with you now. The 'VM path' was too abstract for me at 9:30pm
:>.

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

