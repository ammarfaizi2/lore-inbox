Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289216AbSBNAL5>; Wed, 13 Feb 2002 19:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289213AbSBNALh>; Wed, 13 Feb 2002 19:11:37 -0500
Received: from maild.telia.com ([194.22.190.101]:63432 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S289216AbSBNALf>;
	Wed, 13 Feb 2002 19:11:35 -0500
Message-ID: <3C6B00B3.6000602@telia.com>
Date: Thu, 14 Feb 2002 01:11:31 +0100
From: Rickard Westman <rwestman@telia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Using kernel_fpu_begin() in device driver - feasible or not?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am porting a device driver from an embedded platform where it's OK
to do floating-point arithmetic in drivers.  To make it easy to
incorporate future improvements from this "reference driver", I have
tried to keep my modifications at a minimum, with most Linux-specific
code clearly separated.  The heavy use of interspersed floating-point
arithmetic is an obstacle, though, as I'm aware of the policy to avoid
floating-point arithmetic in the Linux kernel.

Ideally, I'd like to use the FPU in a daemonized kernel thread created
by the driver, and possibly from process context as well (in the
implementation of some ioctl:s.)  The target architecture is i386, and
non-portable solutions are quite acceptable.

Now, I've noticed that there are two interesting-looking functions in
the 2.4 kernel: kernel_fpu_begin() and kernel_fpu_end().  I have found
little information on how to use them, though, and I'd appreciate any
hints and guidelines.  Here are some issues I'm concerned about:

1. Would it be sufficient to just bracket all fpu-using code code by
kernel_fpu_begin()/kernel_fpu_end()?  If not, what problems could I
run into?

2. Would it be OK to go to sleep inside such a region, or should I
take care to avoid that?

3. Perhaps I should call init_fpu() at some point as well?  If so,
should it be done before or after kernel_fpu_begin()?

4. Is there any difference between doing this in the context of a user
process (implementation of an ioctl) compared to doing it in a
daemonized kernel thread (created by a loadable kernel module)?

5. The functions mentioned above are not exported for use by loadable
modules, but I guess that could be arranged for.  Is there any other
reason why it shouldn't work from a loadable kernel module?

Suggestions on alternative approaches are welcome as well, of course,
but I *do* realize that I could replace the calculations with
fixed-point arithmetic, divide things so that all floating-point
calculations were done in user-space, and similar ways to dodge the
issue.  But for now, I'm just looking for feedback on how to actually
do it in kernel space, aesthetics aside...

-- 
Rickard Westman         "Beware of the panacea peddlers: Just
<rwestman@telia.com>     because you wind up naked doesn't
                          make you an emperor."
                                     - Michael A Padlipsky

