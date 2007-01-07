Return-Path: <linux-kernel-owner+w=401wt.eu-S932390AbXAGEtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbXAGEtT (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 23:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbXAGEtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 23:49:19 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59362 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932390AbXAGEtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 23:49:18 -0500
Date: Sat, 6 Jan 2007 20:45:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Denis Vlasenko <vda.linux@googlemail.com>
cc: Albert Cahalan <acahalan@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, bunk@stusta.de,
       mikpe@it.uu.se
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <200701070525.45974.vda.linux@googlemail.com>
Message-ID: <Pine.LNX.4.64.0701062041330.3661@woody.osdl.org>
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com>
 <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com>
 <Pine.LNX.4.64.0701040921010.3661@woody.osdl.org> <200701070525.45974.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2007, Denis Vlasenko wrote:
> 
> I'd say "care about obvious, safe optimizations which we still not do".
> I want this:
> 
> char v[4];
> ...
> 	memcmp(v, "abcd", 4) == 0
> 
> compile to single cmpl on i386.

Yeah. For a more relevant case, look at the hoops we used to jump through 
to get "memcpy()" to generate ok code for trivial fixed-sized cases.

(That said, I think __builtin_memcpy() does a reasonable job these days 
with gcc, and we might drop the crap one day when we can trust the 
compiler to do ok. It didn't use to, and we continued using our 
ridiculous macro/__builtin_constant_p misuses just because it works with 
_all_ relevant gcc versions).

			Linus
