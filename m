Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVAPMMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVAPMMO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 07:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVAPMMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 07:12:13 -0500
Received: from canuck.infradead.org ([205.233.218.70]:35600 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262493AbVAPML4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 07:11:56 -0500
Subject: Re: patch to fix set_itimer() behaviour in boundary cases
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, matthias@corelatus.se,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105830384.16028.11.camel@localhost.localdomain>
References: <16872.55357.771948.196757@antilipe.corelatus.se>
	 <20050115013013.1b3af366.akpm@osdl.org>
	 <1105830384.16028.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 16 Jan 2005 13:11:36 +0100
Message-Id: <1105877497.8462.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-16 at 00:58 +0000, Alan Cox wrote:
> On Sad, 2005-01-15 at 09:30, Andrew Morton wrote:
> > Matthias Lang <matthias@corelatus.se> wrote:
> > These are things we probably cannot change now.  All three are arguably
> > sensible behaviour and do satisfy the principle of least surprise.  So
> > there may be apps out there which will break if we "fix" these things.
> > 
> > If the kernel version was 2.7.0 then well maybe...
> 
> These are things we should fix. They are bugs. Since there is no 2.7
> plan pick a date to fix it. We should certainly error the overflow case
> *now* because the behaviour is undefined/broken. The other cases I'm not
> clear about. setitimer() is a library interface and it can do the basic
> checking and error if it wants to be strictly posixly compliant.

why error?
I'm pretty sure we can make a loop in the setitimer code that detects
we're at the end of jiffies but haven't upsurped the entire interval the
user requested yet, so that the code should just do another round of
sleeping...


