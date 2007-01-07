Return-Path: <linux-kernel-owner+w=401wt.eu-S932383AbXAGE1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbXAGE1X (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 23:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbXAGE1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 23:27:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:51202 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932383AbXAGE1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 23:27:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R3CP/qm2pywgNfWAhiCxnOgQwPsSw4BoHM0NPtxKGG2mwDPmvUqCqIJcdC+RAxWejzjhr7LjUXdeYPjVDGvXwAcZVm/uWYwlFYCJg4KDMCjS5k3GXj/hMrJrxM5ZWH/2Wl4na0XPv9fA49P7lxqhPMKCuKxDVEFI5kN88dX/QV8=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Sun, 7 Jan 2007 05:25:45 +0100
User-Agent: KMail/1.8.2
Cc: Albert Cahalan <acahalan@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, bunk@stusta.de,
       mikpe@it.uu.se
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com> <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com> <Pine.LNX.4.64.0701040921010.3661@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701040921010.3661@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701070525.45974.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 January 2007 18:37, Linus Torvalds wrote:
> With 7+ million lines of C code and headers, I'm not interested in 
> compilers that read the letter of the law. We don't want some really 
> clever code generation that gets us .5% on some unrealistic load. We want 
> good _solid_ code generation that does the obvious thing.
> 
> Compiler writers seem to seldom even realize this. A lot of commercial 
> code gets shipped with basically no optimizations at all (or with specific 
> optimizations turned off), because people want to ship what they debug and 
> work with.

I'd say "care about obvious, safe optimizations which we still not do".
I want this:

char v[4];
...
	memcmp(v, "abcd", 4) == 0

compile to single cmpl on i386. This (gcc 4.1.1) is ridiculous:

.LC0:
        .string "abcd"
        .text
...
        pushl   $4
        pushl   $.LC0
        pushl   $v
        call    memcmp
        addl    $12, %esp
        testl   %eax, %eax

There are tons of examples where you can improve code generation.
--
vda
