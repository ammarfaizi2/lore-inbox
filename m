Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290056AbSAKS0R>; Fri, 11 Jan 2002 13:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290058AbSAKS0J>; Fri, 11 Jan 2002 13:26:09 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:22400 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S290056AbSAKSZ5> convert rfc822-to-8bit;
	Fri, 11 Jan 2002 13:25:57 -0500
Message-Id: <200201111825.g0BIPd805094@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: Doug Ledford <dledford@redhat.com>
Subject: Re: i810_audio driver v0.19 still freezes machine
Date: Fri, 11 Jan 2002 20:25:39 +0200
X-Mailer: KMail [version 1.3.2]
Cc: tom@infosys.tuwien.ac.at, linux-kernel@vger.kernel.org
In-Reply-To: <E16Okz2-0005JM-00@the-village.bc.nu> <200201111147.g0BBl5a01992@hal.astr.lu.lv> <3C3F0AA0.8030407@redhat.com>
In-Reply-To: <3C3F0AA0.8030407@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 January 2002 17:54, Doug Ledford wrote:
> Andris Pavenis wrote:
> > Tried. I haven't been able to freeze box after some not very long
> > torturing with artsd, but there is another new trouble:
> >
> > For test I'm letting artsd to play some WAV file and after that give some
> > time for it to close /dev/dsp. After some times there is no more sound
> > and I'm getting a message that /dev/dsp is busy when trying to restart
> > artsd. Anyway I can reload i810_audio driver and restart artsd to get
> > sound working again. 'fuser /dev/dsp' also doesn't show that it is opened
>
> Actually, as a couple people have pointed out to me, the version on my site
> was somehow a .19 version.  I've placed the real .20 on my site as of a few
>   minutes ago, so please try with it (and the real .20 should solve the
> problem you are related Andris in that it won't allow the driver to accept
> signals during close, which is why /dev/dsp would quit working for you).

Thanks

Earlier today I didn't take v0.19 today from You're page, but patched 
previous v0.19 with Your patch posted to linux-kernel mailing list yesterday 
evening.

Now about v0.20. Seems that it survives following torture:
   
- setup artsd to close /dev/dsp after 1 second idle

-  running something like 
	while true; do artsplay beep.wav; sleep 3s; done

Kernel version 2.4.18-pre3

Only one purely cosmetical patch to avoid unnecessary warning from gcc
(I used gcc-2.95.3):

--- i810_audio.c-0.20	Fri Jan 11 15:48:32 2002
+++ i810_audio.c	Fri Jan 11 19:54:05 2002
@@ -1739,7 +1739,7 @@
 #endif
 		if (dmabuf->enable != DAC_RUNNING || file->f_flags & O_NONBLOCK)
 			return 0;
-		if(val = drain_dac(state, 1))
+		if((val = drain_dac(state, 1)))
 			return val;
 		dmabuf->total_bytes = 0;
 		return 0;


Andris
