Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270774AbRH1Lm5>; Tue, 28 Aug 2001 07:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270783AbRH1Lmr>; Tue, 28 Aug 2001 07:42:47 -0400
Received: from fe100.worldonline.dk ([212.54.64.211]:40453 "HELO
	fe100.worldonline.dk") by vger.kernel.org with SMTP
	id <S270774AbRH1Lmf>; Tue, 28 Aug 2001 07:42:35 -0400
Date: Tue, 28 Aug 2001 13:45:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Christoph Rohland <cr@sap.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] zero-bounce block highmem I/O, #13
Message-ID: <20010828134545.N642@suse.de>
In-Reply-To: <20010827123700.B1092@suse.de> <m3itf85vlr.fsf@linux.local> <20010828125520.L642@suse.de> <m3elpw5smc.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3elpw5smc.fsf@linux.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28 2001, Christoph Rohland wrote:
> Hi Jens,
> 
> On Tue, 28 Aug 2001, Jens Axboe wrote:
> > On Tue, Aug 28 2001, Christoph Rohland wrote:
> >> Hi Jens,
> >> 
> >> I tested both #11 and #13 on my 8GB machine with sym53c8xx. The
> >> initialization of a SAP DB database takes 20 minutes with 2.4.9 and
> >> with 2.4.9+b13 it took nearly 2.5 hours :-(
> > 
> > DaveM hinted that it's probably the bounce test failing, so it's
> > bouncing all the time. That would explain the much worse
> > performance.  Could you try with this incremental patch on top of
> > b13 for 2.4.9? I still want to see the boot detection info, btw.
> 
> Apparently it did not help. See attachments: vmstat was 'vmstat
> 5'. The b13 output is only the end. The b13-1 is still running but the
> blockout rate is again low. So I do not wait another 2 hours...

Nope fine, no need to wait :-)

The -2 patch I sent should fix it, performance looks good here (just a
5min test run to verify).

What happened was that we would fall back to single segment requests all
the time. A real performance killer for SCSI.

-- 
Jens Axboe

