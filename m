Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288283AbSACSpw>; Thu, 3 Jan 2002 13:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288281AbSACSpl>; Thu, 3 Jan 2002 13:45:41 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:52366 "HELO cygnus.com")
	by vger.kernel.org with SMTP id <S288279AbSACSpc>;
	Thu, 3 Jan 2002 13:45:32 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>,
        Paul Koning <pkoning@equallogic.com>, trini@kernel.crashing.org,
        velco@fadata.bg, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <DC4407B5751@vcnet.vc.cvut.cz> <21991.1010010254@redhat.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 03 Jan 2002 16:44:14 -0200
In-Reply-To: David Woodhouse's message of "Wed, 02 Jan 2002 22:24:14 +0000"
Message-ID: <orheq3z341.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.0805 (Gnus v5.8.5) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan  2, 2002, David Woodhouse <dwmw2@infradead.org> wrote:

> VANDROVE@vc.cvut.cz said:
>> (and for CONSTANT < 5 it of course generated correct code to fill dst
>> with string contents; and yes, I know that code will sigsegv on run
>> because of dst is not initialized - but it should die at runtime, not
>> at compile time). 

> An ICE, while it's not quite what was expected and it'll probably get fixed,
> is nonetheless a perfectly valid implementation of 'undefined behaviour'.

Not really.  Think of code whose execution is guarded by a test that
guarantees it won't invoke undefined behavior, but whose test is in a
separate translation unit.  Or even of code that is never executed.
The compiler has no business telling whether the code may potentially
invoke undefined behavior, or whether it's going to be executed at
all, it has to compile it to something that does whatever it wishes
*if* it's executed.  So, it should indeed die at runtime, not at
compile time.

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                  aoliva@{cygnus.com, redhat.com}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist    *Please* write to mailing lists, not to me
