Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267684AbRGZI6W>; Thu, 26 Jul 2001 04:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267685AbRGZI6N>; Thu, 26 Jul 2001 04:58:13 -0400
Received: from ns.suse.de ([213.95.15.193]:29957 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S267684AbRGZI6D>;
	Thu, 26 Jul 2001 04:58:03 -0400
To: Thorsten Kukuk <kukuk@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, Leif Sawyer <lsawyer@gci.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Sparc-64 kernel build fails on version.h during 'make oldconfig'
In-Reply-To: <BF9651D8732ED311A61D00105A9CA315053E1265@berkeley.gci.com>
	<15199.18841.458617.411246@pizda.ninka.net>
	<20010726064237.A26837@suse.de>
X-Yow: Yow!  Now I get to think about all the BAD THINGS I did to a BOWLING BALL
 when I was in JUNIOR HIGH SCHOOL!
From: Andreas Schwab <schwab@suse.de>
Date: 26 Jul 2001 10:58:01 +0200
In-Reply-To: <20010726064237.A26837@suse.de> (Thorsten Kukuk's message of "Thu, 26 Jul 2001 06:42:37 +0200")
Message-ID: <je1yn4kqxy.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.105
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Thorsten Kukuk <kukuk@suse.de> writes:

|> No, I send you and on the sparclinux list already a patch for 
|> this 2 weeks ago. The problem is, that make dep will build at first
|> sparc specific programs (archdep) which needs linux/version.h, but 
|> make dep does create linux/version.h only after building this tools. The
|> following patch solved the problem for me:
|> 
|> --- linux/Makefile
|> +++ linux/Makefile      2001/05/21 12:57:07
|> @@ -440,7 +440,7 @@
|>  sums:
|>         find . -type f -print | sort | xargs sum > .SUMS
|>  
|> -dep-files: scripts/mkdep archdep include/linux/version.h
|> +dep-files: include/linux/version.h scripts/mkdep archdep

This will still fail with parallel builds.  Better make the dependency of
archdep on version.h explicit.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
