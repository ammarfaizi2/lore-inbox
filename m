Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbUCJPga (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 10:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbUCJPg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 10:36:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:36788 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262662AbUCJPg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 10:36:28 -0500
Date: Wed, 10 Mar 2004 07:43:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Richard Henderson <rth@twiddle.net>
cc: Thomas Schlichter <thomas.schlichter@web.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gcc@gcc.gnu.org
Subject: Re: [PATCH] fix warning about duplicate 'const'
In-Reply-To: <20040310054918.GB4068@twiddle.net>
Message-ID: <Pine.LNX.4.58.0403100740120.1092@ppc970.osdl.org>
References: <200403090043.21043.thomas.schlichter@web.de>
 <20040308161410.49127bdf.akpm@osdl.org> <Pine.LNX.4.58.0403081627450.9575@ppc970.osdl.org>
 <200403090217.40867.thomas.schlichter@web.de> <Pine.LNX.4.58.0403081728250.9575@ppc970.osdl.org>
 <20040310054918.GB4068@twiddle.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Mar 2004, Richard Henderson wrote:
> 
> seems dicey at best.  I'm not sure what to do about this, actually.
> We might could do something with a new __nonqual_typeof(a) that
> strips outermost type qualifications, but I havn't given that much
> thought.

Ok, let's try just stripping the "const" out of the min/max macros, and
see what complains. What the code _really_ wants to do is to just compare
two types for being basically equal, and in real life what Linux really
would prefer is to have "types" as first-class citizens and being able to
compare them directly instead of playing games. And we may end up having
that as a preprocessor phase (ie I might add it to the semantic parse
thing).

		Linus
