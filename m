Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265843AbTF3Lxj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 07:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265851AbTF3Lxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 07:53:39 -0400
Received: from mail.ithnet.com ([217.64.64.8]:31500 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S265843AbTF3Lxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 07:53:38 -0400
Date: Mon, 30 Jun 2003 14:08:04 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, stoffel@lucent.com, willy@w.ods.org,
       kpfleming@cox.net, gibbs@scsiguy.com, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030630140804.4fa20313.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.55L.0306300838200.19541@freak.distro.conectiva>
References: <20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
	<16103.39056.810025.975744@gargle.gargle.HOWL>
	<20030613114531.2b7235e7.skraw@ithnet.com>
	<20030625191655.GA15970@alpha.home.local>
	<20030625214221.2cd9613f.skraw@ithnet.com>
	<16122.1630.134766.108510@gargle.gargle.HOWL>
	<20030626133415.4417e2e6.skraw@ithnet.com>
	<20030630121017.1ebc1cf4.skraw@ithnet.com>
	<Pine.LNX.4.55L.0306300838200.19541@freak.distro.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003 08:39:38 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> 
> 
> On Mon, 30 Jun 2003, Stephan von Krawczynski wrote:
> 
> > Hello all,
> >
> > it looks like the problem gets worse currently. This is the second day I
> > see 4 verification errors. This is with kernel 2.4.22-pre2 now.
> 
> 
> As far as I understood, the tape is corrupting the data (or writting, or
> when reading back).
> 
> Is this correct?

Actually my guess is that the _data_ itself is not corrupt, neither the
original set located on 3ware RAID nor the backup'ed set on aic-connected SDLT.
The problem is - according to my personal opinion - flawed during the readback
that occurs while verifying. I do not know if the data is already corrupted by
the aic-driver (less probable currently) or some flaw inside the caching of the
_original_ set. The situation is complex because of the multiple involved
subsystems. 

My experience is this:

If you reboot and make backup/verify cycle from 3ware to aic/tape everything
seems fine.

If you reboot and push data over NFS to 3ware-disk, then do the backup/verify
cycle (with this data) from 3ware to aic/tape the corruption is very likely.

If you do try another verify run of the data you see corruptions happen on
_other_ files than the verify before. It is therefore unlikely that both data
"ends" are part of the problem, because you would expect the same corruptions
to show up - at least this is my hope.

Regards,
Stephan

