Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268896AbUHMAES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268896AbUHMAES (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 20:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268898AbUHMAES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 20:04:18 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:10719 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268896AbUHMAEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 20:04:16 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Paul Davis <paul@linuxaudiosystems.com>
In-Reply-To: <1092347654.11134.10.camel@mindpipe>
References: <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <1092174959.5061.6.camel@mindpipe>
	 <20040811073149.GA4312@elte.hu> <20040811074256.GA5298@elte.hu>
	 <1092210765.1650.3.camel@mindpipe> <20040811090639.GA8354@elte.hu>
	 <20040811141649.447f112f@mango.fruits.de> <20040811124342.GA17017@elte.hu>
	 <1092268536.1090.7.camel@mindpipe>  <20040812072127.GA20386@elte.hu>
	 <1092347654.11134.10.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1092355488.1304.52.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 20:04:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 17:54, Lee Revell wrote:
> I still have not had a chance to test with the latest
> patches & config changes.

Here are all the log entries produced during this test:

rlrevell@mindpipe:~$ for test in 1 2 3 4 5; do echo; echo "Test $test";
jackd -n 100000 --realtime -d alsa --rate 48000 -D -P hw:0,0 -C hw:0,2
-p 32 -S >> mm2; done

http://krustophenia.net/2.6.8-rc3-O5-A2/kern.log.txt

When one jackd process is running, starting another jackd process, 
using a different device produces an xrun in the first.  If mlockall-test 
is run while a jackd process is running, this also produces an xrun in 
the jackd process.

So, it seems that if a SCHED_FIFO process opens a PCM device using mmap, 
then mlockall's the memory, then another process mlockall's memory, the 
result is an xrun 100% of the time.

Lee
 

