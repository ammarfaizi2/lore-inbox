Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbTDKJJa (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 05:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbTDKJJa (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 05:09:30 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:40670 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S262835AbTDKJJ2 (for <rfc822;Linux-Kernel@vger.kernel.org>); Fri, 11 Apr 2003 05:09:28 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Linux Kernel List" <Linux-Kernel@vger.kernel.org>,
       "Robert White" <rwhite@casabyte.com>
Subject: Re: kernel support for non-English user messages
Date: Fri, 11 Apr 2003 10:21:17 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAKEBJCGAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGMEPICGAA.rwhite@casabyte.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

