Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264102AbTEaCHY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 22:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbTEaCHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 22:07:24 -0400
Received: from holomorphy.com ([66.224.33.161]:47506 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264102AbTEaCHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 22:07:23 -0400
Date: Fri, 30 May 2003 19:20:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Stewart Smith <stewartsmith@mac.com>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: buffer_head.b_bsize type
Message-ID: <20030531022030.GU15692@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andries Brouwer <aebr@win.tue.nl>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Stewart Smith <stewartsmith@mac.com>, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
References: <746529B0-91C0-11D7-9488-00039346F142@mac.com> <20030529103503.GZ8978@holomorphy.com> <20030529111517.GP14138@parcelfarce.linux.theplanet.co.uk> <20030529112841.GA8978@holomorphy.com> <20030530162434.A2700@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030530162434.A2700@pclin040.win.tue.nl>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 04:24:34PM +0200, Andries Brouwer wrote:
> Not about this particular case, but as a general remark:
> Use of unsigned is dangerous - use of int is far preferable,
> everywhere that is possible.
> With ints the test a+b > c is equivalent to the test a > c-b.
> Intuition works.
> As soon as there is some unsigned in an expression comparisons
> get counterintuitive because -1 is very large.
> Thus, 1+sizeof(int) > 3 is true, but 1 > 3-sizeof(int) is false.
> It has happened several times that kernel code was broken because
> some variable (that always was nonnegative) was made unsigned.

I don't see what the big deal is. Arithmetic in Z/2**32Z or whatever
doesn't really define a comparison, we just artificially impose our
favorite residues and have to check various preconditions for the
results of comparisons to make sense (which obviously aren't checked
in your example of garbage produced by a comparison).

You are right in that some attempt at an audit should be done if it
were to be changed, of course. I generally think of it as easy, and
assume it will be done.

-- wli
