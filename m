Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUKDTuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUKDTuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUKDTkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:40:04 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:41392 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262427AbUKDTdw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:33:52 -0500
X-OB-Received: from unknown (205.158.62.81)
  by wfilter.us4.outblaze.com; 4 Nov 2004 19:33:49 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 04 Nov 2004 14:33:49 -0500
Subject: Re: support of older compilers
X-Originating-Ip: 172.159.84.227
X-Originating-Server: ws1-2.us4.outblaze.com
Message-Id: <20041104193349.9DE511F50B1@ws1-2.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If people are willing to download and compile
>a new kernel (and migrating from 2.4 to 2.6
>is non-trivial for some systems, like RH9),
>why aren't they willing to also download
>and build a new compiler?

It is not necessarily that they are unwilling,
it is a question of trust (in the output
of the compiler) and of the inconvenience of
multiple concurrent gcc version installations
(paths; hint: this needs to be simpler).

Example:

I've been using gcc-2.95.3 with a security-patched
glibc-2.2.5, and I wanted to upgrade to glibc-2.3.2
(lots of bugs gone and more Posix/SUS compliance
added in the years in between 2.2.5 and 2.3.2).

For that I needed gcc-3.x. So, in succession,
I downloaded and compiled gcc-3.3.2, 3.4.0, and 3.4.1,
against both glibc-2.2.5 and glibc-2.3.2, with the
latest binutils at the time (which works with any
of those compiler and glibc versions).

I found that none of the gcc 3.x versions could
correctly compile a construct like this
(independent of runtime glibc version):

file1.h:

/* header boilerplate to avoid multiple #includes of
   the same file */

#define STR1  "string 1"

file2.c:

#include "file1.h"

const char * str2 = "whatever"STR1"stuff this\n\
string has in it"STR1" and so on ad infinitum\n\
"STR1"yada yada"; 

/* this was actually about 40 lines, maybe more,
   with maybe 10 instances of "../"STR1"..." */

All of the gcc-3.x versions would bail with
an error trying to compile that str2 definition
in file2.c.

They didn't always fail on literal string
concatenation (IIRC some short ones compiled
ok), but they consistently failed to concatenate
literal strings correctly for some source
files that gcc-2.95.3 would compile correctly
every time.

(The glibc trees had distributor patches, so I filed
the bug report via their support, in order for
them to see whether their patches were responsible
for the error, assuming that they would forward
it on if not.)

In sum: for production code it doesn't matter
what all a new C compiler version can do that
the old one could not if it won't compile
quite ordinary standard C correctly.

"So what else is wrong with it that we
aren't seeing?"

It would be good to have bugs fixed in the
new compilers, because they obviously have
some advantages (I noticed that gcc-3.4.x
seemed quite a bit faster than 2.95.3 when
compiling glibc, and it would nice if as
no longer randomly choked on the x86 code
generated after using -fprofile-arcs and
-fbranch-probabilities, something that
occasionally happens with gcc-2.95.3).

But one does occasionally need to get some
other work done besides new compiler
development.

-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

