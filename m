Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316605AbSE0KyX>; Mon, 27 May 2002 06:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316607AbSE0KyW>; Mon, 27 May 2002 06:54:22 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:61947 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316605AbSE0KyV>; Mon, 27 May 2002 06:54:21 -0400
Subject: Re: [patch] Add i8253 spinlocks where needed.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Manik Raina <manik@cisco.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020527121001.B26811@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 12:56:20 +0100
Message-Id: <1022500580.11859.252.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 11:10, Vojtech Pavlik wrote:
> Well, probably yes, but still hd.c is a glacial relict, a driver nobody
> (almost - it's for non-IDE "two ribbon" AT harddrives) uses. So this
> driver is probably not enough justification for a global (as in all
> archs) spinlock being added. 

It only uses the timer in the case that HD_DELAY > 0. This code is
ultimately used for timing functions. A better approach would be to
remove the use of the timer chip from the file entirely and use the
perfectly adequate udelay() function instead.

That would also conveniently make it do cpu_relax properly improving the
performance of your ancient IDE controller when plugged into
hyperthreading pentium IV 8)

Alan
