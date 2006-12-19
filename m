Return-Path: <linux-kernel-owner+w=401wt.eu-S932860AbWLSRuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860AbWLSRuf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 12:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932861AbWLSRuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 12:50:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49709 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932860AbWLSRue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 12:50:34 -0500
Date: Tue, 19 Dec 2006 09:49:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Robert Hancock <hancockr@shaw.ca>
cc: Jens Axboe <jens.axboe@oracle.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc1
In-Reply-To: <4587F7E4.8000609@shaw.ca>
Message-ID: <Pine.LNX.4.64.0612190944290.3483@woody.osdl.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <200612142144.26023.s0348365@sms.ed.ac.uk> <4581C73F.6060707@garzik.org>
 <200612142233.10584.s0348365@sms.ed.ac.uk> <20061219124130.GN5010@kernel.dk>
 <4587F7E4.8000609@shaw.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Dec 2006, Robert Hancock wrote:
> 
> From what I've seen it appears that smartctl has the same problem, it was also
> reporting the device didn't support SMART..

No, there were actually two different problems, and to confuse people, 
they had the same _symptoms_.

Commit 0e75f9063f5c55fb0b0b546a7c356f8ec186825e introduced a bug where 
SG_IO wouldn't copy the data back to user space correctly, which was why 
you got various tools like "dvd+rw-mediainfo" (and probably smartctl too) 
breaking.

That was also probably why bisection didn't pick out the right commit for 
the _other_ bug: it was effectively masked by the same problem, so the 
fact that commit f38621b3109068adc8430bc2d170ccea59df4261 fixed the sense 
info details and broke hddtemp was not visible as a bug, because the sense 
info was _more_ corrupted by the other bug, and thus "git bisect" walked 
back to where the _first_ bug was introduced, rather than the second one.

Anyway, sounds like hddtemp was just buggy. 

		Linus
