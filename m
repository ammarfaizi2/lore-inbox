Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUITPMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUITPMO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 11:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUITPMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 11:12:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43977 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266663AbUITPMC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 11:12:02 -0400
Date: Mon, 20 Sep 2004 10:48:35 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Ingo Freund <Ingo.Freund@e-dict.net>
Cc: linux-kernel@vger.kernel.org, achim_leubner@adaptec.com
Subject: Re: three days running fine, then memory allocation errors
Message-ID: <20040920134835.GE3459@logos.cnet>
References: <20040920130228.GB3459@logos.cnet> <NEBBILBHKLDLOMLDGKGNIEKMCIAA.Ingo.Freund@e-dict.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NEBBILBHKLDLOMLDGKGNIEKMCIAA.Ingo.Freund@e-dict.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 04:58:02PM +0200, Ingo Freund wrote:
> Thank you for the answer.
> Well, I'll stop my requests to the drivers output immediatly.
> 
> The problem is, that I only get the errors on one machine.
> Others (with less memory) don't react this way. 

The others also have same gdth controllers? Are the disk configuration similar?
Numbers of disks, etc.

> It will take some time to include the patch and inform about 
> the output. I have to reboot the machine after installing the 
> patch and the new kernel build. This can only happen in certain
> time windows.

Understood.

> Is it neccessary to wait until the error occurs or do you only
> want some outputs?

Only some outputs - it will show us if the /proc handling function
is freeing correctly some of the memory it allocates.

I forgot to CC Achim in the first message, done now.

> 
> Bye - Ingo.
> 
> 
> > -----Original Message-----
> > From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com]
> > Sent: Monday, September 20, 2004 3:02 PM
> > To: Ingo Freund
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: three days running fine, then memory allocation errors
> > 
> > 
> > 
> > Achim, I believe there is a memory leak (maybe several) in gdth's proc handling 
> > code, can you please take a look at it?
> > 
> > Ingo, can you give the attached patch a test a show us the result 
> > (you should get "gdth_alloc:x gdth_free:y" on /var/log/messages
> > at each read of /proc/gdth/xx
> > 
> > On normal server operation just dont "cat /proc/scsi/gdth/.." and your server
> > should be stable.
> > 
> > On Mon, Sep 20, 2004 at 01:07:54PM +0200, Ingo Freund wrote:
> > > Hello,
> > > 
> > > I hope you guys can help, I cannot use any kernel 2.4 >23 without
> > > the here described problem.
> > > 
> > > Searching the web for solutions to my problem I have already found 
> > > a thread in a mailing list but no solution was mentioned, also the 
> > > guys who talked about the error didn't answer to my direct mail.
> > > 
> > > The machine is a two xeon cpu database server without any other service 
> > > except sshd running. I do some tests on the ICP-Vortex GDT controller 
> > > every 2 minutes by using 
> > > # cat /proc/scsi/gdt/2
> > > but the output of cat stops without beeing completed.
> > > 
> > > This is what I see in the syslog file every time when I use the cat
> > > command (the messages beginn after 3 days uptime):
> > > --> /var/log/messages
> > > kernel: __alloc_pages: 0-order allocation failed (gfp=0x21/0)
> > > 
> > > What do you propose to do for I can get the information I need for 
> > > longer than three days without reboot? This is a highly used database
> > > server in production environment.
> > > 
> > > Kernel version (from /proc/version):
> > > Linux version 2.4.27 (root@widbrz01) (gcc version 3.3.1 
> > > 
> > > 
> > > # cat /proc/meminfo 
> > >         total:    used:    free:  shared: buffers:  cached:
> > > Mem:  2118139904 2074345472 43794432        0 151343104 1742090240
> > > Swap: 6407458816 48291840 6359166976
> > > MemTotal:      2068496 kB
> > > MemFree:         42768 kB
> > > MemShared:           0 kB
> > > Buffers:        147796 kB
> > > Cached:        1694548 kB
> > > SwapCached:       6712 kB
> > > Active:         223620 kB
> > > Inactive:      1709760 kB
> > > HighTotal:     1179628 kB
> > > HighFree:         2080 kB
> > > LowTotal:       888868 kB
> > > LowFree:         40688 kB
> > > SwapTotal:     6257284 kB
> > > SwapFree:      6210124 kB
> > > 
> > > # cat /proc/sys/kernel/shmmax 
> > > 1069547520
> > > 
> > > # cat /proc/sys/kernel/shmall 
> > > 1073741824
> > > 
> > > Please let me know if there are any informations you need.
> > > Thanks in advance for your answer,
> > > regards
> > > ingo.
> > > -- 
> > > // ---------------------------------------------------------------------
> > > // e-dict GmbH & Co. KG
> > > // Ingo Freund         
> > > // Alter Steinweg 3    
> > > // D-20459 Hamburg/Germany                E-Mail: Ingo.Freund@e-dict.net
> > > // ---------------------------------------------------------------------
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
