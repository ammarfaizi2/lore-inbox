Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVBBJxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVBBJxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 04:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVBBJxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 04:53:14 -0500
Received: from canuck.infradead.org ([205.233.218.70]:6919 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262222AbVBBJwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 04:52:47 -0500
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack
	pointer)
From: Arjan van de Ven <arjan@infradead.org>
To: Peter Busser <busser@m-privacy.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <200502021035.59536.busser@m-privacy.de>
References: <200501311015.20964.arjan@infradead.org>
	 <200502011044.39259.busser@m-privacy.de> <20050202001549.GA17689@thunk.org>
	 <200502021035.59536.busser@m-privacy.de>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 10:52:38 +0100
Message-Id: <1107337959.4143.75.camel@laptopd505.fenrus.org>
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

On Wed, 2005-02-02 at 10:35 +0100, Peter Busser wrote:
> Hi!
> 
> > Umm, so exactly how many applications use multithreading (or otherwise
> > trigger the GLIBC mprotect call), and how many applications use nested
> > functions (which is not ANSI C compliant, and as a result, very rare)?
> >
> > Do the tests both ways, and document when the dummy() re-entrant
> > function might actually be hit in real life, and then maybe people
> > won't feel that you are deliberately and unfairly overstating things
> > to try to root for one security approach versus another. 
> 
> Well, you can already do the test both ways. There is a kiddie mode, which 
> doesn't do this test. And a blackhat mode, which does it. Basically removing 
> the mprotect and nested function is demoting blackhat mode into kiddie mode.

actually you don't. The presence of the nested function (technically,
the taking of the address of a nested function) marks the PT_GNU_STACK
field in the binary, not the runtime behavior. As such, paxtest does not
offer any real such choice in behavior. The binary needs stack
trampolines, just that in one case you don't use them.

