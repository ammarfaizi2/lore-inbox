Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276832AbRJMKZi>; Sat, 13 Oct 2001 06:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276834AbRJMKZ2>; Sat, 13 Oct 2001 06:25:28 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:30482 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S276832AbRJMKZU>;
	Sat, 13 Oct 2001 06:25:20 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: Your message of "13 Oct 2001 12:02:16 +0200."
             <k2het3luxj.fsf@zero.aec.at> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Oct 2001 20:25:31 +1000
Message-ID: <16790.1002968731@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Oct 2001 12:02:16 +0200, 
Andi Kleen <ak@muc.de> wrote:
>Just use the existing linker features. Link the crc code as an .a library.

Does not work if all the code that uses crc32 is in a module.  No
references from the main kernel so crc32 is not included by the linker.

>[Note that __initcall may be a bit tricky here if some other __initcall
>user like an ethernet driver needs crc32 too; there is unfortunately no
>priority mechanism in __initcall to enforce that the crc32 init runs before
>the other initcalls. best would probably just to use a static table to avoid 
>this issue] 

???!  __initcall entries are executed in the order that they are linked
into the kernel.  The linkage order is controlled by the order that
Makefiles are processed during kbuild and by line order within each
Makefile.  There is definitely a priority order for __initcall code.

