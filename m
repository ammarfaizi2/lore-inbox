Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTILXoF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTILXoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:44:05 -0400
Received: from dsl092-233-042.phl1.dsl.speakeasy.net ([66.92.233.42]:56983
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id S261929AbTILXoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:44:02 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: linux-kernel@vger.kernel.org
X-Envelope-Sender: oliver@klozoff.com
Message-ID: <3F625996.2070306@klozoff.com>
Date: Fri, 12 Sep 2003 19:41:10 -0400
From: Stevie-O <oliver@klozoff.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serial port problem with SiS 730 chispet?
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I apologize if this problem has been reported before; I tried googling but came 
up empty.

I just upgraded my system and put in a EGS K7SEM motherboard with a SiS 730 
chipset.  I have Debian installed. For those not in the know, Debian provides a 
utility called 'discover' that does simple things to detect hardware, such as 
scanning the pci bus to find modules that need to be loaded.  One of the things 
it can do is probe serial ports	to find modems and mice and other such things.

Well, to make a long story short, after some time stracing and gdbing and other 
experimenting, I think I have determined that discover is stalling when it tries 
to open /dev/ttyS0.  discover is called twice Debian's startup scripts, and both 
times it blocks waiting to open the port.  I modified the single-user-mode 
startup to run 'openvt sulogin' right away.  Things got stranger as I proceeded:

(1) strace -p <discover's pid> wakes it up at 'open(.../dev/ttyS0)'.   I think 
the signal being sent when strace does ptrace(PTRACE_ATTACH) kickstarts it into 
working.
(2) stty -F/dev/ttyS0 (while discover is still blocked) also blocks.
(3) However, when I hit ctrl-C to kill stty, discover unblocks.
(4) To top it all off, everything begins to work at some point.  After the 
machine has completely booted and I can ssh in (the machine is *intended* to be 
a headless server, so normally the only access is via ssh), I can happily run 
discover as often as I want and it will proceed normally.


Can anyone out there please help me figure out exactly what's happening (and 
more importantly, how to fix it)?

--
Please CC me, I'm not subscribed to the list.

-- 
- Stevie-O

Real Programmers use COPY CON PROGRAM.EXE

