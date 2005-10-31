Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVJaAy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVJaAy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 19:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVJaAy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 19:54:26 -0500
Received: from ozlabs.org ([203.10.76.45]:34981 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932388AbVJaAyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 19:54:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17253.27399.700034.125453@cargo.ozlabs.ibm.com>
Date: Mon, 31 Oct 2005 11:53:27 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, Keith Owens <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 assorted warnings
In-Reply-To: <1130710531.32734.5.camel@localhost.localdomain>
References: <5455.1130484079@kao2.melbourne.sgi.com>
	<20051028073049.GA27389@redhat.com>
	<1130710531.32734.5.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> gcc is a *LOT* smarter than you give it credit for. It will not warn for
> cases where it isn't able to tell how foo is used passed with &foo. It
> will warn for cases where it can

Gcc thinks it is a lot smarter than it actually is, in fact. :)

The usual case where it gives a bogus warning is where the value of
one variable is correlated with the defined-ness of another, for
example:

	found = 0;
	for (i = 0; i < N; ++i) {
		if (a[i] == foo) {
			x = b[i];
			found = 1;
			break;
		}
	}
	if (found)
		bar(x);

Gcc will warn on the use of x when in fact it is perfectly OK, and we
get quite a few of these in compiling a kernel.  At a minimum, I would
like to be able to disable the "may be used uninitialized" warnings
while still getting the "is used uninitialized" warnings.

Paul.
