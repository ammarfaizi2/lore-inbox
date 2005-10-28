Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbVJ1Owb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVJ1Owb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVJ1Owa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:52:30 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:46437 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030202AbVJ1Ow3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:52:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XuvMUSbQu2OxrK6aFEPt0y507gmuBQy1CNc5SE7bhVPfaWqLLNJ4aAuKGMnFQ87gBm9PQPggMKUmXTh1Tz7m6W0HoRADh9R+bdKxjqL8QnadlPJuqmxVBLveSC5qfpJ9ZbdipAEGqCdT0O0vFpaOANrEDFUDZHdcXEg1BpEGIkM=
Message-ID: <5bdc1c8b0510280752y5b7a665cpfdd512d15f896482@mail.gmail.com>
Date: Fri, 28 Oct 2005 07:52:27 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Overruns are killing my recordings.
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1130470852.4363.26.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3aa654a40510271212j13e0843s9de81c02f4e766ac@mail.gmail.com>
	 <200510271528.28919.diablod3@gmail.com>
	 <3aa654a40510271257t62d2fd82n5f2bcbcae2bcba9d@mail.gmail.com>
	 <1130447216.19492.87.camel@mindpipe>
	 <3aa654a40510271700l49fb06cfv37d8b6030df5ac49@mail.gmail.com>
	 <1130470852.4363.26.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Thu, 2005-10-27 at 17:00 -0700, Avuton Olrich wrote:
> > aggh. Sorry for all the noise,
> >
> > I have all my drives on a linear raid and I had hdparm set to put my
> > IDE drives to sleep after a while, I didn't put it together because it
> > was happening in the middle of recording.
>
> Hey, I think it's a testament to the progress that has been made in the
> past year and a half that people now consider audio dropouts in a "known
> good" app like ecasound to be a kernel bug.  For the longest time the
> answer was "linux isn't an RTOS, deal with it".
>
> Lee

Lee, et. all,
   Could this possibly be part of what is causing my xrun problems? I
had a huge rash of xruns yesterday. I seem to run into issues after
longer times of inactivity. I hadn't considered this possibility
before.

   Unfortunately I don't know how to fix this for SATA drives? hdparm
doesn't say much and sdparm gives me info I don't understand:

lightning ~ # hdparm /dev/sda

/dev/sda:
 IO_support   =  0 (default 16-bit)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 30401/255/63, sectors = 250059350016, start = 0
lightning ~ #

lightning ~ # sdparm /dev/sda
    /dev/sda: ATA       ST3250823AS       3.03
Read write error recovery mode page:
  AWRE        1  [ sav:  1]
  ARRE        1  [ sav:  1]
  PER         0  [ sav:  0]
Caching (SBC) mode page:
  WCE         1  [ sav:  1]
  RCD         0  [ sav:  0]
Control mode page:
  SWP         0  [ sav:  0]
lightning ~ #

Drive performance seems good:

lightning ~ # hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   2200 MB in  2.00 seconds = 1100.12 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
ioctl for device
 Timing buffered disk reads:  198 MB in  3.03 seconds =  65.45 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
ioctl for device
lightning ~ #

I'm still waiting for someone to address the problem where I cannot
build 2.4.16-rc5-rt7 so this is on -rt3.

Thanks,
Mark
