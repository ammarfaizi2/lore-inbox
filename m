Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbUCJIVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 03:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbUCJIVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 03:21:35 -0500
Received: from gdr.net1.nerim.net ([62.212.99.186]:31562 "EHLO
	uniton.integrable-solutions.net") by vger.kernel.org with ESMTP
	id S262525AbUCJIVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 03:21:32 -0500
To: Richard Henderson <rth@twiddle.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Thomas Schlichter <thomas.schlichter@web.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gcc@gcc.gnu.org
Subject: Re: [PATCH] fix warning about duplicate 'const'
References: <200403090043.21043.thomas.schlichter@web.de>
	<20040308161410.49127bdf.akpm@osdl.org>
	<Pine.LNX.4.58.0403081627450.9575@ppc970.osdl.org>
	<200403090217.40867.thomas.schlichter@web.de>
	<Pine.LNX.4.58.0403081728250.9575@ppc970.osdl.org>
	<20040310054918.GB4068@twiddle.net>
From: Gabriel Dos Reis <gdr@integrable-solutions.net>
In-Reply-To: <20040310054918.GB4068@twiddle.net>
Organization: Integrable Solutions
Date: 10 Mar 2004 09:10:49 +0100
Message-ID: <m3fzchxgty.fsf@uniton.integrable-solutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson <rth@twiddle.net> writes:

| On Mon, Mar 08, 2004 at 05:32:11PM -0800, Linus Torvalds wrote:
| > Also, I'm not convinced this isn't a gcc regression. It would be stupid to 
| > "fix" something that makes old gcc's complain, when they may be doing the 
| > right thing.
| 
| Problem is, that we're supposed to complain for
| 
| 	const const int x;
| and
| 	typedef const int t;
| 	const t x;

If I can help with an existing pratice, in C++ the former is
invalid and the second is valid -- the extra const is just silently
ignored.  Therefore, in C++ land the construct

| 	const int a;
| 	const __typeof(a) x;

would be accepted because __typeof__ acts like an unnamed typedef[*].
(And in effect, g++ will accept the code -- assuming you abstract over
initializers).  So, it does not look like an innovation here.
I don't know whether this should be another case for "C is different
from C++".


[*] Yes, an alias that does not introduce a name is strange alias, but
    that is what __typeof__ does.

-- Gaby
