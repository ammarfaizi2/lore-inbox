Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWFWOAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWFWOAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWFWOAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:00:43 -0400
Received: from 1wt.eu ([62.212.114.60]:17929 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750709AbWFWOAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:00:37 -0400
Date: Fri, 23 Jun 2006 15:52:01 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andi Kleen <ak@suse.de>
Cc: pageexec@freemail.hu, marcelo@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: another fix for canonical RIPs during signal handling
Message-ID: <20060623135201.GB24737@1wt.eu>
References: <449BC808.4174.277D15CF@pageexec.freemail.hu> <449C0616.4382.286F7C8C@pageexec.freemail.hu> <20060623133217.GA24737@1wt.eu> <200606231546.21731.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606231546.21731.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 03:46:21PM +0200, Andi Kleen wrote:
> 
> > If I understand it well, an application which maps address 0 has no way to
> > be notified that the kernel detected a corrupted stack pointer. 
> 
> It will just not crash again after the application tried to deliberately
> crash the kernel.

"deliberately" is a bit exagerated here. Failed stack overflows,
hardware memory corruption and various bugs that happen to most
application developpers at early coding stage are not what can be
called "deliberate".

Also, I don't know if memory leak detectors rely on getting a SEGV,
but this patch would make them useless on apps which map addr 0.

> > I agree 
> > that if the proposed patch avoids to make this undesired distinction between
> > apps that map addr 0 and those which don't, it would be better to merge it.
> > Andi, you said there was nothing wrong with it, do you accept that it gets
> > merged ?
> 
> As I said, it's not wrong, just not necessary.

I understand your point, but I think that covering most situations the
same way helps reducing exceptions, and helps troubleshooting.

> -Andi

Regards,
Willy

