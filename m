Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVLaRhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVLaRhn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 12:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVLaRhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 12:37:43 -0500
Received: from [212.76.87.251] ([212.76.87.251]:56070 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932108AbVLaRhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 12:37:42 -0500
From: Al Boldi <a1426z@gawab.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Date: Sat, 31 Dec 2005 20:36:01 +0300
User-Agent: KMail/1.5
Cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       barryn@pobox.com, linux-kernel@vger.kernel.org
References: <200512302306.28667.a1426z@gawab.com> <200512311702.20525.a1426z@gawab.com> <1136039178.2901.25.camel@laptopd505.fenrus.org>
In-Reply-To: <1136039178.2901.25.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200512312036.01351.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, 2005-12-31 at 17:02 +0300, Al Boldi wrote:
> > Shouldn't it be possible to disable overcommit completely, thus giving
> > kswapd a break from running wild trying to find something to swap/page,
> > which is the reason why the system gets unstable going over 95% in your
> > example.
>
> shared mappings make this impractical. To disable overcommit completely,
> each process would need to account for all its own shared libraries, eg
> each process gets glibc added etc. You'll find that on any
> non-extremely-stripped system you then end up with much more memory
> needed than you have ram.

Are you implying shared maps are implemented by way of overcommitting?

Really, overcommit is an add-on feature like swapping, only overcommit is 
free because it's a lier.  So removing an add-on feature should not affect 
the underlying system in any way, such as shared mappings or swapping.

It should be possible to allow swapping to handle all memory requests 
exceeding physical RAM.  OverCommit should be a tuning option for those who 
like to live on the edge, because it really is a gamble.

In the case where swap = physical RAM and overcommit_ratio = 0, the kernel is 
in effect hiding the fact that it is overcommitting.

Can you see the overhead involved here?

Thanks for your input!

--
Al

