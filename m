Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275261AbTHMQYH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 12:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275269AbTHMQYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 12:24:07 -0400
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:49441 "EHLO
	mail.trasno.org") by vger.kernel.org with ESMTP id S275261AbTHMQYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 12:24:03 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brandon Stewart <rbrandonstewart@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Requested FAQ addition - Mandrake and partial-i686 platforms
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <1060705037.12532.49.camel@dhcp22.swansea.linux.org.uk> (Alan
 Cox's message of "12 Aug 2003 17:17:18 +0100")
References: <3F38FE5B.1030102@yahoo.com>
	<1060705037.12532.49.camel@dhcp22.swansea.linux.org.uk>
Date: Wed, 13 Aug 2003 18:24:00 +0200
Message-ID: <864r0lwmov.fsf@trasno.mitica>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Hi

alan> gcc i686 mode outputs cmov instruction sequences without checking cmov
alan> is present at runtime. So gcc "i686" is actually "i686 and a bit". It
alan> actually doesn't really make sense to do a true i686 mode without cmov
alan> either.

alan> Red Hat's rpm knows about this so I'm suprised the Mandrake one gets it
alan> wrong and installs arch=686 packages without checking for cmov.

again, it is a bit more complex than that :p

Mandrake glibc _alsa_ has a /lib/i686/ directory (i.e. it is not a
separate package).  ld.so looks at the architecture for choice about
what lib to load.

Problem, as others stated is that kernel i686 definition and gcc i686
definition are different (gcc definition is i686+cmov basically).

Mandrake kernels workaround that telling ld.so that i686 without cmov
are i586 class machines, not i686 class machines.

It will be more elegant to make the decission in ld.so, but there are
other problems with dlopen() that I don't remember.

To make things worse, via c3 implement cmov instruction if all
operands are in registers (i.e. no operand in memory), I know that
this faked somebody that did a test on cmov :(

To make history more intersting, new Via C3 have a complet cmov
instruction.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
