Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269997AbUJHQhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269997AbUJHQhP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 12:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270006AbUJHQhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 12:37:14 -0400
Received: from [195.23.16.24] ([195.23.16.24]:10940 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S269997AbUJHQhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 12:37:06 -0400
Message-ID: <4166C216.2080305@grupopie.com>
Date: Fri, 08 Oct 2004 17:36:38 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Catalin Marinas <Catalin.Marinas@arm.com>,
       Richard Earnshaw <Richard.Earnshaw@arm.com>,
       Sam Ravnborg <sam@ravnborg.org>, Albert Cahalan <albert@users.sf.net>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
References: <20040927210305.A26680@flint.arm.linux.org.uk> <20041008160456.H17999@flint.arm.linux.org.uk>
In-Reply-To: <20041008160456.H17999@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.3; VDF: 6.28.0.7; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Sep 27, 2004 at 09:03:05PM +0100, Russell King wrote:
> 
>>The ARM binutils seems to be in a problematical state at the moment.
>>It has recently had a "bug" fixed where ARM specific "mapping symbols"
>>were not generated in ELF objects.  These "mapping symbols" have names
>>such as "$a" and "$d".
> 
> 
> Ok, another tool which is affected by this is procps:
> 
> $ ps alx
> Warning: /boot/System.map-2.6.9-rc3 not parseable as a System.map
> Warning: /boot/System.map not parseable as a System.map
> Warning: /usr/src/linux/System.map has an incorrect kernel version.
> F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
> 4     0     1     0  16   0  1244  508 do_sel S    ?          0:01 init [3]

ps is reading System.map probably because reading /proc/<pid>/wchan 
directly was very slow. It used to take an average of 1.3ms (on a P4 
2.8GHz) and now it takes less than 0.5us (that is miliseconds and 
microseconds!)

If this is the case, then after the changes to kallsyms go in, procps 
could start using wchan directly and avoid reading the System.map 
altogether.

I'm adding Albert Cahalan to this list since he should know a little 
more about this :)

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
