Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129621AbQKGHVK>; Tue, 7 Nov 2000 02:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbQKGHVC>; Tue, 7 Nov 2000 02:21:02 -0500
Received: from clavin.efn.org ([206.163.176.10]:18172 "EHLO clavin.efn.org")
	by vger.kernel.org with ESMTP id <S129621AbQKGHUv>;
	Tue, 7 Nov 2000 02:20:51 -0500
From: Steve VanDevender <stevev@efn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14855.44343.68279.953178@localhost.efn.org>
Date: Mon, 6 Nov 2000 23:20:23 -0800
To: David Feuer <David_Feuer@brown.edu>
Cc: linux-kernel@vger.kernel.org
Subject: sound driver persistent state
In-Reply-To: <4.3.2.7.2.20001106230925.00ac6370@postoffice.brown.edu>
In-Reply-To: <4.3.2.7.2.20001106230925.00ac6370@postoffice.brown.edu>
X-Mailer: VM 6.77 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Feuer writes:
 > People keep saying it's OK to start muted on boot, but I must say that I 
 > don't think this is really acceptable....  I may very well want to set my 
 > mixer and just leave it that way forever.... would there be any way to give 
 > the sound driver a scribble pad on disk to let it sa

You can't guarantee that the mixer will retain its settings across a
hardware reset, APM suspend/resume cycle, or power cycle.

The typical ALSA installation runs an "alsactl restore" after loading
the driver modules to set the initial mixer levels, and an "alsactl
store" on shutdown to save the mixer levels before unloading the
modules.  This seems to work fine on my laptop, and is in user space
where it belongs.  In fact, on my laptop the intel8x0 driver can't cope
with a suspend/resume cycle while loaded or it hangs after the resume,
so my APM scripts unload the ALSA drivers every time I suspend and
reload them every time I resume.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
