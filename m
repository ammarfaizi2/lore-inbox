Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbUCKDNN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 22:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUCKDNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 22:13:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:11464 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262971AbUCKDNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 22:13:09 -0500
Date: Wed, 10 Mar 2004 19:19:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Williams <peterw@aurema.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org,
       "Godbole, Amarendra (GE Consumer & Industrial)" 
	<Amarendra.Godbole@ge.com>
Subject: Re: (0 == foo), rather than (foo == 0)
In-Reply-To: <404FD81D.3010502@aurema.com>
Message-ID: <Pine.LNX.4.58.0403101917060.1045@ppc970.osdl.org>
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>
 <20040310100215.1b707504.rddunlap@osdl.org> <Pine.LNX.4.53.0403101324120.18709@chaos>
 <404F9E28.4040706@aurema.com> <Pine.LNX.4.58.0403101832580.1045@ppc970.osdl.org>
 <404FD81D.3010502@aurema.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Mar 2004, Peter Williams wrote:
> 
> As somebody pointed out -Wall will (help) detect most of these errors by 
> suggesting () be placed around any expression of the form a = b that 
> occurs inside a simple boolean expression which will cause those people 
> who care about eliminating warning messages to reevaluate the code and 
> make sure they really meant a = b and replace it with (a = b) to get rid 
> of the warning error.

Actually, don't just add parenthesis. They get rid of the warning, but 
they don't actually make for very pretty reading.

I don't know why the gcc warning suggests adding parentheses, since they 
have no semantic meaning, and are _horrible_ from a syntactic standpoint.

The warning should be there whether there are parenthesis or not, and it 
should state that you should have an explicit inequality expression. So if 
you have

	if (a = b) 
		...

and you really _mean_ that, then the way to write it sanely is to just 
write it as

	if ((a = b) != 0)
		...

which makes it much clearer what you're actually doing.

		Linus
