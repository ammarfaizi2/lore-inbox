Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319434AbSILFEp>; Thu, 12 Sep 2002 01:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319435AbSILFEp>; Thu, 12 Sep 2002 01:04:45 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:55557 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S319434AbSILFEo>; Thu, 12 Sep 2002 01:04:44 -0400
Date: Wed, 11 Sep 2002 20:27:41 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Killing/balancing processes when overcommited
Message-ID: <20020911182741.GA17945@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <OFA28F240F.93209971-ON88256C31.005E5F03@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA28F240F.93209971-ON88256C31.005E5F03@boulder.ibm.com>
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Sibley <jlsibley@us.ibm.com>
Date: Wed, Sep 11, 2002 at 11:08:43AM -0700
> 1 - cpu usage may not be a good measure
> 2 - Large memory tasks may not be a good measure
> 3 - Measuring memory by task is misleading
> 4 - Niceness is not really useful in a multi-user environment.
> 5 - Other numerical limits tend to be arbitrary.

I was just think (feel free to point out the errors of my way):

what if we used the time a program was started as a guide? The last
programs started are killed of first.

That would mean that init survives to the last, as would the daemons
that are started when booting.

Alternatively, suppose we get a very large pid-space, and at the end of
booting there's something like

echo "5000" > /proc/sys/minimum-pid-from-here-on

Then, you could do:

echo "5000" > proc/sys/oom_lowest_pid_to_try_killing_first

in other words, protect a part of pid-space against oom-killing.

How this all works with threads, forks, child-processes etc etc is
beyond me - I'm just thinking a bit.

Jurriaan
-- 
A black cat crossing your path signifies that the animal is going somewhere.
        Groucho Marx (1890-1977)
GNU/Linux 2.4.19-ac4 SMP/ReiserFS 2x1402 bogomips load av: 1.57 1.36 0.87
