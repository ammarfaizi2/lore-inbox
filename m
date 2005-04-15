Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVDOVAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVDOVAo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 17:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVDOVAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 17:00:44 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:15824 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261970AbVDOVAi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 17:00:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s7dfjCRV97E4F06+uRBGLCdjJeK4CK9YFMsWTcGIXvhEhwbuGf4H27YtmuuP75pMCbST4bbbgTe7i08El0XYKSYliaYlA1JSV5iGhBFF8oEnPtvuS4b18UzA4Ajo2JixJpjHIF0ujyvBOeChpoLYxpw4TcZW1ejPlybaUryNUzg=
Message-ID: <e1e1d5f4050415140062b04954@mail.gmail.com>
Date: Fri, 15 Apr 2005 14:00:36 -0700
From: Daniel Souza <thehazard@gmail.com>
Reply-To: Daniel Souza <thehazard@gmail.com>
To: linux-os@analogic.com
Subject: Re: intercepting syscalls
Cc: Arjan van de Ven <arjan@infradead.org>,
       Igor Shmukler <igor.shmukler@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0504151628210.662@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6533c1c905041511041b846967@mail.gmail.com>
	 <1113588694.6694.75.camel@laptopd505.fenrus.org>
	 <6533c1c905041512411ec2a8db@mail.gmail.com>
	 <e1e1d5f40504151251617def40@mail.gmail.com>
	 <6533c1c905041512594bb7abb4@mail.gmail.com>
	 <e1e1d5f40504151310467d16bd@mail.gmail.com>
	 <1113596014.6694.87.camel@laptopd505.fenrus.org>
	 <e1e1d5f4050415131977a776e9@mail.gmail.com>
	 <Pine.LNX.4.61.0504151628210.662@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this can be done by overwriting libc calls or patching httpd
process at runtime to overwrite open() at libc address map, and get
open() calls trapped just for apache. BUT, let's figure a scenario: GD
has a buffer overflow bug that when it tries to get the size of a
existing malformed image (that can be uploaded by any user at web
app), it segfaults. It's a exploitable bug, and a attacker sucessfully
exploit it, binding a shell. Shellcodes don't make use of libc calls.
Instead, they use direct asm calls to trigger system calls that they
need to use (execve(), dup() for example of a connect-back shellcode).
Your method will not trigger that exploitation, but a kernel-level
wrapper will see that "/bin/sh" got executed by httpd, what is...
unacceptable. Yes, I can patch the whole libc and expect when the
attacker issue any "ls -la" that WILL be triggered by your patched
libc wrapper. But I dont like userland patches like that (in fact, I
prefer to avoid libc hackings like that). Imagine a libc wrapper that
inside a read(), it makes a syslog() or anything to log... a simple
strace will catch it up.

Returning to the topic context... the kernel sees everything. Libc
just accept that and live with, as a wife =) I prefer to be the
husband one...



-- 
# (perl -e "while (1) { print "\x90"; }") | dd of=/dev/evil
