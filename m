Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284610AbRLETfQ>; Wed, 5 Dec 2001 14:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280980AbRLETfI>; Wed, 5 Dec 2001 14:35:08 -0500
Received: from alageremail2.agere.com ([192.19.192.110]:50925 "EHLO
	alageremail2.agere.com") by vger.kernel.org with ESMTP
	id <S284603AbRLETe5>; Wed, 5 Dec 2001 14:34:57 -0500
From: "Michael Smith" <smithmg@agere.com>
To: "'Tommy Reynolds'" <reynolds@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Unresolved symbol memset
Date: Wed, 5 Dec 2001 14:35:03 -0500
Organization: Agere Systems
Message-ID: <00d701c17dc3$f059db80$4d129c87@agere.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20011205131659.3af1bafa.reynolds@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Taking your advice I removed the header memory.h and switched the
include for string.h to be linux/string.h.  This seemed to fix the
problem.  I thank you all for your input and appreciate the time you all
took

Michael

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Tommy Reynolds
Sent: Wednesday, December 05, 2001 2:17 PM
To: Michael Smith
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbol memset

More important activities lacking, "Michael Smith" <smithmg@agere.com>
wrote:

> That particular header is included.  As I mentioned, I am using memset
> in other areas of the code, as well as the same file.  If I take this
> one call out of the source, it compiles, links and I am able to
perform
> and insmod correctly.  Below are the headers that are included in the
> file, and the area of the code that is causing the problem.  Let me
say
> that the code, even with this particular call in, compiles and links.
> The problem happens when I go to perform the insmod on it.
> 
> #include <memory.h>
> #include <string.h>
> #include "myownheaders.h"
> 
> 
> void myfunction( void *a, int len )
> {
> ....
> Mymemmove() //used because NdisMoveMemory can not be used
> memset( &a->WORD[NUMWORDS-len], 0, len*4);
> ...
> }

Inside a driver (or module) file, any include reference that doesn't
begin with
either <linux/foo.h> or <asm/foo.h> should always raise a red flag.
There are
user-land header files ("/usr/include") and kernel header files
("/usr/src/linux/include") and never the twain shall meet.

Mixing includes is always a bad idea.

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- + -- -- -- -- -- -- -- --
-- --
Tommy Reynolds                               | mailto:
<reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

