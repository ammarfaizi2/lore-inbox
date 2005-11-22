Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVLUAra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVLUAra (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 19:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVLUAra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 19:47:30 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:49591 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S932186AbVLUAr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 19:47:29 -0500
Message-ID: <00ad01c5eefd$7990b370$a700a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Roger Heflin" <rheflin@atipa.com>
Cc: <linux-kernel@vger.kernel.org>
References: <EXCHG2003iSnRMWuLn500000618@EXCHG2003.microtech-ks.com>
Subject: Re: buffer cache question
Date: Tue, 22 Nov 2005 01:41:22 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have read back in the kernel-archives, and found this messages, about the
same theme, but there is one difference!

On the old messages:
>Nate Diller wrote:
> just found the culprit.  guess i should have read the code the first
> time.  get_dirty_limits() in drivers/block/page_writeback.c has a
> hard-coded upper limit to dirty_ratio.  it's capped to half of the
> unmapped pages, so maybe 30-40% of your system's memory.  so if you are
> brave, just remove the "/ 2" parts from the 'if (dirty_ratio >
> unmapped_ratio / 2) dirty_ratio = unmapped_ratio / 2;' check, and you
> can have all the OOM goodness you want.
...
>I changed that bit of code to:
>
> if (dirty_ratio > unmapped_ratio - 10)
>  dirty_ratio = unmapped_ratio - 10;
>
>and added a couple of sanity checks so that it couldn't get below 5 or
above 95.
>
>Then set /proc/sys/vm/dirty_ratio to 95 and dirty_background_ratio to 1.

In this case, this modification is only for the *dirty* memory buffer.
I want to use more buffer *cache*! :-)
The unwritten dirty memory ratio is good enough for me.

Anybody has an idea?

Cheers,
Janos

----- Original Message ----- 
From: "Roger Heflin" <rheflin@atipa.com>
To: "'JaniD++'" <djani22@dynamicweb.hu>; <linux-kernel@vger.kernel.org>
Sent: Monday, December 19, 2005 7:15 PM
Subject: RE: buffer cache question


>
>
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of JaniD++
> > Sent: Sunday, December 18, 2005 3:09 PM
> > To: linux-kernel@vger.kernel.org
> > Subject: buffer cache question
> >
> > Hello, list,
> >
> > I use 4 disk nodes with NBD.
> > All of my nodes have 2GB ram.
> >
> > But the buffer cache newer rise over 830MB.
> >
> > Is there some limit?
>
> For writes only 40% of the ram can be "dirty".
>
> > Where can i change this limit? (if it is)
>
> I believe there is a way to change it, I am pretty sure that it has
> been discussed on the kernel list a couple of months ago, I
> don't remember exactly what the change is, and I think the change
> was more complicated that was obvious.
>
> The previous subject on a similar thing was:
> "kernel 2.6.13 buffer strangeness"
>
>                            Roger
>
> >
> > Thanks,
> > Janos
> >
> > [root@st-0001 root]# free
> >              total       used       free     shared
> > buffers     cached
> > Mem:       2073152     933188    1139964          0
> > 836776      43416
> > -/+ buffers/cache:      52996    2020156
> > Swap:            0          0          0
> > [root@st-0001 root]# cat /proc/meminfo
> > MemTotal:      2073152 kB
> > MemFree:       1139012 kB
> > Buffers:        835928 kB
> > Cached:          43448 kB
> > SwapCached:          0 kB
> > Active:          12872 kB
> > Inactive:       871424 kB
> > HighTotal:     1179584 kB
> > HighFree:      1129764 kB
> > LowTotal:       893568 kB
> > LowFree:          9248 kB
> > SwapTotal:           0 kB
> > SwapFree:            0 kB
> > Dirty:               0 kB
> > Writeback:           0 kB
> > Mapped:           9104 kB
> > Slab:            30248 kB
> > CommitLimit:   1036576 kB
> > Committed_AS:    15428 kB
> > PageTables:        408 kB
> > VmallocTotal:   114680 kB
> > VmallocUsed:       196 kB
> > VmallocChunk:   114476 kB
> > [root@st-0001 root]#
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to
> > majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

