Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266486AbRGDDZO>; Tue, 3 Jul 2001 23:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266485AbRGDDZD>; Tue, 3 Jul 2001 23:25:03 -0400
Received: from smarty.smart.net ([207.176.80.102]:32785 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S266399AbRGDDYt>;
	Tue, 3 Jul 2001 23:24:49 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200107040337.XAA00376@smarty.smart.net>
Subject: Why Plan 9 C compilers don't have asm("")
To: linux-kernel@vger.kernel.org
Date: Tue, 3 Jul 2001 23:37:28 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because it's messy and unnecessary. Break this into asmlinkbuild, 
asmlink.c, asmlink.h and asmlink.S, chmod +x asmlinkbuild, run it, and
behold a 6. 
__________________________________________________________________

#..........................................................
# asmlinkbuild

gcc -c  asmlink.S
gcc -o asmlinked asmlink.c asmlink.o
asmlinked

cat asmlinkbuild asmlink.S asmlink.c > asmlink.post


/* ***************************************************
 asmlink.S

int bla (int ha, int hahaha, int uh) ;

That does...

        push uh
        push hahaha
        push ha

*/

.globl bla
bla:
        add 4(%esp), %eax
        add 8(%esp), %eax
        add 12(%esp), %eax
        ret



/* ********************************************   asmlink.c */
#include "asmlink.h"


int main () {
        printf("%d\n", bla(1, 2 , 3 ) ) ;

}

_________________________________________________________________

That's with the GNU tools, without asm(), and without proper declaration
of printf, as is my tendency. I don't actually return an int either, do I?
LAAETTR.

In other words, if you know the push sequence of your C compiler's
function calls, you don't need asm("");. x86 Gcc is "push last declared
first, return in EAX". Plan 9 guys, not surprisingly, seem to prefer to
keep C as C, and asm as asm. I encountered this while trying to build
Linux 1.2.13 with current GNU tools. It breaks on changes in GNU C
asm()'s. Rather a silly thing to break on, eh?

I don't think this is much less clear than the : "=r" $0;  stuff, if at
all. This thing didn't take as long to code as it did to construct this
post. Perhaps the C-labels-in-asms optimizes better. I doubt if it's by
much, or if it's worth it.

Oops. I didn't include asmlink.h in the above, except as a comment
in asmlink.S. Here it is by itself...

/* ********************************************asmlink.h*/
int bla (int ha, int hahaha, int uh) ;


Another easy win from Plan 9 that's related to this but that is not in
evidence here is that this thing on Plan 9 could build asmlinkbuild for
itself on the fly based on #pragma's in the headers that simply state what
library they are the header for. This to me is so obviously an improvement
to the usual state of affairs, an ornate system of dead-ends, as to be
depressing. The guys that wrote UNIX don't do such things to themselves
anymore.

Rick Hohensee
:; cLIeNUX /dev/tty11  11:00:14   /
:;d
ABOUT        LGPL         boot         device       log      subroutine
ABOUT.Linux  Linux        command      floppy       mounts       suite
GPL          README       configure    guest        owner        temp
H3nix        RIGHTS       dev          help         source
:; cLIeNUX /dev/tty11  22:44:25   /
:;










