Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292895AbSB0UbU>; Wed, 27 Feb 2002 15:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292939AbSB0UbE>; Wed, 27 Feb 2002 15:31:04 -0500
Received: from ns.suse.de ([213.95.15.193]:64528 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292936AbSB0U2X>;
	Wed, 27 Feb 2002 15:28:23 -0500
To: Artiom Morozov <artiom@phreaker.net>
Cc: linux-kernel@vger.kernel.org, Kiretchko Serguei <spk@csp.org.by>
Subject: Re: select() call corrupts stack
In-Reply-To: <20020227214056.A6740@cyan.csp.org.by>
X-Yow: My BIOLOGICAL ALARM CLOCK just went off..  It has noiseless
 DOZE FUNCTION and full kitchen!!
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 27 Feb 2002 21:28:07 +0100
In-Reply-To: <20020227214056.A6740@cyan.csp.org.by> (Artiom Morozov's
 message of "Wed, 27 Feb 2002 21:40:56 +0200")
Message-ID: <jek7sypt48.fsf@sykes.suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Artiom Morozov <artiom@phreaker.net> writes:

|> Hello,
|> 
|> 	Here's a sample program. Try running it and open about 2k of
|> 	connections to port 5222 (you'll need ulimit -n 10000 or like
|> 	that). It will segfault. Simple asm like this
|>    __asm__(
|> 	"pushl %eax \n\t" 	"movl  0(%ebp), %eax \n\t"
|> 	"cmp   $65535, %eax \n\t"
|> 	"ja isok \n\t"
|> 	"xor  %eax, %eax \n\t"
|> 	"movl  %eax, 0(%eax) \n\t"	 	"isok: \n\t"
|> 	"popl  %eax \n\t"
|>    );
|> after each subroutine call will show you that after select() [ebp] have
|> weird value. While this is unlikely to be a security flaw, i think this is
|> a bug.
|> 
|> ps: it's okay for 1k of connections or so

/* Number of descriptors that can fit in an `fd_set'.  */
#define __FD_SETSIZE	1024

Use poll(3) instead.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
