Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUASOVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 09:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUASOVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 09:21:55 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:31187 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S265118AbUASOVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 09:21:46 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Richard B. Johnson" <root@chaos.analogic.com>
Date: Mon, 19 Jan 2004 15:21:24 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Compiling C++ kernel module + Makefile
Cc: Ashish sddf <buff_boulder@yahoo.com>, linux-kernel@vger.kernel.org,
       bart@samwel.tk
X-mailer: Pegasus Mail v3.50
Message-ID: <11E4AA0152B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jan 04 at 8:46, Richard B. Johnson wrote:
> On Sat, 17 Jan 2004, Bart Samwel wrote:
> 
> > On Friday 16 January 2004 23:07, Richard B. Johnson wrote:
> > > If somebody actually got a module, written in C++, to compile and
> > > work on linux-2.4.nn, as you state, it works only by fiat, i.e., was
> > > declared to work. There is no C++ runtime support in the kernel for
> > > C++. Are you sure this is a module and not an application? Many
> > > network processes (daemons) are applications and they don't require
> > > any knowledge of kernel internals except what's provided by the
> > > normal C/C++ include-files.
> >
> > Rest assured, ;) this is definitely a module. It includes a kernel patch that
> > makes it possible to include a lot of the kernel headers into C++, stuff like
> > changing asm :: to asm : : (note the space, :: is an operator in C++) and
> > renaming "struct namespace" to something containing less C++ keywords. The
> > module also includes rudimentary C++ runtime support code, so that the C++
> > code will run inside the kernel. I'm afraid that the task of compiling it for
> > 2.6 is going to be pretty tough -- the kernel needs loads of patches to make
> > it work within a C++ extern "C" clause, and it probably completely different
> > patches from those needed by 2.4. Getting the build system to work is the
> > least of the concerns.
> >
> > -- Bart
> >
> 
> I can't imagine why anybody would even attempt to write a kernel
> module in C++. Next thing it'll be Visual BASIC, then Java. The
> kernel is written in C and assembly. The tools are provided. It
> can only be arrogance because this whole C v.s. C++ thing was
> hashed-over many times. Somebody apparently wrote something to
> "prove" that it can be done. I'd suggest that you spend some
> time converting it to C if you need that "module". The conversion
> will surely take less time than going through the kernel headers
> looking for "::".

I doubt. I have module which uses templates to get support for
couple of possible userspace interfaces which existed over time,
and it works very well, without any changes to the kernel headers. Only
thing I had to do was:

#ifdef __cplusplus
#  define new new_member
#  define private private_member
#  define namespace namespace_member
#endif

and extern "C" around #includes.

Of course that it is possible to do everything what templates do with
#define, but why do that in complicated ways if it can be done much
simpler?

Of course this module does not use exceptions or rtti, just templates
and static class members.
                                                    
Module compiles on 2.2.0 to 2.6.1, with gcc 2.95-3.4. If you'll limit
yourself to gcc-3.0 or later, you do not have to worry about ::/: : at all,
as gcc's c++ parser gets it right after 2.95.
                                                    Petr Vandrovec

