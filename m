Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291705AbSBAL0D>; Fri, 1 Feb 2002 06:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291709AbSBALZx>; Fri, 1 Feb 2002 06:25:53 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:32787 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S291705AbSBALZf>;
	Fri, 1 Feb 2002 06:25:35 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
In-Reply-To: Your message of "Fri, 01 Feb 2002 03:03:45 -0800."
             <20020201.030345.70220779.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Feb 2002 22:25:20 +1100
Message-ID: <10884.1012562720@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Feb 2002 03:03:45 -0800 (PST), 
"David S. Miller" <davem@redhat.com> wrote:
>   From: Keith Owens <kaos@ocs.com.au>
>   Date: Fri, 01 Feb 2002 21:28:52 +1100
>
>   On Fri, 01 Feb 2002 11:07:42 +0100, 
>   Horst von Brand <brand@jupiter.cs.uni-dortmund.de> wrote:
>   >libc.a was invented precisely to handle such stuff automatically when
>   >linking... if it doesn't work, it should be fixed. I.e., making .a --> .o
>   >is a step in the wrong direction IMVHO.
>   
>   There are two contradictory requirements.  crc32.o must only be linked
>   if anything in the kernel needs it, linker puts crc32.o after the code
>   that uses it.  crc32.o must be linked before anything that uses it so
>   the crc32 __init code can initialize first.
>   
>Horst isn't even talking about the initcall issues, he's talking about
>how linking with libc works in that it only brings in the routines you
>actually reference.

Go back and read the entire thread Dave.  It started with

http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-04/1235.html

  "Besides problem with segfaulting crc32 (it is initialized after
  net/ipv4/ipconfig.c due to lib/lib.a being a library... I had to
  hardcode lib/crc32.o before --start-group in main Makefile, but it is
  another story)"

http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-04/1384.html

  "included patch (for 2.5.3) fixes problems with late initialization
  of lib/crc32.o - as it was part of .a library file, it was picked by
  link process AFTER at least one .o file required it - for example
  when ipv4 autoconfiguration file needed it. So crc32's initalization
  function was invoked after ipconfig's one - and it crashed inside of
  ipconfig due to this problem."

Horst was not talking about initcall but his suggestion of using lib.a
for crc32.o had already been proven not to work, because of the
(surprise) initcall problem.  I was merely pointing out to Horst why
lib.a was not working and why other options had to be considered.

>Will you get over the initcall thing already, you must be dreaming
>about it at this point. I mean really, just GET OVER IT. :-)

Nightmare is more like it.

