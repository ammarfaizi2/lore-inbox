Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUDBKNW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 05:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbUDBKNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 05:13:21 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:12216 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263573AbUDBKNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 05:13:18 -0500
Date: Fri, 2 Apr 2004 02:11:08 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040402101108.GA752170@sgi.com>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040328135124.GA32597@mail.shareable.org> <40670A36.3000005@pobox.com> <20040328173623.GA1087@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328173623.GA1087@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 06:36:23PM +0100, Jamie Lokier wrote:
> 
> This is what I mean: turn off write cacheing, and performance on PATA
> drops because of the serialisation and lost inter-command time.

Since you have to write the sectors in order (well, you don't have
to, but the drives all do this), you lose a rev between each write
when you don't queue commands or have write cacheing.

> With TCQ-on-write, you can turn off write cacheing and in theory
> performance doesn't have to drop, is that right?

Correct.  I have proven this to my satisfaction.


Regarding request sizes, the main benefit to very large (> 1MB)
request sizes to disk drives is elimination of the lost revolution
when write cacheing is disabled and you can't queue back-to-
back writes.

For hardware RAID, they frequently need 4MB or more to hit
peak performance.


I agree that we don't want a host driver to arbitrarily limit
I/O size, because it's difficult to predict what may be connected
to it.  It may be necessary due to deficiencies elsewhere, but
not desired.

jeremy
