Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267721AbUIJSMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267721AbUIJSMC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 14:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267740AbUIJSMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 14:12:01 -0400
Received: from mail.tmr.com ([216.238.38.203]:5139 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S267721AbUIJSLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 14:11:50 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: seems to be impossible to disable CONFIG_SERIAL [2.6.7]
Date: Fri, 10 Sep 2004 14:12:13 -0400
Organization: TMR Associates, Inc
Message-ID: <chsqc8$boi$1@gatekeeper.tmr.com>
References: <20040910133545.E22599@flint.arm.linux.org.uk><20040910133545.E22599@flint.arm.linux.org.uk> <20040910130733.GI14060@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1094839497 12050 192.168.12.100 (10 Sep 2004 18:04:57 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <20040910130733.GI14060@lkcl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton wrote:
> On Fri, Sep 10, 2004 at 01:35:45PM +0100, Russell King wrote:
> 
>>On Fri, Sep 10, 2004 at 01:20:59PM +0100, Luke Kenneth Casson Leighton wrote:
>>
>>>On Fri, Sep 10, 2004 at 12:09:50PM +0100, Russell King wrote:
>>>
>>>>On Fri, Sep 10, 2004 at 12:08:19PM +0100, Luke Kenneth Casson Leighton wrote:
>>>>
>>>>>hi,
>>>>>
>>>>>has anyone noticed that it's impossible (without hacking) to remove
>>>>>CONFIG_SERIAL?
>>>>>
>>>>>remove the entries or set all SERIAL config entries to "n"...
>>>>>hit make...
>>>>>CONFIG_SERIAL_8250 gets set to "m", CONFIG_SERIAL gets set to "y"!
>>>>>
>>>>>seeerrrriiialllll muuuusssstttt dieeeeeee kill kill kill.
>>>>
>>>>No idea - you've given very little information to go on.  I doubt
>>>>you're building an x86 kernel... Mind giving some clues and maybe
>>>>a copy of your .config file?
>>>
>>> 
>>> x86 kernel, debian default config with legacy stuff like
>>>
>>> sure.
>>
>>Ok, so it _isn't_ CONFIG_SERIAL at all.  Grumble.
>>
>>Anyway, CONFIG_SERIAL_8250 gets set to 'm' because:
>>
>>$ find . -name 'Kconfig*' | xargs grep 'select SERIAL_8250' -B5
>>./drivers/char/Kconfig-source "drivers/char/pcmcia/Kconfig"
>>./drivers/char/Kconfig-
>>./drivers/char/Kconfig-config MWAVE
>>./drivers/char/Kconfig- tristate "ACP Modem (Mwave) support"
>>./drivers/char/Kconfig- depends on X86
>>./drivers/char/Kconfig: select SERIAL_8250
>>
>>and you have CONFIG_MWAVE is set to 'm'.  
> 
> 
>  oh, do i?  looovely, what's one of those when it's at home?
> 
>  it would appear that the "select ..." thing is what's causing the
>  nightmares: it forces options to be enabled without informing the user,
>  and without the user being able to do it the other way round:
>  say "i don't want CONFIG_SERIAL_8250 and therefore any option depending
>  on it can bugger off".

I like that a lot!
   Use 8250 serial? (Y/n/m/b)

I'm reasonably serious about this, having a "don't use" state would show 
some config errors and prevent problems like this.

Any config guru care to comment on the dificulty? And desirability, of 
course.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
