Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSDCMso>; Wed, 3 Apr 2002 07:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310258AbSDCMse>; Wed, 3 Apr 2002 07:48:34 -0500
Received: from ns.suse.de ([213.95.15.193]:32008 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293457AbSDCMsW>;
	Wed, 3 Apr 2002 07:48:22 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops cleanup 2/4
In-Reply-To: <E16sbHn-0005uY-00@wagner.rustcorp.com.au>
X-Yow: Toes, knees, NIPPLES.  Toes, knees, nipples, KNUCKLES...
 Nipples, dimples, knuckles, NICKLES, wrinkles, pimples!!
 I don't like FRANK SINATRA or his CHILDREN.
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 03 Apr 2002 14:48:08 +0200
Message-ID: <jeit79dk3b.fsf@sykes.suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:

|> Linus, please apply (no object code changes).
|> 
|> The following are arrays:
|> 	boot_cpu_data.x86_capability
|> 	dev->bus->devmap.devicemap
|> 	tty->process_char_map
|> 
|> They don't need the & in front of them: "&array" is defined to be the
|> same as "array" (only reference I can find is the ANSI C "changes
|> since K&R" section).

Wrong.

|> For some reason, gcc (at least 2.95) gives a warning on these when
|> passed as unsigned long *.  I think this is a gcc bug...

gcc is correct.  "&array" and "array" are different.  While they represent
the same address, the types are not compatible.  Eg. for "int array[5]"
the type of "array" is "int [5]" (decaying to "int *" in most contexts),
but the type of "&array" is "int (*)[5]" (pointer to array of 5 ints).
And "(&array)[1]" is quite different from "(array)[1]".

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
