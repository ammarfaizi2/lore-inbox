Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424471AbWKPUtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424471AbWKPUtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 15:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424476AbWKPUtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 15:49:10 -0500
Received: from nz-out-0102.google.com ([64.233.162.207]:13066 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1424471AbWKPUtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 15:49:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qICGOsijiQBIyj5aKzqpEuYqLV6L40ZmlWKwsU/qJ0wD1VNdKEPpVrVit5/5GqKh49ItUPob7V5vseQnScTEMwMZPCKatsk4P270z5Wv2W/9O5lz9XmftikhgvCJuyymfXaDFYXUMPYC/9k//n1Bb0N2pNeGHm94i1GFCbi/OAo=
Message-ID: <9a8748490611161249t406768beqeaff0fc31f96e8df@mail.gmail.com>
Date: Thu, 16 Nov 2006 21:49:06 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: How to go about debuging a system lockup?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061116153444.GC8238@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061116153444.GC8238@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/06, Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> We have a router with a Geode SC1200 cpu, with 4 AMD 972 ethernet ports
> (pcnet32) behind a PLX 6152 PCI-PCI bridge, which quite regularly locks
> up completely if we try to do simultanius traffic on all 4 ports (our
> test case sends data from port 1 to port 2, and back and from port 3 to
> port 4 and back at a rate of 8000 packets per second using 1500byte
> packets).  We usually manage to run the test for about 1 minute before
> the system hangs.  This happens on every one of the systems we have
> tried so far.  If we only run 2 ports, it seems to never die, and with 3
> ports we haven't seen any failures yet, although maybe we just haven't
> tested long enough.  If we just receive the packets but don't forward
> them out again, then we never crash, so it seems to be related to
> simultanious transmit on the pcnet32s.
>
> So far I have tried printing a message everytime the pcnet32 driver
> enables and disables interrupts to find out if it hangs somewhere with
> interrupts disabled, but that didn't seem to indicate anything
> meaningful.
>
> So far I have tried this with 2.6.8, 2.6.16.22, and 2.6.18.2 and no
> difference so far.  I can't think of what kind of even could cause the
> system to just hang with no further console output or a kernel panic or
> oops or anything.  Usually most errors produce some kind of message.
>
> Does anyone have any suggestions for where I go from here to find out
> what is happening and where to look?  I don't even know if I should
> suspect the hardware or the software at this point.  I want to know if
> the program counter is still changing, or if the cpu is simply hung or
> something, but I have no idea how to get at that.
>
Well, I have a few ideas that are hopefully useul.

- If you have not done so already, then go in to the "Kernel Hacking"
section of the kernel configuration and enable some (all?) of the
debug options and see if that produces anything that will help you
track down the problem.

- You could enable 'magic sysrq' and see if you can manage to get a
backtrace with it when it hangs (see Documentation/sysrq.txt) (ohh and
raise the console log level so you get all messages, including debug
ones).

- You could also try kdb (http://oss.sgi.com/projects/kdb/) or kgdb
(http://kgdb.linsyssoft.com/). That might help you pinpoint the
failure.
See also : http://kerneltrap.org/node/112

- If you have (or can identify) an older, working, kernel version and
you are confident that you can reproduce the problem reliably, then
doing a git bisection search starting with your newest "known good"
and oldest "known bad" kernel versions, should help you pinpoint the
commit causing the breakage.


Hope some of that helps :)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
