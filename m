Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267957AbTAKSgv>; Sat, 11 Jan 2003 13:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267950AbTAKSgv>; Sat, 11 Jan 2003 13:36:51 -0500
Received: from pcp02781107pcs.eatntn01.nj.comcast.net ([68.85.61.149]:12784
	"EHLO linnie.riede.org") by vger.kernel.org with ESMTP
	id <S267952AbTAKSgu>; Sat, 11 Jan 2003 13:36:50 -0500
Date: Sat, 11 Jan 2003 13:45:04 -0500
From: Willem Riede <wrlk@riede.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Paul Rolland <rol@as2917.net>, linux-kernel@vger.kernel.org,
       rol@as2917.net, linux-scsi@vger.kernel.org
Subject: Re: [BUG - 2.5.56] bad: scheduling while atomic
Message-ID: <20030111184504.GX1378@linnie.riede.org>
Reply-To: wrlk@riede.org
References: <003d01c2b95d$e7a6a370$2101a8c0@witbe> <200301110949.48169.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200301110949.48169.akpm@digeo.com>; from akpm@digeo.com on Sat, Jan 11, 2003 at 12:49:48 -0500
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003.01.11 12:49 Andrew Morton wrote:
> On Sat January 11 2003 02:40, Paul Rolland wrote:
> >
> > Hello,
> >
> > Trying 2.5.56 this morning, I ended up with the trace included below.
> > To get that, I simply added a
> > "hdd=ide-scsi"
[snip]
> > ide-scsi: abort called for 21
> > bad: scheduling while atomic!
[snip]
> Well this backtrace is not the reason why ide-scsi fails to work - it is
> being triggered as a consequence of the I/O failure.
> 
> This trace is due to the following bug:
> 
> scsi_try_to_abort_cmd() takes spin_lock_irqsave(scmd->host->host_lock, flags);
> then it calls ide_scsi_abort()
> ide_scsi_abort() calls scsi_sleep(), still inside ->host_lock.
> 
That would be my mistake. scmd->host->host_lock doesn't need to be held during
the sleep. I'll come up with a patch.

Thanks, Willem Riede.
