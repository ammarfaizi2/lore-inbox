Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263423AbUJ2Q1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbUJ2Q1s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 12:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbUJ2QXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 12:23:10 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22951 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263365AbUJ2QUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:20:43 -0400
Date: Fri, 29 Oct 2004 18:21:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029162154.GA7020@elte.hu>
References: <20041029090957.GA1460@elte.hu> <200410291101.i9TB1uhp002490@localhost.localdomain> <20041029111408.GA28259@elte.hu> <20041029161433.GA6717@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20041029161433.GA6717@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Ingo Molnar <mingo@elte.hu> wrote:

> the BKL can generate arbitrary latencies. Anything up to 100-200
> milliseconds. Rui, Florian, could you try the quick hack below?

hm, this alone probably wont work, because the audio layer does
unlock_kernel() in many places.

could you try another hack in addition to the ioctl.c hack, save the
attached script, and do this in your Linux source tree:

	cd sound
	~/changeall-tree "unlock_kernel()" ""
	~/changeall-tree "lock_kernel()" ""

(in strictly this order.) This gets rid of the BKL from the sound
subsystem in quite drastic ways... Totally untested, so be careful ...

	Ingo


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=changeall-tree

#!/bin/bash

if [ $# -lt "2" ]; then
        echo 'usage: changeall <from> <to>'
	exit -1;
fi

echo "changing $N => $N"

for N in `find . -type f`; do
  echo $N;
  cat $N | sed "s/$1/$2/g" > .tmp; mv .tmp $N;
done

--cWoXeonUoKmBZSoM--
