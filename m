Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTI0Uao (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 16:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTI0Uao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 16:30:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46977 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262190AbTI0UaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 16:30:25 -0400
Date: Sat, 27 Sep 2003 22:30:32 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Gabor MICSKO <gmicsko@szintezis.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Test] exec-shield-2.6.0-test5-G2 vs. paxtest & libsafe
In-Reply-To: <1064693831.1792.9.camel@sunshine>
Message-ID: <Pine.LNX.4.56.0309272220020.25371@localhost.localdomain>
References: <1064678738.3578.8.camel@sunshine> 
 <Pine.LNX.4.56.0309271950450.21678@localhost.localdomain>
 <1064693831.1792.9.camel@sunshine>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 27 Sep 2003, Gabor MICSKO wrote:

> >   redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test5-G3
> >   redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test5-bk12-G3
> 
> Yes, this patch really better.

> Linux sunshine 2.6.0-test5-exec-shield-nptl #3 SMP 2003. sze. 27.,

> http://www.research.avayalabs.com/project/libsafe/src/libsafe-2.0-16.tgz

[all libsafe exploits fail - good.]

> http://pageexec.virtualave.net/paxtest-0.9.1.tar.gz

> sunshine:/home/trey/exec/paxtest-0.9.1# ./paxtest
> It may take a while for the tests to complete
> Test results:
> Executable anonymous mapping             : Killed
> Executable bss                           : Killed
> Executable data                          : Killed
> Executable heap                          : Killed
> Executable stack                         : Killed

ok.

> Executable anonymous mapping (mprotect)  : Killed

this is a testsuite bug i think - anonmap.c mprotanon.c differ in nothing 
but the name string of the test.

> Executable bss (mprotect)                : Vulnerable
> Executable data (mprotect)               : Vulnerable
> Executable heap (mprotect)               : Vulnerable
> Executable shared library bss (mprotect) : Vulnerable
> Executable shared library data (mprotect): Vulnerable
> Executable stack (mprotect)              : Vulnerable

these are 'vulnerable' by design. There can be legitimate reasons to
mprotect() any of these regions. And if an attacker has enough control
over the target to execute mprotect() with precise arguments then the game
is mostly over anyway. Does anyone know the rationale of these mprotect()
tests?

> Return to function (strcpy)              : Vulnerable
> Return to function (memcpy)              : Vulnerable

it needs gcc level changes to change the stackframe layout - out of the
scope of exec-shield.

> Writable text segments                   : Vulnerable

this is a variant of the mprotect() tests too - so possible by design.

	Ingo
