Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbRENTJA>; Mon, 14 May 2001 15:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262382AbRENTIu>; Mon, 14 May 2001 15:08:50 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:55312 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S262380AbRENTIi>;
	Mon, 14 May 2001 15:08:38 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: mirabilos <eccesys@topmail.de>
Date: Mon, 14 May 2001 21:07:15 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: latest-ac9 compile error (gcc3)
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <2E9088314A3@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 May 01 at 20:38, mirabilos wrote:

> I have removed the "inline" in rwsem.h as suggested, and now
> can't compile -ac9 with the following error (seems to be a
> problem in the part that loads the compressed image):

> misc.o(.text.lock+0xa): undefined reference to `rwsem_wake'

You cannot remove inline from there. For some unknown reason even
if you'll mark it as 'static', gcc3 will still emit this code into object
file. You have to change constraint from "+d" to "+r" (with
changing %edx => %0 and adding push %edx around call to rwsemwake), or
just rewrite it in the way __up_write operates (movl %2,%%edx, add
"edx" into clobbered and %2 as value assigned to tmp, patch sent last week).
 
> Compiler: gcc3-snapshot 14.5.2001

Pre-26th snapshots have some fatal bug in optimizing 
if (x) a = 123; else a = 456; :-( Look back through linux-kernel archive.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz

