Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284573AbRLES4Q>; Wed, 5 Dec 2001 13:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284572AbRLES4G>; Wed, 5 Dec 2001 13:56:06 -0500
Received: from alageremail1.agere.com ([192.19.192.106]:32708 "EHLO
	alageremail1.agere.com") by vger.kernel.org with ESMTP
	id <S284565AbRLESz6>; Wed, 5 Dec 2001 13:55:58 -0500
From: "Michael Smith" <smithmg@agere.com>
To: <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Unresolved symbol memset
Date: Wed, 5 Dec 2001 13:55:56 -0500
Organization: Agere Systems
Message-ID: <00a501c17dbe$7a6fa580$4d129c87@agere.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <Pine.LNX.4.33L2.0112051024340.22241-100000@dragon.pdx.osdl.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That particular header is included.  As I mentioned, I am using memset
in other areas of the code, as well as the same file.  If I take this
one call out of the source, it compiles, links and I am able to perform
and insmod correctly.  Below are the headers that are included in the
file, and the area of the code that is causing the problem.  Let me say
that the code, even with this particular call in, compiles and links.
The problem happens when I go to perform the insmod on it.

#include <memory.h>
#include <string.h>
#include "myownheaders.h"


void myfunction( void *a, int len )
{
....
Mymemmove() //used because NdisMoveMemory can not be used
memset( &a->WORD[NUMWORDS-len], 0, len*4);
...
}


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of
rddunlap@osdl.org
Sent: Wednesday, December 05, 2001 1:27 PM
To: Michael Smith
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbol memset

On Wed, 5 Dec 2001, Michael Smith wrote:

| Hello all,
|      I am new the Linux world and have a problem which is somewhat
| confusing.  I am using the system call memset() in kernel code written
| for Red Hat 7.1(kernel 2.4).  I needed to make this code compatible
with
| Red Hat 6.2(kernel 2.2) and seem to be getting a unresolved symbol.
| This is only happening in one place of the code in one file.  I am
using
| memset() in other areas of the code which does not lead to the
problem.
| If anyone can clue me in to what this possible can be, it would
greatly
| be appreciated.

um, memset() isn't actually a system call.
However-- does the problem source file have
#include <linux/string.h>
in it?  It should.
Or perhaps you could post the problem source file and/or
gcc messages.

-- 
~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

