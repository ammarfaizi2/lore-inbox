Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132893AbRDENPB>; Thu, 5 Apr 2001 09:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132894AbRDENOl>; Thu, 5 Apr 2001 09:14:41 -0400
Received: from ppp43.ts3-2.NewportNews.visi.net ([209.8.198.171]:64755 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S132893AbRDENOk>; Thu, 5 Apr 2001 09:14:40 -0400
Date: Thu, 5 Apr 2001 09:13:02 -0400
From: Ben Collins <bcollins@debian.org>
To: "Sarda?ons, Eliel" <Eliel.Sardanons@philips.edu.ar>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: asm/unistd.h
Message-ID: <20010405091302.S17338@visi.net>
In-Reply-To: <A0C675E9DC2CD411A5870040053AEBA0284170@MAINSERVER>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <A0C675E9DC2CD411A5870040053AEBA0284170@MAINSERVER>; from Eliel.Sardanons@philips.edu.ar on Thu, Apr 05, 2001 at 09:58:43AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2001 at 09:58:43AM -0300, Sarda?ons, Eliel wrote:
> I'm taking a look at the linux code and I don't understand how do you
> programm...mmm (?) may be i'm a stupid why in include/asm/unistd.h in some
> macros you use this:
> 
> do {
> ...
> } while (0)

Imagine a macro of several lines of code like:

#define FOO(x) \
	printf("arg is %s\n", x); \
	do_something_useful(x);

Now imagine using it like:

	if (blah == 2)
		FOO(blah);

This interprets to

	if (blah == 2)
		printf("arg is %s\n", blah);
		do_something_useful(blah);;

As you can see, the "if" then only encompasses the printf, and the
do_something_useful() call is unconditional (not within the scope of the
if), like you wanted it.

So, by using a block like do{...}while(0), you would get this:

	if (blah == 2)
		do {
			printf("arg is %s\n", blah);
			do_something_useful(blah);
		} while (0);

Which is exactly what you want.

-- 
 -----------=======-=-======-=========-----------=====------------=-=------
/  Ben Collins  --  ...on that fantastic voyage...  --  Debian GNU/Linux   \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
