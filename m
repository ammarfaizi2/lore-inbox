Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbUA0LIf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 06:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUA0LIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 06:08:34 -0500
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:2208 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263468AbUA0LIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 06:08:30 -0500
Subject: Re: Re : Alsa create high problems...
From: Eddahbi Karim <installation_fault_association@yahoo.fr>
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0401230936130.1875@pnote.perex-int.cz>
References: <1074382859.29525.20.camel@gamux>
	 <1074839589.8684.1.camel@gamux>
	 <Pine.LNX.4.58.0401230936130.1875@pnote.perex-int.cz>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Installation Fault
Message-Id: <1075201490.3661.7.camel@gamux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 12:07:09 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven 23/01/2004 à 09:39, Jaroslav Kysela a écrit :
> On Fri, 23 Jan 2004, Eddahbi Karim wrote:
> 
> > Hiya,
> > 
> > The bug is still there in 2.6.2-rc1 and I still need to do a :
> > while true; do cat /proc/asound/card0/pcm0p/sub0/*; done
> > 
> > To get my sound work properly...
> 
> Ok, let's go. Can you try which files exactly affects the playback?
> If you find one file, can you remove code step-by-step from routines in 
> linux/sound/core/pcm.c snd*read() functions (locate function by strings
> in the proc file).
> 
> I suspect that snd_pcm_stream_lock_irq() and snd_pcm_stream_unlock_irq() 
> will affect this (note that you must remove these calls together).
> 
> 					Thanks,

So here is the report :

1) The file which affects the playback is
/proc/asound/card0/pcm0p/sub0/status

2) I tried to remove only

 snd_pcm_stream_lock_irq(substream);
 snd_pcm_stream_unlock_irq(substream);

3) I tried to remove only
entry->c.text.read = snd_pcm_substream_proc_status_read

4) I tried to remove irq calls, substream proc calls and
proc_status_entry calls

And it still doesn't work but...

pcm.c from my 2.6.2-rc1 and pcm.c from my 2.6.0 are the same...
Or on my 2.6.0 the sound works without any problem...

I use the same elevator "deadline".

I've Preempt enabled on both...

I'll maybe try the standalone version of alsa-drivers with 2.6.2-rc1...
Btw I'll try the 2.6.2-rc2 kernel before.

Best regards,

-- 
Eddahbi Karim <installation_fault_association@yahoo.fr>
Installation Fault

