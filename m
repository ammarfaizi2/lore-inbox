Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbTEHJqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 05:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTEHJqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 05:46:11 -0400
Received: from elin.scali.no ([62.70.89.10]:3753 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S261261AbTEHJqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 05:46:09 -0400
Subject: Re: The disappearing sys_call_table export.
From: Terje Eggestad <terje.eggestad@scali.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "arjanv@redhat.com" <arjanv@redhat.com>, Steffen Persvold <sp@scali.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200305071507_MC3-1-37CF-FE32@compuserve.com>
References: <200305071507_MC3-1-37CF-FE32@compuserve.com>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1052387912.4849.43.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 May 2003 11:58:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess something like this:

typedef int (*syscall_hook_t)(void * arg1, void * arg2, void * arg3,
void * arg4, void * arg5, void * arg6);

#define HOOK_IN_FLAG 0x1
#define HOOK_OUT_FLAG 0x2

opaquehandle = int register_syscall_hook(int syscall_nr, syscall_hook_t
hook_function, int flags);
int unregister(int opaquehandle);

I'd make a stab at it if I knew that it stood a chance of getting
accepted. 

TJ 


On Wed, 2003-05-07 at 21:04, Chuck Ebbert wrote:
> >> Preloading libraries, ptracing init, patching g/libc, etc. are
> >> obviously not the way to go.
> >
> > those obviously need to be implemented via the security subsystem (eg
> > LSM). Hooks are obviously the wrong level to do things and I could even
> > tell you that you cannot implement this right from a module actually.
> 
>   What is really needed is some kind of proper generic hooking setup
> that could be used both by LSM and other things.  People doing this
> may need to intercept syscalls both on their way to the kernel and 
> on the way back to userland (so they can see return codes.)  They may
> also need to say whether they want to be first or last if there are
> multiple users of this facility.
> 
>   But the real question is why the export of sys_call_table was so
> gratuitously removed without any kind of replacement being offered.
> And the attitude of the developers about it is truly awful. ("Oh, so
> we broke the drivers you depend on for your livelihood?  You can just
> go get a new job -- pounding sand down a rathole.")
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

