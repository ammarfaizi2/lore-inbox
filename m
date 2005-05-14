Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVENJjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVENJjP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 05:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVENJgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 05:36:17 -0400
Received: from ns01.oncom.de ([62.153.157.5]:1240 "EHLO ms01.oncom.de")
	by vger.kernel.org with ESMTP id S262719AbVENJ2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 05:28:01 -0400
Date: Sat, 14 May 2005 12:50:51 +0200
From: Andreas Stenglein <a.stenglein@gmx.net>
To: Ryan Richter <ryan@solarneutrino.net>
Cc: Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: DRI lockup on R200, 2.6.11.7
Message-ID: <20050514105051.GC8956@buche.local>
References: <20050426202916.GA2635@xarello> <21d7e99705042801227ed5438e@mail.gmail.com> <20050511162159.GA19046@tau.solarneutrino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050511162159.GA19046@tau.solarneutrino.net> (from ryan@solarneutrino.net on Mi, Mai 11, 2005 at 18:21:59 +0200)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.05.2005 18:21:59 schrieb(en) Ryan Richter:

> Another one today, but it's a little different now.  I got to see this
> happen from the beginning today.  A few minutes before the crash, 3D
> operations become very slow.  When X hangs, it's now doing this:
> 

when comparing radeon_tcl.c with r200_tcl.c I noticed:

in radeon_tcl.c:
#define CLOSE_ELTS()  RADEON_NEWPRIM( rmesa )


in r200_tcl.c:
#define CLOSE_ELTS()                            \
do {                                            \
   if (0) R200_NEWPRIM( rmesa );                \
}                                               \
while (0)


Does the lockup occur when disabling hw-tcl?

best regards,
Andreas
