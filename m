Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQKLX3r>; Sun, 12 Nov 2000 18:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbQKLX3h>; Sun, 12 Nov 2000 18:29:37 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:10504 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129092AbQKLX3b>;
	Sun, 12 Nov 2000 18:29:31 -0500
Message-ID: <3A0F27B6.3B4CF1AC@mandrakesoft.com>
Date: Sun, 12 Nov 2000 18:28:54 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu,
        Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.0.11.3: sysctl.h fixes
In-Reply-To: <200011121430.JAA22978@havoc.gtf.org> <14863.8573.827836.127665@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> The declaration of:
> 
>   struct file;
> 
> in sysctl.h is a bit counter intuitive isn't it?

Nope.  It's a useful technique that I was reminded of recently by DaveM.

Have you ever looked at the -nasty- include nesting that occurs because
key kernel headers include other key kernel headers all the time?  Its
way past time to reverse that trend.  Using "struct foo;" at the
beginning of the header simply passes on the task of including the
definiton for 'struct foo' down the line, avoiding another level of
include nesting.


But... that said.  Provided no other kernel code is similarly broken,
your fix to md.c, Neil, is definitely superior to adding includes and
'struct file;' to sysctl.h.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
