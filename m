Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276920AbRJQPep>; Wed, 17 Oct 2001 11:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276933AbRJQPef>; Wed, 17 Oct 2001 11:34:35 -0400
Received: from air-1.osdl.org ([65.201.151.5]:35847 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S276920AbRJQPeT>;
	Wed, 17 Oct 2001 11:34:19 -0400
Message-ID: <3BCDA3E7.7D201103@osdl.org>
Date: Wed, 17 Oct 2001 08:29:43 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: console_loglevel is broken on ia64
In-Reply-To: <2784.1003325102@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> kernel/printk.c has this abomination.
> 
> /* Keep together for sysctl support */
> int console_loglevel = DEFAULT_CONSOLE_LOGLEVEL;
> int default_message_loglevel = DEFAULT_MESSAGE_LOGLEVEL;
> int minimum_console_loglevel = MINIMUM_CONSOLE_LOGLEVEL;
> int default_console_loglevel = DEFAULT_CONSOLE_LOGLEVEL;
> 
> sysctl assumes that the 4 variables occupy contiguous storage.  They
> don't on ia64, console_loglevel is separate from the other variables.
> 
>   echo 6 4 1 7 > /proc/sys/kernel/printk
> 
> on ia64 overwrites console_loglevel and the next 3 integers, whatever
> they happen to be.  On 2.4.12 it corrupts console_sem, other ia64
> kernels will corrupt different data.
> 
> Does anybody fancy a small project to clean up these variables?  They
> need to become an integer array (say console_printk) containing 4
> elements, which is what sysctl assumes.  All references to these fields
> have to be changed to refer to the corresponding array element.  That
> should be as simple as

Yep.  I asked someone to clean this up about
3 weeks ago, and he said that he would do so, but....?

So Jesper or someone else should jump on it.

~Randy
