Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263179AbRE1WL4>; Mon, 28 May 2001 18:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263182AbRE1WLq>; Mon, 28 May 2001 18:11:46 -0400
Received: from Sarah.SomeSites.com ([208.44.57.7]:53514 "HELO
	MoveAlong.SomeSites.com") by vger.kernel.org with SMTP
	id <S263179AbRE1WLi>; Mon, 28 May 2001 18:11:38 -0400
Message-ID: <002101c0e7c3$18cdbfb0$0100a8c0@SomeSites.com>
From: "James Turinsky" <lkml@SomeSites.com>
To: "Mark Hahn" <hahn@coffee.psychology.mcmaster.ca>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Jens Axboe" <axboe@suse.de>, <andre@linux-ide.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <E154UJT-0003XV-00@the-village.bc.nu>
Subject: Re: [patch]: ide dma timeout retry in pio
Date: Mon, 28 May 2001 18:11:05 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Mark Hahn" <hahn@coffee.psychology.mcmaster.ca>
Cc: "Jens Axboe" <axboe@suse.de>; <andre@linux-ide.org>;
<alan@lxorguk.ukuu.org.uk>; <linux-kernel@vger.kernel.org>
Sent: Monday, May 28, 2001 5:12 PM
Subject: Re: [patch]: ide dma timeout retry in pio


> > really?  do we know the nature of the DMA engine problem well
enough?
>
> I can categorise some of them:
>
> 1. Hardware that just doesnt support it.
> 2. Timeouts that are false positives caused by disks having problems
> and being very slow to recover
> 3. Bad cabling
> 4. Stalls caused by heavy PCI traffic
>
> > is there a reason to believe that it'll work better "later"?
>
> #1 will go fail, fail, fail -> PIO now (or should do Im about to try
it)
> #2 and #4 will be transient
> #3 could go either way


Where does the "'DMA Timeout -> disable DMA' then lose all
responsiveness when I issue 'hdparm -d1' while it tries and fails to
re-enable DMA" fit in?  The disk will happily run for several days in
UDMA33 and then at some point it craps out with a DMA timeout which
results 1) DMA being turned off and 2) all attempts to re-enable DMA
failing?

And what's up with this:

[root@MoveAlong james]# hdparm /dev/hda

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 19590/16/63, sectors = 19746720, start = 0
[root@MoveAlong james]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  6.98 seconds = 18.34 MB/sec
 Timing buffered disk reads:  64 MB in  5.77 seconds = 11.09 MB/sec
Hmm.. suspicious results: probably not enough free memory for a proper
test.
[root@MoveAlong james]# free
             total       used       free     shared    buffers
cached
Mem:        126800     123460       3340          0      67284
41572
-/+ buffers/cache:      14604     112196
Swap:       394624      32816     361808

I used to get ~33MB/sec on buffer-cache and ~10MB/sec on buffered disk
reads in 2.2...

--JT

