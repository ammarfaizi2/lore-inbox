Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUBNErF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 23:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbUBNErF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 23:47:05 -0500
Received: from mail.shareable.org ([81.29.64.88]:6787 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S264305AbUBNErB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 23:47:01 -0500
Date: Sat, 14 Feb 2004 04:46:56 +0000
From: Jamie Lokier <jamie@shareable.org>
To: gcc@gcc.gnu.org
Cc: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org
Subject: GCC feature request: warn on "if (function_name)"
Message-ID: <20040214044656.GI31199@mail.shareable.org>
References: <200402120122.06362.ross@datscreative.com.au> <402CB24E.3070105@gmx.de> <200402140041.17584.ross@datscreative.com.au> <200402141124.50880.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402141124.50880.ross@datscreative.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:
> The fix is to put the brackets back on "!need_resched()"  so that we call
> the function and test its return value - not just test the function pointer!

[ Ross' bug was writing "if (!need_resched)" instead of
"if (!need_resched())" ]

I'm very surprised GCC doesn't warn about that.  A quick test confirms
GCC 3.2.2 at least doesn't.

So, this is a feature request:

    - Warn when a function name is tested in a boolean context.
      (A function pointer variable or expression should not be warned for).

      By boolean context I mean any place where a function name is
      used as a value and tested against zero.  Some examples:

          if (function_name)
          if (function_name && ( <some other expression> ))
          if (function_name != 0)
          if (function_name == 0)
          if (!function_name)
          x = function_name ? a : b;

    - Don't warn if there are two levels of parantheses.

I know it's occasionally useful to test the NULL-ness of a functin
name, of weak symbols.  In most cases, though, it's a bug.  If you
really want to check a weak symbol, just write "if ((symbol))".  That
syntax is already well known for testing the result of an assignment,
as in "if ((x = 1))" does not yield a warning but "if (x = 1)" does.

Perhaps a later GCC than 3.2.2 already has this test; if someone is
able to check, that would be nice.

Thanks muchly :)
-- Jamie
