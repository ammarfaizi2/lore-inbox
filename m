Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTDKUiD (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTDKUiD (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:38:03 -0400
Received: from mail.casabyte.com ([209.63.254.226]:65031 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S261743AbTDKUh6 (for <rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 16:37:58 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Riley Williams" <Riley@Williams.Name>,
       "Linux Kernel List" <Linux-Kernel@vger.kernel.org>
Subject: RE: kernel support for non-English user messages
Date: Fri, 11 Apr 2003 13:49:41 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGGEBPCHAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <BKEGKPICNAKILKJKMHCAKEBJCGAA.Riley@Williams.Name>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, my final point had been that doing it inside the kernel itself, or
indeed inside klogd, was probably a very bad idea.  If the translation
always happens after-the-fact based on properly harvested message semantics
then any segment of messages distributed into this mailing list (among other
uses) would be

A)  Still in English.
B)  Translatable after the fact there too.

Also after-the-fact translation makes the language translations a scalar
problem instead of a matrixed one.  That is, if you always pass the message
stream around in English (treat it like n opaque source file) and then
translate it as necessary, it will "always work".

If you try to do the translations at message generation time, then the
translation must be any-language-to-any-language capable during post-even
discussions.  Not good.

Also, you will always have leakage as people add new strings to the set.

As for the #define issues, when you process the source tree to build the
source matrix you just "gcc -E file.c | collector" and now the printk case
you mention is handled.  Any module designer who does uglier things can make
a dead-code procedure that expresses his possible output strings for
collection (if he cares.)

{Satire}
Speaking as an arrogant (U.S. of) American who knows that God(TradeMark, all
rights reserved) decreed that he never had to learn any language but his
own, I can honestly state, that it is nearly certain that you will get no
real support for the multi-language kernel out of a us USAmericans.  We
can't even get ourselves to write decent comments, and on the average, we
all secretly believe that if we just speak slowly enough everybody really
knows English.  After all, that's how our condescending "wouldn't want to
fail Johnny, it would be bad for his self-image" public schools taught us in
the first place.... 8-)
{/Satire}

Rob.

-----Original Message-----
From: Riley Williams [mailto:Riley@Williams.Name]
Sent: Friday, April 11, 2003 2:21 AM
To: Linux Kernel List; Robert White
Subject: Re: kernel support for non-English user messages


Hi Robert.

 > It is tautologically true that every printk starts with a format
 > string, and that "really" the kernel has no business "switching
 > languages" on the fly. That is, like selecting the chipset, the
 > language the kernel should express it self ought to be selected
 > at compile time.

I can certainly accept such an argument for a single system. The
problem I have is with people then posting their errors on here
with the messages in a language that none of the maintainers on
here understands - how are we then expected to help them?

It is because of this requirement that I believe that message codes
in some form are unavoidable - at least with message codes, one
can look them up and find the version of the message translated
into one's own language. However, Linus has vetoed the idea of
putting such codes into the kernel in any form, and that makes the
whole idea a non-starter in any form.

Personally, I'm willing to discuss this issue and see what sort of
ideas we can come up with, and what problems each idea may have.

 > In essence, the translations have to be done earlier in the
 > process instead of later. Having or needing a tool to read the
 > log won't help someone trying to diagnose a problem where a tool
 > isn't in place and the storage requirements for after-the-fact
 > to see and use the output become unreasonable. (It's just not
 > telnet/shell friendly.)

Agreed.

 > Consider a tool that scans any source file and collects up the
 > literal strings of every printk encountered and tosses them into
 > a static array...
 >
 >	"CHAR_TYPE * KernelMessage[] = { "whatever", "whatever"...};"
 >
 > ...then replaces...
 >
 >	printk("whatever",...);
 >
 > ...with...
 >
 >	printk(KernelMessage[0],...);

It would also have to handle all the cases of...

	#define CMD_PRINT(x...)   printk(KERN_INFO x)

			:

	CMD_PRINT("This is some useless information");

...that are spread amongst various subsystems. Personally, I'd prefer
to see macros like that replaced with the printk calls directly, but
that's up to the individual subsystem maintainers.

The simple way to do this would be to insert the kernel message tool
into the compilation process immediately after the macro expansion
tool has run, as all of the above macros would have been expanded at
that time. However, this requires that the intermediate files are
all saved as part of the compilation process, otherwise this tool
would have no means of accessing the expanded macros.

 > subsequent runs of this theoretical tool will take any new prink(s)
 > found and add them to the list. For completeness, any KernelMessage
 > subscripts never used (cause the printk was removed) would get
 > burped out of the sequence at re-expression time.

We need certain guarantees for this system to be usable. See my reply
to Alan Cox on this subject for details.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.471 / Virus Database: 269 - Release Date: 10-Apr-2003

