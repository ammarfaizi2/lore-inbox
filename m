Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130779AbRCPSGt>; Fri, 16 Mar 2001 13:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130791AbRCPSGj>; Fri, 16 Mar 2001 13:06:39 -0500
Received: from mercury.eng.emc.com ([168.159.40.77]:49412 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S130779AbRCPSG1>; Fri, 16 Mar 2001 13:06:27 -0500
Message-ID: <93F527C91A6ED411AFE10050040665D0560667@corpusmx1.us.dg.com>
From: "Sane, Purushottam" <Sane_Purushottam@emc.com>
To: "'Craig Ruff'" <cruff@ucar.edu>,
        Richard Guenther <richard.guenther@student.uni-tuebingen.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: fork and pthreads
Date: Fri, 16 Mar 2001 13:09:14 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not using any signals. All the signals are blocked with SIG_IGN

Nitin Sane
sane_purushottam@emc.com
*(508)382-7319


-----Original Message-----
From: Craig Ruff [mailto:cruff@ucar.edu]
Sent: Friday, March 16, 2001 1:03 PM
To: Richard Guenther
Cc: Sane_Purushottam@emc.com; linux-kernel@vger.kernel.org
Subject: Re: fork and pthreads


On Fri, Mar 16, 2001 at 06:52:26PM +0100, Richard Guenther wrote:
> Well, using pthreads and forking in them seems to trigger libc
> bugs (read: SIGSEGvs) here under certain conditions (happens,
> after I introduced signal handlers and using pthread_sigmask,
> I think), so hangs should be definitely possible, too...

You must pretty much avoid using signal handlers with pthreads.
In stead, you need to carefully setup things such that most signals
are blocked in most threads and a single thread (or selected set
of threads) does a sigwait for signals of interest.  Most good
pthreads books talk about this issue, as does the DCE documentation.
