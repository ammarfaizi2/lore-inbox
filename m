Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUDEWXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbUDEWUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:20:34 -0400
Received: from mail.tmr.com ([216.238.38.203]:27409 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263523AbUDEWRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:17:03 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.4: disabling SCSI support not possible
Date: Mon, 05 Apr 2004 18:17:14 -0400
Organization: TMR Associates, Inc
Message-ID: <c4slos$6tq$1@gatekeeper.tmr.com>
References: <406D65FE.9090001@broadnet-mediascape.de> <6uad1uv7kr.fsf@zork.zork.net> <20040402144216.A12306@flint.arm.linux.org.uk> <20040402165941.GA29046@kroah.com> <20040402181630.B12306@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1081203292 7098 192.168.12.100 (5 Apr 2004 22:14:52 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040402181630.B12306@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Apr 02, 2004 at 08:59:41AM -0800, Greg KH wrote:
> 
>>No, this is the way it used to be, and it caused all kinds of problems
>>in the past.  It was switched to use 'select' on purpose, and should
>>stay that way.
> 
> 
> It's causing problems today by preventing people from being able to
> de-select SCSI for no obvious reason.
> 
> It is far less intuitive to know you have to turn off USB_STORAGE
> before you can turn off SCSI than to know that you have to turn on
> SCSI before you can turn on USB_STORAGE.

Intuitive isn't the issue, if you can't figure out why you can't turn 
off SCSI, you leave it on, which you need to make USB storage work. If 
you're trying to make a small kernel you presumably would have turned 
off USB if you didn't want it. The other way, if you can turn on USB w/o 
SCSI, it won't work, and people thing Linux is broken.

The issue is that what we have works but it's not obvious why, vs. 
doesn't work and also isn't obvious why. Thank you, work by default is 
better.
> 
> If you wish to keep it this way, could we either have:
> 
> (a) a note in the SCSI help text to say that the option is forced
>     on by USB_STORAGE, so people know what to turn off.

Chances are that most people wouldn't have USB on if they didn't want 
it, but there's no downside to doing this.
> 
> or
> 
> (b) have kconfig tell you why you can't turn off the option.

I thought that was what (a) did.
> 
> Silently preventing options being turned off with no obvious reason
> is a pretty major misfeature.

Compared to enabling USB storage with no hope of having it work? Adding 
user info is desirable, but making it easy, or even possible, to build a 
  non-working config is a lot more of a problem. You haven't compiled on 
a slow machine lately, forcing config combinations which work is a 
benefit of kconfig.

If you want it broken you have to edit the config code. That's a good thing.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
