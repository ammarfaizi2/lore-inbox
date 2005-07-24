Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVGXSzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVGXSzV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 14:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVGXSzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 14:55:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54718 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261440AbVGXSyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 14:54:44 -0400
Date: Sun, 24 Jul 2005 14:54:32 -0400
From: Neil Horman <nhorman@redhat.com>
To: =?iso-8859-1?Q?M=E1rcio?= Oliveira <moliveira@latinsourcetech.com>
Cc: nhorman@redhat.com, rheflin@atipa.com, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Memory Management
Message-ID: <20050724185432.GA28617@hmsendeavour.rdu.redhat.com>
References: <EXCHG2003gbLYluLCTa000004d6@EXCHG2003.microtech-ks.com> <42E17FE7.3030205@latinsourcetech.com> <20050723184540.GA1670@hmsendeavour.rdu.redhat.com> <42E2CFC4.9030701@latinsourcetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42E2CFC4.9030701@latinsourcetech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2005 at 08:16:20PM -0300, Márcio Oliveira wrote:
> Neil,
> 
> >The best way I can think to do that is take a look at /proc/slabinfo.  
> >That will
> >likely give you a pointer to which area of code is eating up your memory.
> > 
> >
> OK. I will monitor the /proc/slabinfo file.
> 
> >Based on the sysrq-m info you posted it looks like due to fragmentation the
> >largest chunk of memory you can allocate is 2MB (perhaps less depending on
> >address space availability).  If you can build a test kernel to do a 
> >show_state
> >rather than a show_mem at the beginning of oom_kil, then you should be 
> >able to
> >tell who is trying to do an allocation that leads to kswapd calling
> >out_of_memory.
> > 
> >
> Neil, I'm trying to recompile the kernel source 2.4.21-32.0.1 and get 
> some error messages:
> 
> In file included from 
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/prefetch.h:13,
>                 from 
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/list.h:6,
>                 from 
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:12,
>                 from 3w-xxxx.c:172:
> /usr/src/linux-2.4.21-32.0.1.EL/include/asm/processor.h:61: warning: 
> parameter names (without types) in function declaration
> /usr/src/linux-2.4.21-32.0.1.EL/include/asm/processor.h:61: field 
> `loops_per_jiffy_R_ver_str' declared as a function
> /usr/src/linux-2.4.21-32.0.1.EL/include/asm/processor.h:84: invalid 
> suffix on integer constant
> /usr/src/linux-2.4.21-32.0.1.EL/include/asm/processor.h:84: syntax error 
> before numeric constant
> /usr/src/linux-2.4.21-32.0.1.EL/include/asm/processor.h:84: warning: 
> function declaration isn't a prototype
> /usr/src/linux-2.4.21-32.0.1.EL/include/asm/processor.h:269: invalid 
> suffix on integer constant
> /usr/src/linux-2.4.21-32.0.1.EL/include/asm/processor.h:269: syntax 
> error before numeric constant
> /usr/src/linux-2.4.21-32.0.1.EL/include/asm/processor.h:269: warning: 
> function declaration isn't a prototype
> /usr/src/linux-2.4.21-32.0.1.EL/include/asm/processor.h:273: warning: 
> parameter names (without types) in function declaration
> In file included from 3w-xxxx.c:172:
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:190: invalid 
> suffix on integer constant
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:190: syntax error 
> before numeric constant
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:190: 
> `inter_module_register_R_ver_str' declared as function returning a function
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:190: warning: 
> function declaration isn't a prototype
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:191: invalid 
> suffix on integer constant
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:191: syntax error 
> before numeric constant
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:191: 
> `inter_module_unregister_R_ver_str' declared as function returning a 
> function
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:191: warning: 
> function declaration isn't a prototype
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:192: 
> `inter_module_get_R_ver_str' declared as function returning a function
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:192: warning: 
> parameter names (without types) in function declaration
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:193: 
> `inter_module_get_request_R_ver_str' declared as function returning a 
> function
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:193: warning: 
> parameter names (without types) in function declaration
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:194: invalid 
> suffix on integer constant
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:194: syntax error 
> before numeric constant
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:194: 
> `inter_module_put_R_ver_str' declared as function returning a function
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:194: warning: 
> function declaration isn't a prototype
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:203: 
> `try_inc_mod_count_R_ver_str' declared as function returning a function
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h:203: warning: 
> parameter names (without types) in function declaration
> make[3]: *** [3w-xxxx_10200033.o] Error 1
> make[3]: Leaving directory 
> `/usr/src/linux-2.4.21-32.0.1.EL/drivers/addon/3w-xxxx_10200033'
> make[2]: *** [_modsubdir_3w-xxxx_10200033] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.4.21-32.0.1.EL/drivers/addon'
> make[1]: *** [_modsubdir_addon] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.21-32.0.1.EL/drivers'
> make: *** [_mod_drivers] Error 2
> 
> Is there any relationship between the sysrq-m changes to do show_state() 
> rather than a show_mem() and the compiling erros?
> 
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/prefetch.h, line 13:
>    #include <asm/processor.h>
> 
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/list.h ,line 6:
>    #include <linux/prefetch.h>
> 
> /usr/src/linux-2.4.21-32.0.1.EL/include/linux/module.h, line 12:
>    #include <linux/list.h>
> 
> 3w-xxxx.c, line 172:
>    #include <linux/module.h>
> 
> Any ideia about the kernel compiling erros?
> 
> (If I try to recompile a kernel.org kernel, it is compiled fine).
> 
> Thanks again.
> 
> Márcio.
> 
I honestly don't know.  I expect you haven't patched something correctly, have
you built the source tree with rpmbuild, or are you just extracting the tar file
from the rpm?
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
