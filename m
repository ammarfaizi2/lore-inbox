Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUA0RyN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 12:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUA0RyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 12:54:13 -0500
Received: from palrel11.hp.com ([156.153.255.246]:54246 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261464AbUA0RyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 12:54:06 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16406.42426.519358.353551@napali.hpl.hp.com>
Date: Tue, 27 Jan 2004 09:54:02 -0800
To: Paul Mackerras <paulus@samba.org>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       Jes Sorensen <jes@trained-monkey.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch] 2.6.1-mm5 compile do not use shared extable code for
 ia64
In-Reply-To: <16406.10170.911012.262682@cargo.ozlabs.ibm.com>
References: <E1Aiuv7-0001cS-00@jaguar.mkp.net>
	<20040120090004.48995f2a.akpm@osdl.org>
	<16401.57298.175645.749468@napali.hpl.hp.com>
	<16402.19894.686335.695215@cargo.ozlabs.ibm.com>
	<16405.41953.344071.456754@napali.hpl.hp.com>
	<16406.10170.911012.262682@cargo.ozlabs.ibm.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 27 Jan 2004 19:56:26 +1100, Paul Mackerras <paulus@samba.org> said:

  Paul> David Mosberger writes:
  >> How about the attached one?  It will touch memory more when
  >> moving an element down, but we're talking about exception tables
  >> here, and I don't think module loading time would be affected in
  >> any noticable fashion.

  Paul> Hmmm...  Stylistically I much prefer to pick up the new
  Paul> element, move the others up and just drop the new element in
  Paul> where it should go, rather than doing swap, swap, swap down
  Paul> the list.

The original code may be slightly faster, but who cares?  From a
readability point of view, I think my version is easier to understand.

  Paul> Also, I don't think there is enough code there to be worth the
  Paul> bother of trying to abstract the generic routine so you can
  Paul> plug in different compare and move-element routines.  The
  Paul> whole sort routine is only 16 lines of code, after all.  Why
  Paul> not just have an ia64-specific version of sort_extable?
  Paul> That's what I thought you would do.

That's certainly an option.  It was Andrew who called for a generic
version.  I tend to agree with him because even though it's just a
little sort routine, it's one of those things where stupid errors tend
to creep in.  And like I mentioned earlier, Alpha needs the exact same
code (and frankly, I'm surprised there are 64-bit platforms that do
NOT use the location-relative format that Richard invented).

	--david
