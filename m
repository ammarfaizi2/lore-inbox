Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbTAFRkA>; Mon, 6 Jan 2003 12:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbTAFRkA>; Mon, 6 Jan 2003 12:40:00 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:52751
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267052AbTAFRj7>; Mon, 6 Jan 2003 12:39:59 -0500
Subject: Re: Why do some net drivers require __OPTIMIZE__?
From: Robert Love <rml@tech9.net>
To: root@chaos.analogic.com
Cc: Alex Bennee <alex@braddahead.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1030106105330.1785B-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1030106105330.1785B-100000@chaos.analogic.com>
Content-Type: text/plain
Organization: 
Message-Id: <1041875313.730.16.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Jan 2003 12:48:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 10:56, Richard B. Johnson wrote:

> When you call a function, that function gets a copy of the
> parameters passed to it. In-line code accesses those parameters
> directly. That's why the spin-lock code, for instance, won't work
> (with the current macros) unless they are in-lined.

Huh?

	void dog(int i)
	{
		i++;
	}

	main()
	{
		int x = 1;
		dog(x);
	}

Are you saying x will be 2 after the call?  _Wrong_

Macros, yes.  Inlines, no.

Inline functions have the same behavior as callable functions, with a
few exceptions (they do not act as compiler barriers, for one).

The spin lock C functions will work fine if they are not inlined, as far
as I can tell.  If not, it is just because the inline assembly assumes
they are inline (i.e. what certain registers contain, etc.).

The macros, of course, will need trivial adjustments to use pointers
instead of copies, etc.

Again, the only reason inline vs. not will break anything, as far as I
can tell, is because inline asm assumes a function is inlined.

	Robert Love

