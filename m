Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288952AbSAFNmK>; Sun, 6 Jan 2002 08:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288951AbSAFNmB>; Sun, 6 Jan 2002 08:42:01 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:34776 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S288952AbSAFNlt>; Sun, 6 Jan 2002 08:41:49 -0500
Message-ID: <3C385402.2000304@acm.org>
Date: Sun, 06 Jan 2002 14:41:22 +0100
From: Laurent Guerby <guerby@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: dewar@gnat.com
CC: paulus@samba.org, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        trini@kernel.crashing.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020106130556.99E79F2FF5@nile.gnat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dewar@gnat.com wrote:

> pragma Atomic in Ada (volatile gets close in C, but is not close enough) will
> ensure a byte store in practice, but may not ensure byte reads.


I see no distinction between read and write in the text of the Ada standard.

Also I think if you declare a byte array with Atomic_Component
and Volatile_Component and that the compiler accepts it for its
target architecture, then the compiler is required to generate
a byte read and store for each occurence in the text source.
 From C.6:

15    For an atomic object (including an atomic component) all reads and
updates of the object as a whole are indivisible.

16    For a volatile object all reads and updates of the object as a 
whole are
performed directly to memory.

20    {external effect (volatile/atomic objects) [partial]} The external
effect of a program (see 1.1.3) is defined to include each read and 
update of
a volatile or atomic object. The implementation shall not generate any 
memory
reads or updates of atomic or volatile objects other than those specified by
the program.

In my exemple byte array, if I say X := T (I) I don't see how a conformant
compiler accepting the declaration could generate anything other than
one and exactly one byte read. Per 20 it has no right to read T (I+1) or 
T(I-1)
since they are "other" objects (components to be pedantic).

Do you agree with interpretation? Now, I haven't checked what GNAT does 
there
(what's accepted and what code is generated) which is of course the 
interesting
part :).

-- 
Laurent Guerby <guerby@acm.org>

