Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293488AbSCAEwh>; Thu, 28 Feb 2002 23:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310351AbSCAEut>; Thu, 28 Feb 2002 23:50:49 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:62733 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S310336AbSCAErv>; Thu, 28 Feb 2002 23:47:51 -0500
Date: Fri, 1 Mar 2002 12:52:22 +0800
From: He Jian Bing <hjbsy@yahoo.com.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: barrier and volatile
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20020301044755Z310336-889+101562@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the __barrier__ definition:

/* The "volatile" is due to gcc bugs */
#define barrier() __asm__ __volatile__("": : :"memory")

I know the reason of the "memory" clobber, I also know an 'asm'
instruction without any operands is implicitly considered volatile,
but the comment say: we must use volatile because of the "gcc bugs".
So I guess the "gcc bug" is that the compiler doesn't consider it
volatile in fact if we remove __volatile__ in barrier().Is it right?

Suppose gcc compiler doesn't think the asm statement
__asm__ ("": : :"memory") is volatile, and if we want the "barrier"
is volatile, we should use __asm__ __volatile__ ("": : :"memory").
My interest is what the gcc compiler will do respectively when it
optimize the above two statement.

Another question, my gcc version is(use gcc -v):
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)

The below is from gcc info pages(Node: Extended Asm):
   If your assembler instruction modifies memory in an unpredictable
fashion, add 'memory' to the list of clobbered registers. This will
cause GNU CC to not keep memory values cached in registers across the
assembler instruction. You will also want to add the 'volatile'
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
keyword if the memory affected is not listed in the inputs or outputs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
of the 'asm', as the 'memory' clobber does not count as a side-effect
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
of the 'asm'.
^^^^^^^^^^^^^
what's the meaning of the underlined line?

Regards,
He Jian Bing


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

