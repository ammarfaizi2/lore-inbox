Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265015AbUE0VZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265015AbUE0VZf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 17:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUE0VZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 17:25:35 -0400
Received: from hera.kernel.org ([63.209.29.2]:61630 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S265015AbUE0VZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 17:25:33 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: mem= handling mess.
Date: Thu, 27 May 2004 21:24:50 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c95mb2$622$1@terminus.zytor.com>
References: <20040527200320.GR22630@redhat.com> <40B65B0F.9090106@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1085693090 6211 127.0.0.1 (27 May 2004 21:24:50 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 27 May 2004 21:24:50 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <40B65B0F.9090106@zytor.com>
By author:    "H. Peter Anvin" <hpa@zytor.com>
In newsgroup: linux.dev.kernel
>
> Dave Jones wrote:
> > mem=exactmap mem=640k@0 mem=511m@1m
> 
> It was changed to memmap= I thought.  The command line suggested above, for 
> example, WILL NOT boot with any correctly operating boot loader. 
> Unfortunately, given its history I suspect GRUB is nowhere in that category.
> 

I take that back.  It works by pure accident: since "mem=511m@1m"
comes last most bootloaders will read it as "mem=511m" which is safe
given this particular memory map.

In other words, this and stuff like this work by pure accident if they
work at all, which is to some degree even worse -- partially because
it let people be lazy about it and thus the wrong thing was allowed to
simmer, as evidenced above.  The "right thing", if there is such a
thing, is probably to detect entries of this form and report an error
to the user ("use memmap= instead.")

The only other sane alternative is worse in terms of incompatibility:
completely throw away the old initrd protocol and design a better
one.  The initrd loading protocol is horrible, but it's been around
for a long time and it's not likely to go away.

	-hpa
