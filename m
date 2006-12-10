Return-Path: <linux-kernel-owner+w=401wt.eu-S1762531AbWLJX3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762531AbWLJX3r (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 18:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762538AbWLJX3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 18:29:47 -0500
Received: from ns.firmix.at ([62.141.48.66]:49814 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762531AbWLJX3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 18:29:46 -0500
Subject: Re: strncpy optimalisation? (lib/string.c)
From: Bernd Petrovitsch <bernd@firmix.at>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: Mitchell Blank Jr <mitch@sfgoth.com>, Willy Tarreau <w@1wt.eu>,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
In-Reply-To: <20061210213925.GE30197@vanheusden.com>
References: <20061210205230.GB30197@vanheusden.com>
	 <20061210210614.GD24090@1wt.eu> <20061210214934.GC47959@gaz.sfgoth.com>
	 <20061210213925.GE30197@vanheusden.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 11 Dec 2006 00:28:45 +0100
Message-Id: <1165793325.8998.10.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.409 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-10 at 22:39 +0100, Folkert van Heusden wrote:
> > > Original code completely pads the destination with zeroes,
> > > while yours only adds the last zero. Your code does what
> > > strncpy() is said to do, but maybe there's a particular
> > > reason for it to behave differently in the kernel
> > No, the kernel's strncpy() behaves the same as the one in libc.  Run
> > "man strncpy" if you don't believe me.
> > In the common case where you just want to copy a string and avoid
> > overflow use strlcpy() instead
> 
> Oops you're right! Maybe someone should take a look if the strncpy's
> should be replaced by strlcpy's then because it is (ought to be) faster.

The last time some folks did this (quite automatically) ended in newly
introduced bugs leaking old/stale data from kernel top user space. Alan
Cox went over it (again) and fixed those broken "optimizations".

So whoever wants to do this, look for such issues too.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

