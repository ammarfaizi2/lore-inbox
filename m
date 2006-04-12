Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWDLOmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWDLOmU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 10:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWDLOmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 10:42:20 -0400
Received: from spirit.analogic.com ([204.178.40.4]:43026 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751190AbWDLOmT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 10:42:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <20060412141352.4FDF914C51F@irishsea.home.craig-wood.com>
x-originalarrivaltime: 12 Apr 2006 14:42:15.0641 (UTC) FILETIME=[4ABBCC90:01C65E3F]
Content-class: urn:content-classes:message
Subject: Re: CRTSCTS wrong in man tcsetattr
Date: Wed, 12 Apr 2006 10:42:15 -0400
Message-ID: <Pine.LNX.4.61.0604121026480.1139@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CRTSCTS wrong in man tcsetattr
Thread-Index: AcZeP0rFRemhYQHuQOePUGsNVWYOlg==
References: <60Nqo-4kw-5@gated-at.bofh.it> <20060412141352.4FDF914C51F@irishsea.home.craig-wood.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Nick Craig-Wood" <nick@craig-wood.com>
Cc: "Karel Kulhavy" <clock@twibright.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Apr 2006, Nick Craig-Wood wrote:

> In linux.kernel, you wrote:
>>  Man tcsetattr in gentoo implicitly states that after
>>  #include <termios.h>
>>  #include <unistd.h>
>>
>>  CRTSCTS constant will be defined. This is however false:
>>  tty.c:38: error: `CRTSCTS' undeclared (first use in this function)
>>
>>  CRTSCTS is defined in bits/termios.h and in asm/termbits.h The question
>>  is what is the correct state of affairs?
>>  1) the manpage should say bits/termios.h instead of termios.h
>>  2) the manpage should say asm/termbits.h instead of termios.h
>>  3) the termios.h should include bits/termios.h or asm/termbits.h
>>  4) the manpage should not mention CRTSCTS at all
> 5) there is a bug in your installation
>
> Works for me in Debian testing
>
> cat <<'EOF' > z.c
> #include <termios.h>
> #include <unistd.h>
> #include <stdio.h>
>
> int main(void)
> {
>    printf("0x%08X", CRTSCTS);
>    return 0;
> }
> EOF
> gcc -Wall z.c -o z
> ./z
>
> Gives
>
> 0x80000000
>
> --
> Nick Craig-Wood <nick@craig-wood.com> -- http://www.craig-wood.com/nick
> -

No headers in the /usr/include/bits directory should never be
referenced in user code. /usr/include/termios.h picks up whatever
it needs but it is referenced to the user's environment so the
user could certainly screw it up!

Snipped header:

#ifndef	_TERMIOS_H
#define	_TERMIOS_H	1

#include <features.h>
#ifdef __USE_UNIX98
/* We need `pid_t'.  */
# include <bits/types.h>
# ifndef __pid_t_defined
typedef __pid_t pid_t;
#  define __pid_t_defined
# endif
#endif
__BEGIN_DECLS
#include <bits/termios.h>	<----------- Included here
__END_DECLS
#endif /* termios.h  */


If the user had redefined the C_INCLUDE_PATH to junk, this might
quietly fail, depending upon the gcc version.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
