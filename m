Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132284AbRCWA0T>; Thu, 22 Mar 2001 19:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132285AbRCWA0K>; Thu, 22 Mar 2001 19:26:10 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:896 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132284AbRCWA0A>; Thu, 22 Mar 2001 19:26:00 -0500
Message-ID: <3ABA9919.C6BEABD4@redhat.com>
Date: Thu, 22 Mar 2001 19:30:17 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2ac22
In-Reply-To: <E14gEvg-0003c0-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------6F925B480609C1601E789A8C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6F925B480609C1601E789A8C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

> o       Next incarnation of the i810 audio driver       (Doug Ledford)

Is this the i810 that's in Red Hat's CVS or the last copy of the big file that
I sent you?  If it's the last copy of the big file I sent you, then it has a
memory leak that needs fixed.  I committed the fix for the memory leak to the
CVS archive something like two days ago.  The patch is attached.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
--------------6F925B480609C1601E789A8C
Content-Type: text/plain; charset=us-ascii;
 name="linux-2.4.2-i810_audio-dealloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.2-i810_audio-dealloc.patch"

--- linux/drivers/sound/i810_audio.c.save	Wed Mar 21 20:44:29 2001
+++ linux/drivers/sound/i810_audio.c	Wed Mar 21 20:44:34 2001
@@ -1820,12 +1820,11 @@
 			return -EBUSY;
 		}
 		stop_dac(state);
-		dealloc_dmabuf(state);
 	}
 	if(dmabuf->enable & ADC_RUNNING) {
 		stop_adc(state);
-		dealloc_dmabuf(state);
 	}
+	dealloc_dmabuf(state);
 	if (file->f_mode & FMODE_WRITE) {
 		state->card->free_pcm_channel(state->card, dmabuf->write_channel->num);
 	}

--------------6F925B480609C1601E789A8C--

