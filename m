Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282706AbRK0BNG>; Mon, 26 Nov 2001 20:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282707AbRK0BMz>; Mon, 26 Nov 2001 20:12:55 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:57862 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282706AbRK0BMk>; Mon, 26 Nov 2001 20:12:40 -0500
Message-ID: <3C02E856.A24BACD5@zip.com.au>
Date: Mon, 26 Nov 2001 17:11:50 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <0111261535070J.02001@localhost.localdomain> <20011126165920.N730@lynx.no> <9tumf0$dvr$1@cesium.transmeta.com> <9tuo54$e8p$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> Followup to:  <9tumf0$dvr$1@cesium.transmeta.com>
> By author:    "H. Peter Anvin" <hpa@zytor.com>
> In newsgroup: linux.dev.kernel
> >
> > Indeed; having explicit write barriers would be a very useful feature,
> > but the drives MUST default to strict ordering unless reordering (with
> > write barriers) have been enabled explicitly by the OS.
> >
> 
> On the subject of write barriers... such a setup probably should have
> a serial number field for each write barrier command, and a "WAIT FOR
> WRITE BARRIER NUMBER #" command -- which will wait until all writes
> preceeding the specified write barrier has been committed to stable
> storage.  It might also be worthwhile to have the equivalent
> nonblocking operation -- QUERY LAST WRITE BARRIER COMMITTED.
> 

For ext3 at least, all that is needed is a barrier which says
"don't reorder writes across here".  Asynchronous behaviour
beyond that is OK - the disk is free to queue multiple transactions
internally as long as the barriers are observed.  If the power
goes out we'll just recover up to and including the last-written
commit block.

-
