Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275453AbTHSFzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 01:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275486AbTHSFzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 01:55:18 -0400
Received: from anumail2.anu.edu.au ([150.203.2.42]:30640 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S275453AbTHSFzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 01:55:13 -0400
Message-ID: <3F41BBAD.5000604@cyberone.com.au>
Date: Tue, 19 Aug 2003 15:54:53 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.2.1) Gecko/20021217
MIME-Version: 1.0
To: Stefan Foerster <stefan@stefan-foerster.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Very bad interactivity with 2.6.0 and SCSI disks (aic7xxx)
References: <20030818013243.GB21665@in-ws-001.cid-net.de> <20030817192103.798994d8.akpm@osdl.org> <20030818054851.GA5252@in-ws-001.cid-net.de> <20030817230325.2887ca49.akpm@osdl.org> <20030819054327.GA8674@in-ws-001.cid-net.de>
In-Reply-To: <20030819054327.GA8674@in-ws-001.cid-net.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-3.2)
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,SPAM_PHRASE_00_01,USER_AGENT,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Foerster wrote:

>[I've sent this mail aleready, but got an error from my MAILER-DAEMON.
>Perhaps ist was too large vor lkml, so I'm moving the oprofile output
>to a webserver]
>
>* Andrew Morton <akpm@osdl.org> wrote:
>
>>Stefan Foerster <stefan@stefan-foerster.de> wrote:
>>
>>>* Andrew Morton <akpm@osdl.org> wrote:
>>>
>>>>Stefan Foerster <stefan@stefan-foerster.de> wrote:
>>>>A kernel profile would be needed to diagnose this.  You could use
>>>>readprofile, but as it may be an interrupt problem, the NMI-based oprofile
>>>>output would be better.
>>>>
>>>Is this procedure documented anywhere?
>>>
>
>[every information I needed]
>
>I did the following steps:
>
>
>opcontrol --setup --vmlinux=/usr/src/linux/vmlinux --event=RETIRED_INSNS:100000:0:1:1
>
>Then I used your shell source:
>
>~/shells/oprofileit dd if=/dev/zero of=test bs=1024 count=1048576
>
>opreport -l  /usr/src/linux/vmlinux  > /tmp/1
>opreport -ld -D /usr/src/linux/vmlinux  > /tmp/2
>
>During the dd, again the xmms playing a file from an tmpfs froze and
>even screen redrawing was very, very slow.
>
>The output of these commands kan be found at:
>
>http://home.in.tum.de/foerstes/oprofile-1
>http://home.in.tum.de/foerstes/oprofile-2
>
>Is this information useful in debugging my problem, or should I go and
>try again with readprofile or other tools?
>

Nothing jumps out at me. Is your machine swapping during the bad behaviour?
What is the effect of echo 0 > /proc/sys/vm/swappiness, swapoff -a, or
using the deadline IO scheduler (boot with argument elevator=deadline)



