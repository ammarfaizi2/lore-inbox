Return-Path: <linux-kernel-owner+w=401wt.eu-S964928AbXADQpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbXADQpr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbXADQpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:45:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:49543 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964928AbXADQpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:45:46 -0500
In-Reply-To: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com>
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <27e6f108b713bb175dd2e77156ef61d0@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk,
       bunk@stusta.de, mikpe@it.uu.se, torvalds@osdl.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Thu, 4 Jan 2007 17:43:36 +0100
To: "Albert Cahalan" <acahalan@gmail.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Adjusting gcc flags to eliminate optimizations is another way to go.
> Adding -fwrapv would be an excellent start. Lack of this flag breaks
> most code which checks for integer wrap-around.

Lack of the flag does not break any valid C code, only code
making unwarranted assumptions (i.e., buggy code).

> The compiler "knows"
> that signed integers don't ever wrap, and thus eliminates any code
> which checks for values going negative after a wrap-around.

You cannot assume it eliminates such code; the compiler is free
to do whatever it wants in such a case.

You should typically write such a computation using unsigned
types, FWIW.

Anyway, with 4.1 you shouldn't see frequent problems due to
"not using -fwrapv while my code is broken WRT signed overflow"
yet; and if/when problems start to happen, to "correct" action
to take is not to add the compiler flag, but to fix the code.


Segher

