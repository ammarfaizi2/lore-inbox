Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288460AbSAHWAg>; Tue, 8 Jan 2002 17:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288471AbSAHWAZ>; Tue, 8 Jan 2002 17:00:25 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:45461 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S288435AbSAHV7x>; Tue, 8 Jan 2002 16:59:53 -0500
Message-ID: <3C3B6BD2.9070201@attglobal.net>
Date: Tue, 08 Jan 2002 14:59:46 -0700
From: "Ian S. Nelson" <nelcomp@attglobal.net>
Reply-To: nelcomp@attglobal.net
Organization: Nelson Computing LLC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
In-Reply-To: <3C3B664B.3060103@intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Kondratiev wrote:

> Hello,
> Modern C standard (C99) defines __FUNCTION__ as if immediately after 
> function open brace string with function name is declared. Thus, it's 
> invalid to use string concatenations like __FILE__ ":" __FUNCTION__.
>
> Gcc 3.03 gives warning for such use of __FUNCTION__. Before this 
> warnings become error, it's worth to fix this in the kernel source.
>
> I found tons of improper __FUNCTION__ usage in USB drivers. I am not 
> to say, USB is the only place, I just started with it. In USB, typical 
> use is with dbg() and alike macros. dbg() defined in usb.h as follows:
>
> #define dbg(format, arg...) printk(KERN_DEBUG __FILE__ ": " format 
> "\n" , ## arg)
>
> In source it is usually used like
>
> dbg(__FUNCTION__ " endpoint %d\n", usb_pipeendpoint(this_urb->pipe));
>
> I propose modification for dbg() and friends like
>
> #define dbg(format, arg...) printk(KERN_DEBUG __FILE__ ":%s - " format 
> "\n", __FUNCTION__, ## arg)
>
> This will enable the same usage, but will incorporate __FUNCTION__ in 
> the common message prefix. This centralization will force function 
> name in all messages, and make it easy to fix code. Code will be 
> shorter and cleaner. It may be worth to (#ifdef MODULE) add module 
> name to message prefix.
>
> Any comments?

I suspect this might be about as religious an issue as there is but has 
anyone thought about coming up with some "standard" debugging macros, 
perhaps something that can be configured at compile time from the 
configuration for everyone to use everywhere?  I've got my own debug 
macros,  essentially a printk with the file, function and line added 
wrapped in #ifdef DEBUG.  I've seen several other schemes in other parts 
of the kernel and now some of them aren't correct.

I guess what I would envision is some kind of debug menu item in the 
configuration tool that let's you select if you want messages, and/or 
filenames, and/or line numbers, and/or function names, or nothing at 
all.   They could still be controlled at the module level by defining or 
not defining some constant.   It just seems kind of pointless to have 
10-20 different macros or methods that all do the same thing for 
different parts of the kernel.  

Ian

-- 
Ian S. Nelson <nelcomp@attglobal.net>        303-666-0315
Nelson Computing of Boulder Colorado
Networking/Contracting/Custom Software/Linux Fast and Personal service



