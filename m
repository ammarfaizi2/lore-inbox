Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263476AbRFLVmg>; Tue, 12 Jun 2001 17:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263545AbRFLVmR>; Tue, 12 Jun 2001 17:42:17 -0400
Received: from sncgw.nai.com ([161.69.248.229]:63151 "HELO mcafee-labs.nai.com")
	by vger.kernel.org with SMTP id <S263449AbRFLVmE>;
	Tue, 12 Jun 2001 17:42:04 -0400
Message-ID: <XFMail.20010612144449.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200106121858.f5CIwmX05650@ns.caldera.de>
Date: Tue, 12 Jun 2001 14:44:49 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Christoph Hellwig <hch@ns.caldera.de>
Subject: Re: threading question
Cc: linux-kernel@vger.kernel.org, ognen@gene.pbi.nrc.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12-Jun-2001 Christoph Hellwig wrote:
> In article <Pine.LNX.4.30.0106121213570.24593-100000@gene.pbi.nrc.ca> you
> wrote:
>> On dual-CPU machines the speedups are as follows: my version
>> is 1.88 faster than the sequential one on IRIX, 1.81 times on Solaris,
>> 1.8 times on OSF/1, 1.43 times on Linux 2.2.x and 1.52 times on Linux 2.4
>> kernel. Why are the numbers on Linux machines so much lower?
> 
> Does your measurement include the time needed to actually create the
> threads or do you even frequently create and destroy threads?

This is an extract of the most busy vmstat report running under his tool :

12  0  0  15508  40980  24880 355480   0   0     0     0  141   481 100   0   0
19  0  0  15508  40248  24880 355480   0   0     0     0  142   564 100   0   0
12  0  0  15508  40112  24880 355480   0   0     0     0  150   543 100   0   0
11  0  0  15508  41272  24880 355480   0   0     0     0  156   594  99   1   0
17  0  0  15508  40408  24880 355480   0   0     0     0  156   474  99   1   0
17  0  0  15508  39840  24880 355480   0   0     0     0  135   475 100   0   0
21  0  0  15508  39568  24880 355480   0   0     0     0  125   409 100   0   0
21  0  0  15508  39668  24880 355480   0   0     0     0  135   420 100   0   0
16  0  0  15508  39760  24880 355480   0   0     0     0  149   486 100   0   0


The context switch is very low and the user CPU utilization is 100% , I don't
think it's system responsibility here ( clearly a CPU bound program ).
Even if the runqueue is long, the context switch is low.
I've just close to me a dual PIII 1GHz workstation that run an MTA that uses
linux pthreads with context switching ranging between 5000 and 11000 with a
thread creation rate of about 300 thread/sec ( relaying 600000 msg/hour ).
No problem at all with the system even if the load avg is a bit high
( about 8 ).




- Davide

