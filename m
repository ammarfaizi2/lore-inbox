Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314670AbSEBRdd>; Thu, 2 May 2002 13:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314671AbSEBRdc>; Thu, 2 May 2002 13:33:32 -0400
Received: from [195.63.194.11] ([195.63.194.11]:12815 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314670AbSEBRdb>; Thu, 2 May 2002 13:33:31 -0400
Message-ID: <3CD169AE.1010206@evision-ventures.com>
Date: Thu, 02 May 2002 18:30:38 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Richard Gooch <rgooch@ras.ucalgary.ca>, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <E173KAn-0004No-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>The main problem with mod-versions is the simple fact
>>that policy doesn't belong in to the kernel it belongs
>>in the user space. And mod-version is *just policy*.
> 
> 
> Nope. modversions are information about the ABI/API and objects referenced
> directly or indirectly from them.  The policy is entirely in modutils.
> Modutils has the power to say "well that looks kind of the same I'll bind
> that symbol name".
> 
> Kernel -> "Here is a helpful set of ABI compatibility hashes"
> Modutils -> "This symbol doesnt match, what do we want to do about it. Lets
> 	     fail". It could equally pick something looking similar.
> 
> 
>>It just DOES NOT BELONG in to the kernel-space.
> 
> 
> People who start using capital letters always seem to have emotional rather
> than logical reasons for their argument.

You are wrong.

ar r module.a module-symbol-versions-copyright-or-whatever
ar r vmlinuz.a symbol-versions-from-System.map

(Perhaps the ld variant with some section magic would be
  looking prettier and technically more correct.)

Shared libraries for example don't look up stuff like this inside
themselfs. (Unless you look at DLL stubs...)
It's the ld.so programm which maintains such data.
modutils don't do anything different from classical late binding.
The natural place for such maintainance work could be for example
the init process, which serves already pretty a similar role for
the kernel like ld.so does for user land applications. It would
provide a convenient point for possible synchronization...

Another analogy is the rpm dependency maintainance.
It's the rpm program - which does checking here and not
the actual application itself during the file-system install.

