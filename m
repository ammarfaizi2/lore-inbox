Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272583AbRHaBsw>; Thu, 30 Aug 2001 21:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272584AbRHaBsm>; Thu, 30 Aug 2001 21:48:42 -0400
Received: from zok.sgi.com ([204.94.215.101]:63872 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S272583AbRHaBs2>;
	Thu, 30 Aug 2001 21:48:28 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac5 
In-Reply-To: Your message of "Fri, 31 Aug 2001 02:26:09 +0100."
             <E15cd4T-0002Hm-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 31 Aug 2001 11:48:34 +1000
Message-ID: <9293.999222514@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2001 02:26:09 +0100 (BST), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> What do you need for licence support in modutils?  Obviously modinfo
>> needs to print it, but what about insmod?  Should insmod issue warning
>> messages for proprietary modules?  What about ksymoops?  IOW, what was
>> the reason for adding MODULE_LICENSE?
>
>My goal is to eventually include the info tucked away on oops report lines
>so that I can automatically dump bug reports with binary drivers, including
>the growing number of people who lie about nvdriver and think that this will
>get their bug cured.

Then we have a problem.  The modinfo and modstring sections are not
loaded into kernel space, they are processed by insmod then discarded.

Solution: /proc/sys/kernel/tainted.  Set to 0 on boot, set to 1 by
insmod when it finds a non-GPL module, printed by panic, extracted by
ksymoops.  Any load of a proprietary module taints the kernel, even if
it is later removed.  The kernel code for that sysctl only allows taint
to be set, not to be cleared.

Not perfect, really malicious users can hack the kernel.  Or they can
simply edit the taint flag in the oops report.  But it will catch 90%+
of the problem case.

