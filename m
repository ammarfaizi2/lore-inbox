Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUDEXXt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263503AbUDEXXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:23:49 -0400
Received: from mail.tmr.com ([216.238.38.203]:48913 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263475AbUDEXXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:23:41 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [2.6.5] A bunch of various minor bugs not fixed since 2.6.4
Date: Mon, 05 Apr 2004 19:23:54 -0400
Organization: TMR Associates, Inc
Message-ID: <c4splr$7ar$1@gatekeeper.tmr.com>
References: <20040404235411.7ffde014.scriptkiddie@wp.pl> <20040404231219.D17113@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1081207291 7515 192.168.12.100 (5 Apr 2004 23:21:31 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040404231219.D17113@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sun, Apr 04, 2004 at 11:54:11PM +0200, Marek Szuba wrote:
> 
>>1. 'make *config' fails with missing header files
> 
> 
> Only people who try to build userspace programs against current
> kernel header files experience this problem.

It would solve all these problems if there were a new version of glibc 
included, or headers for user mode, or something... but in the real 
world at the moment most people are dropping 2.6.x kernels and selected 
upgrades to tools onto 2.4 systems. And a lot of user tools don't work 
unless you use kernel headers. The most obnoxious example is cdrecord, 
which doesn't seem to use the ATAPI interface unless you have a 2.6 
kernel in /usr/src/linux, or at least the include files.

I'm not saying that the kernel should program around people who insist 
on doing things wrong, but there are programs which don't work right 
unless you use some kernel headers when building (right meaning on 2.6). 


> 
> 
>>2. Platform-specific 'asm' symlink doesn't get created by 'make *config'
> 
> 
> This is only a problem for people trying to build userspace programs
> against current kernel header files.
> 
> 
>>3. 'make clean' seems to remove too much
> 
> 
> See 2.

Unfortunately the sanctimonious "we told you not to do that" approach 
isn't helpful to the real problem, the 2.6 kernel doesn't exist in a 
vacuum, and at the moment some applications are built with kernel 
headers to get full functionality.
> 
> These three complaints seem to revolve around your attempt to use
> the kernels header files for building user space programs against.
> This is something which hasn't really been supported by the kernel
> for many versions (since before 2.4) as you will find when searching
> the LKML archives.
> 
> /usr/include/{asm,linux} are supposed to be a copy of the sanitised
> kernel headers which were used *when glibc was built* (the words
> between the '*' are the important ones here.)

This purity of approach has only one failing, in some cases it doesn't work.

The useful answer is that you need to be *very* careful about which 
headers you use and not just use symlinks. There was a set of headers 
around which worked better with 2.6 and didn't have all these problems, 
I have solved my problems a case at a time, so I don't have the location 
handy.

Hope this actually helps, if you're going to bend the rules you have to 
understand how to do it. As O.P. found.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
