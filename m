Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310637AbSDIR2S>; Tue, 9 Apr 2002 13:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310654AbSDIR2R>; Tue, 9 Apr 2002 13:28:17 -0400
Received: from oe41.law9.hotmail.com ([64.4.8.98]:63750 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S310517AbSDIR2P>;
	Tue, 9 Apr 2002 13:28:15 -0400
X-Originating-IP: [66.108.18.44]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Martin Dalecki" <dalecki@evision-ventures.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <OE379mspgEOI7vDcPp200002a4c@hotmail.com> <3CB2BA4C.80200@evision-ventures.com>
Subject: Re: C++ and the kernel
Date: Tue, 9 Apr 2002 13:27:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE41N5ielKpVjIvFt9D0000481d@hotmail.com>
X-OriginalArrivalTime: 09 Apr 2002 17:28:09.0866 (UTC) FILETIME=[EB27FEA0:01C1DFEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Martin Dalecki" <dalecki@evision-ventures.com>
To: "T. A." <tkhoadfdsaf@hotmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Tuesday, April 09, 2002 5:54 AM
Subject: Re: C++ and the kernel


> >     So far my overloading of "new" works if I compile the module without
> > exceptions (-fno-exceptions).  This is fine for myself as I prefer
checking
>> snip <<
> > include exception support if possible so those whom may want to use it,
>
> This will turn out to be nearly impossible. Please note that
> the exception mechanisms in C++ are basically a second function
> return path and are therefore not desirable at all for the following
reasons:
>
> 1. It's silly becouse we have already a return path and page fault based
>     exception mechanisms in kernel, which is far better suited for the
purposes
>     of the kernel then the C++ semantics. (Remarkable the KDE people
recognize
>     that C++ exceptions are not a good thing...)
>
> 2. It's changing the stack layout for the kernel functions, and there
>     are few of them which rely on a particular stack layout (namely the
>     scheduler and some *.S files - look out for the asmlinkage
attribute...)

    Well I don't really need (or like) exceptions so forgetting about them
works for me.  However currently there is no other efficient means of
determining if an error has occured during a objects construction.  No
return value.  Would have to waste memory on a flag variable.  Would the
above problems also be present on the module level?  I don't really want
exceptions leaving the module, so to speak.

> >
> > int init_module()
__attribute__((alias(mangle_name("load__9my_module"))));
> > int cleanup_module()
> > __attribute__((alias(mangle_name("unload__9my_module"))));
>
> I guess the above wouldn't work due to the games which the linkage scripts
> play already on the init_module and cleanup_module function.
> Maybe you would rather wan't to have a look at those scripts themself
> and adjust them accordingly? (Possibly having a mangling tool at hand...)

    Do you mean the module_[init|exit] macros?  If so I've already taken a
look at them.  Thats where I got the alias from.  And the above does work.
However currently I have to compile the module, do nm on it, find the magled
name, and enter it manually as above; then recompile.  Works though.

> > my_module mod1;
>
> Well the "hidden C++" initializations you should propably forget
> about - they are not desirable inside the kernel, becouse this
> C++ mechanism is annihilating the expliciticity of the programm controll
> flow of C.

    Oh well works for me.  Pointers to objects will get the job done.

> >     Would patches be welcomed for one or more of these issues?
>
> Personally I would just like to have the ability to compile the
> kernel with C++ just for the following two reaons:
>
> 1. C++ is a bit tighter on type checking, which would give better
regreesions.
>
> 2. Modern GCC versions generate generally better code for C if compiled as
C++
>     files, since the language gives tighter semantics to some constructs.
>
> However I wouldn't for certainly like to see the kernel beeing transformed
> in to C++. Expierence has shown over time that the chances for abuse of
this
> programming language are just too high. Language design idiocies like the
> following come immediately in to mind:
>
> 1. Templates.
>
> 2. Runtime Type Information.
>
> 3. Operator overloading. This makes the language morphable which is
killing
> nearly the ability to understand code by reading it.
>
> 4. Syntactically hidden code paths
> (exceptions, constructors with side effects, destructors which you never
know
> when they tis you...) make the readability even worser...
>
> 5. Instability of compiler implementations (ever wondered how many
libstdc++ you
> have on your linux system?)

    Don't worry, not looking to do a C++ rewrite.  Just looking to be able
to setup a C++ framework for use in modules.
