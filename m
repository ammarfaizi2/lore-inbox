Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRCPSET>; Fri, 16 Mar 2001 13:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130779AbRCPSEJ>; Fri, 16 Mar 2001 13:04:09 -0500
Received: from niwot.scd.ucar.edu ([128.117.8.223]:26817 "EHLO
	niwot.scd.ucar.edu") by vger.kernel.org with ESMTP
	id <S130768AbRCPSD4>; Fri, 16 Mar 2001 13:03:56 -0500
Date: Fri, 16 Mar 2001 11:03:14 -0700
From: Craig Ruff <cruff@ucar.edu>
To: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
Cc: Sane_Purushottam@emc.com, linux-kernel@vger.kernel.org
Subject: Re: fork and pthreads
Message-ID: <20010316110314.A24149@bells.scd.ucar.edu>
In-Reply-To: <93F527C91A6ED411AFE10050040665D0560664@corpusmx1.us.dg.com> <Pine.LNX.4.30.0103161850040.517-100000@fs1.dekanat.physik.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0103161850040.517-100000@fs1.dekanat.physik.uni-tuebingen.de>; from richard.guenther@student.uni-tuebingen.de on Fri, Mar 16, 2001 at 06:52:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
