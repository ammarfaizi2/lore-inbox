Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283287AbRLRBOl>; Mon, 17 Dec 2001 20:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283340AbRLRBOb>; Mon, 17 Dec 2001 20:14:31 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:24029 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S283287AbRLRBOM>; Mon, 17 Dec 2001 20:14:12 -0500
Date: Tue, 18 Dec 2001 02:14:07 +0100
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: wait() and strace -f
Message-ID: <20011218021407.A1595@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a weird problem here.  I have a process that creates 2
childs, the first one dies very fast before the parent can call
wait().  When I strace -f this wait() doesn't clean up the zombie
as it should.

Note that this problem only happens when I have 2 childeren, use
strace -f, and call wait after the first child died.  Just
strace, without strace, only 1 child, or call wait() after the
child died doesn't seem to cause the problem.

Btw, this is with 2.4.16.

Simple program to demostrate it:

int     main()
{
        int     i;

        if (!fork())
        {
                /* Child 1. */
                return 0;
        }

        if (!fork())
        {
                /* Child 2. */
                sleep(10);
                return 0;
        }

        /* Parent. */
        sleep(1);
        wait(&i);
        return 0;
}

Without strace -f, this program stops after 1 second and the
second child still lives for 9 seconds.  With strace -f this
program stops after 10 second after the second child died.

I think it's related to strace being the "real" parent of the
child.  But that doesn't really explain why I need 2 childs.


Kurt

