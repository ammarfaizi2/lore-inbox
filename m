Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267101AbUBMQiq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267109AbUBMQip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:38:45 -0500
Received: from gaia.di.uniba.it ([193.204.187.131]:13065 "EHLO
	gaia.di.uniba.it") by vger.kernel.org with ESMTP id S267101AbUBMQiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:38:17 -0500
Date: Fri, 13 Feb 2004 17:38:15 +0100
From: "Angelo Dell'Aera" <buffer@antifork.org>
To: Valdis.Kletnieks@vt.edu
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Giuliano Pochini <pochini@shiny.it>, Michael Frank <mhf@linuxmail.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Message-Id: <20040213173815.256d5bac.buffer@antifork.org>
In-Reply-To: <200402131548.i1DFmECc020354@turing-police.cc.vt.edu>
References: <20040213124232.B2871@pclin040.win.tue.nl>
	<XFMail.20040213145513.pochini@shiny.it>
	<20040213153542.29686f0f.buffer@antifork.org>
	<200402131548.i1DFmECc020354@turing-police.cc.vt.edu>
Organization: Antifork Research, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-PGP-Program: GNU Privacy Guard (http://www.gnupg.org)
X-PGP-PublicKey: http://buffer.antifork.org/privacy/buffer-gpg.asc
X-PGP-Fingerprint: 48CC B0D8 C394 CD30 355F E36D A4E3 48CF 19C1 5CA2
X-Operating-System: GNU-Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 13 Feb 2004 10:48:14 -0500
Valdis.Kletnieks@vt.edu wrote:

>> I think you're really wrong since "deeply nested" means exactly "unreadable 
>> and badly structured" and you could easily realize it by simply spending ~10 
>> hours per day coding and/or taking a look at the code written by someone 
>> which is not you. A simple use of inline functions and a previous thinking 
>> about what you're going to write could easily solve all problems. 

>It might help, but a blind belief that "if I inline things it will all be
>better" won't solve all the problems.  In particular, for the example you
>replied to:

I'm not saying "just inline anything and you'll solve problems". I'm saying
that if your design is well done and you consider the availability of the
inlines your code will surely be better. And maybe you wouldn't need to discuss
why the current limit is 80...

>>>1 tab in the function, 1tab a switch, 1 if, 1 for, 1 if and you have already
>>>lost half of the available space.

>you may very well be advocating the inlining of a 3 or 4 line code segment,
>and moving it to someplace far away in the .c file.  Certainly the compiler
>can probably manage to generate the same code, but now you're condemning
>the next person who reads this code to go flipping back and forth through
>the file to find the only-used-once and unfamiliar function to see what
>this for(;;) loop does.

I prefer going flipping back and forth rather than reading an uncomprehensible 
source. Simpler functions may be analyzed and debugged in a faster way. If
you dislike going back and forth by hand some tools could help you (think 
about cscope). Taking a look at the kernel code it's easy to realize I'm not 
the only one thinking so...

Moreover, if you take a look at the kernel code you'll realize that well 
written code usually defines inlines you really shouldn't need to read since 
their names are quite often self-explaining. Taken from CodingStyle "If you 
have a function that counts the number of active users, you should call that 
"count_active_users()" or similar, you should _not_ call  it "cntusr()"." 

Please don't think simply at those who are reading the code. Think about the 
persons which wrote that code which want to remember what they did two weeks 
before...

>Oh, and it gets very ugly if you have this:
>
>	switch
>		if (foo) {
>			for (ptr=first; ptr->next!=NULL; prt->next) {
>				if (!(ptr->somedata))
>					goto have_to_drop_dead_now;
>				/* more code that deals with ptr-> here */
>
>Creating an inline function for that is going to be.. interesting. :)

You could create a lot of examples where it's difficult to create an
inline.. but they're just examples! There are a lot of ways for writing
the same code and maybe if your example was taken from a real-life code
it could be written in a different and more easy-to-read manner. 

Regards.

- --

Angelo Dell'Aera 'buffer' 
Antifork Research, Inc.	  	http://buffer.antifork.org

PGP information in e-mail header


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFALP13pONIzxnBXKIRAsddAJ0UkI8RkgyVsCe9CEgCAq3OjT3X6wCfZFOE
b7fPjRZw+/Dfv05H+aO6tpw=
=KXgO
-----END PGP SIGNATURE-----
