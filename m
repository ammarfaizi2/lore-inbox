Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288814AbSA1NOD>; Mon, 28 Jan 2002 08:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288302AbSA1NN4>; Mon, 28 Jan 2002 08:13:56 -0500
Received: from f127.pav2.hotmail.com ([64.4.37.127]:23825 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S288814AbSA1NNo>;
	Mon, 28 Jan 2002 08:13:44 -0500
X-Originating-IP: [156.153.255.134]
From: "kumar M" <kumarm4@hotmail.com>
To: kaos@ocs.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: exporting kernel symbols
Date: Mon, 28 Jan 2002 13:13:38 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F127UjC2XxF6P0mCmg600006436@hotmail.com>
X-OriginalArrivalTime: 28 Jan 2002 13:13:38.0758 (UTC) FILETIME=[99899660:01C1A7FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

Thank you for the info. It was very informative.
My problem is funny.
On a freshly installed RedHat 7.1 machine
with 2.4.2-2 kernel,  a 'make modules'
throws up  errors such as  :
----------------------------------------
/usr/src/linux-2.4/include/linux/module.h:173: nondigits in number and not 
hexadecimal
/usr/src/linux-2.4/include/linux/module.h:173: parse error before `62dada05'
/usr/src/linux-2.4/include/linux/module.h:173: 
`inter_module_register_R_ver_str' declared as function returning a function
/usr/src/linux-2.4/include/linux/module.h:173: warning: function declaration 
isn't a prototype
.......................................................

So we do a 'make mrproper' and 'make menuconfig' and
save and exit without any changes to configuration.
Then we rebuild the kernel.
make dep & make modules are done smoothly.

Can you let us know why we should be doing make mrproper
on a system freshly installed  with redhat 7.1(2.4.2-2smp)

Thanks !

Kumar

>From: Keith Owens <kaos@ocs.com.au>
>To: "kumar M" <kumarm4@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: exporting kernel symbols
>Date: Mon, 28 Jan 2002 10:37:44 +1100
>
>On Sun, 27 Jan 2002 15:16:10 +0000,
>"kumar M" <kumarm4@hotmail.com> wrote:
> >I am interested in knowing how mangling the name of symbols
> >exported by the kernel to include the checksum of the information related 
>to
> >that symbol is done, whenever MOD VERSIONS
> >is used for building a module. Is there any documentation on the
> >process of the checksum computation, and which portion of the linux
> >sources I need to go through to understand this ?
>
>genksyms.c in the modutils source package[1].  The make dep process
>pre-processes the C sources from each directory feeding the cpp output
>into genksyms.  genksyms calculates a hash for each exported symbol
>based on its type, return values, parameters etc., recursively
>descending parameter types as required.
>
>The resulting hashes are written out as #defines to change foo to
>foo_Rxxxxxxxx.  The defines are read back in when the real compile is
>done, change references to foo into foo_Rxxxxxxxx.  In the kernel the
>original symbols are used but the export list includes the suffix.  In
>modules, external references include the suffix.
>
>In theory if a module refers to a symbol and the hashes for that symbol
>match then the symbol has not changed its ABI and it is safe to load
>the module, even if the kernel and module are from different versions.
>In practice, modversions relies far too much on human processes and is
>prone to false positives.  The hashes can match when the ABI is
>different because of human error[2], especially when people compile
>drivers outside the kernel tree.  Kernel and modutils 2.5 will have a
>completely different method for checking ABI compatibility, if kbuild
>2.5 ever gets in.
>
>[1] http://kernel.org/pub/linux/utils/kernel/modutils/v2.4
>[2] http://prdownloads.sourceforge.net/kbuild/kbuild-2.5-history.tar.bz2
>




_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

