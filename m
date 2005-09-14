Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbVINQpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbVINQpn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbVINQpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:45:43 -0400
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:30549 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S965249AbVINQpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:45:42 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Bill Davidsen'" <davidsen@tmr.com>, "'liyu@WAN'" <liyu@ccoss.com.cn>
Cc: <Linux-newbie@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Problem booting 2.6.13 on RHEL 4
Date: Wed, 14 Sep 2005 11:50:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcW5SGv29aJIctN2Sv+i/FZeKGRu8wAA3zOw
In-Reply-To: <43284DD0.5080709@tmr.com>
Message-ID: <EXCHG2003MFaukyCKDk00000794@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 14 Sep 2005 16:42:04.0815 (UTC) FILETIME=[3D1131F0:01C5B94B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Bill Davidsen
> Sent: Wednesday, September 14, 2005 11:21 AM
> To: liyu@WAN
> Cc: Linux-newbie@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: Problem booting 2.6.13 on RHEL 4
> 
> liyu@WAN wrote:
> > 
> > It seem that kernel have no time to probe your disk, and do 
> not read 
> > parttion table.
> > 
> > I use kernel 2.6.12 and SATA disk on FC3, also failed to boot.
> > but after some experiment, I found if we place 'sleep 5'
> > statement between insmod commands in linuxrc or init, it 
> will boot up!
> > 
> > However, this idea is too HACK.
> 
> It would have been nice, back in the 2.5.46 timeframe when 
> modules were complete reinvented, to have provided a hook by 
> which modprobe could have waited until insertion init was complete.
> 
> The sleep is a hack indeed, as is the slightly more reliable 
> solution to tail the log and look for init messages to 
> appear. Perhaps look for the devices in /proc/scsi/scsi or something?
> 
> There doesn't seem to be a "right way" for this, particularly 
> if you have both warm and cold boots, which may differ by 
> minutes depending on disk spin-up already being done.
> 

I have seen this.

On one machine with 2 scsi adaptors 10 seconds was enough, on a different
machine with 6 channels it had to be over 45 seconds to get things to be
found reliabily, and I don't know if that is always going to be reliable.

It would have been nice if there were at least an option on modprobe so
that it could be set to not return after init on the critical modules,
ie mostly disk modules, but I have seen failures on other parts because
the modprobe is not quite finished and ready for the next step after
it returns.

Any better way to deal with this?

                        Roger

