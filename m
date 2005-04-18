Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVDRTki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVDRTki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVDRTki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:40:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58843 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262182AbVDRTkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:40:18 -0400
Subject: Re: intercepting syscalls
From: Arjan van de Ven <arjan@infradead.org>
To: Terje Malmedal <tm@basefarm.com>
Cc: Igor Shmukler <igor.shmukler@gmail.com>, Rik van Riel <riel@redhat.com>,
       Daniel Souza <thehazard@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <wvhis2jewxh.fsf@cornavin.basefarm.no>
References: <6533c1c905041511041b846967@mail.gmail.com>
	 <1113588694.6694.75.camel@laptopd505.fenrus.org>
	 <6533c1c905041512411ec2a8db@mail.gmail.com>
	 <e1e1d5f40504151251617def40@mail.gmail.com>
	 <6533c1c905041512594bb7abb4@mail.gmail.com>
	 <Pine.LNX.4.61.0504180752220.3232@chimarrao.boston.redhat.com>
	 <6533c1c905041807487a872025@mail.gmail.com>
	 <1113836378.6274.69.camel@laptopd505.fenrus.org>
	 <6533c1c9050418080639e41fb@mail.gmail.com>
	 <1113837657.6274.74.camel@laptopd505.fenrus.org>
	 <wvhis2jewxh.fsf@cornavin.basefarm.no>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 21:40:02 +0200
Message-Id: <1113853203.6274.97.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 20:56 +0200, Terje Malmedal wrote:
> [Arjan van de Ven]
> >> > but also about doing things at the right layer. The syscall layer is
> >> > almost NEVER the right layer.
> >> > 
> >> > Can you explain exactly what you are trying to do (it's not a secret I
> >> > assume, kernel modules are GPL and open source after all, esp such
> >> > invasive ones) and I'll try to tell you why it's wrong to do it at the
> >> > syscall intercept layer... deal ?
> >> 
> >> now, when I need someone to tell I do something wrong, I know where to go :)
> 
> > ok i'll spice things up... I'll even suggest a better solution ;)
> 
> Hi. The promise wasn't made to me, but I'm hoping you will find a nice
> and clean solution:
> 
>   Every so often there is bug in the kernel, by patching the
>   syscall-table I have been able to fix bugs in ioperm and fsync without
>   rebooting the box. 
> 

>   What do I do the next time I need to do something like this? 

use kprobes or so to actually replace the faulty lower level function..
you don't know from how many different angles the lower level function
is called, so you're really best of by replacing it at the lowest
possible level, eg closest to the bug. That *very* seldomly is the
actual syscall function.


