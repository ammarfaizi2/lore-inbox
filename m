Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVDFLPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVDFLPp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 07:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVDFLPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 07:15:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28556 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262165AbVDFLPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 07:15:33 -0400
Subject: Re: AMD64 Machine hardlocks when using memset
From: Arjan van de Ven <arjan@infradead.org>
To: Philip Lawatsch <philip@lawatsch.at>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <4253C0FC.6070402@lawatsch.at>
References: <3Ojst-4kX-19@gated-at.bofh.it> <3OGIo-7oY-13@gated-at.bofh.it>
	 <3OGIo-7oY-15@gated-at.bofh.it> <3OGIo-7oY-17@gated-at.bofh.it>
	 <3OGIo-7oY-11@gated-at.bofh.it> <3OIh7-cc-1@gated-at.bofh.it>
	 <3OITV-AR-3@gated-at.bofh.it> <3PxjH-812-3@gated-at.bofh.it>
	 <42535FFF.4080503@shaw.ca>  <4253C0FC.6070402@lawatsch.at>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 13:15:23 +0200
Message-Id: <1112786123.6275.41.camel@laptopd505.fenrus.org>
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

On Wed, 2005-04-06 at 12:59 +0200, Philip Lawatsch wrote:
> Robert Hancock wrote:
> > Alan Cox wrote:
> > 
> >> On Sad, 2005-04-02 at 05:50, Robert Hancock wrote:
> >>
> >>> I'm wondering if one does a ton of these cache-bypassing stores
> >>> whether something gets hosed because of that. Not sure what that
> >>> could be though. I don't imagine the chipset is involved with any of
> >>> that on the Athlon 64 - either the CPU or RAM seems the most likely
> >>> suspect to me
> >>
> >>
> >>
> >> The glibc version is essentially the "perfect" copy function for the
> >> CPU. If you have any bus/memory problems or chipset bugs it will bite
> >> you.
> > 
> > 
> > Anyone have any suggestions on how to track this further? It seems
> > fairly clear what circumstances are causing it, but as for figuring out
> > what's at fault..
> 
> Digging through my glibc's source if found that if you memset arrays
> <120000 bytes it will use good old mov instructions to do the job. In
> case of arrays larger than 120000 bytes it will use movnti instructions
> to do the job.
> 
> Thus I refined my test code to use mov for memset regardless of the size
> (simply abused glibcs code a little bit)
> 
> -> No crash!
> 
> Then, changing the all the mov to movnti and my machine frags again :(
> 
> It seems that mov'ing does not kill my machine while simply using movnti
> does.

movnti also gets a higher bandwidth so that doesn't rule out too much..



