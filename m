Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263903AbRFDVpB>; Mon, 4 Jun 2001 17:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263904AbRFDVov>; Mon, 4 Jun 2001 17:44:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19981 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263903AbRFDVoh>; Mon, 4 Jun 2001 17:44:37 -0400
Subject: Re: disk-based fds in select/poll
To: pp@ludusdesign.com (Pierre Phaneuf)
Date: Mon, 4 Jun 2001 22:42:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B1BF2FA.B74A1B78@ludusdesign.com> from "Pierre Phaneuf" at Jun 04, 2001 04:43:38 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E157277-000603-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am thinking that a read() (or sendfile()) that would block because the
> pages aren't in core should instead post a request for the pages to be
> loaded (some kind of readahead mecanism?) and return immediately (maybe
> having given some data that *was* in core). A subsequent read() could

reads posts a readahead anyway so streaming reads tend not to block much

> SGI's AIO might be a solution here, does it use threads? I'm trying to
> avoid context switching as much as possible, to keep the CPU cache as
> warm as possible.

glibc 2.2 does thread based aio_ and it will tend to avoid cache damage as
the thread share the mm but on SMP its quite possible the read wil occur on
the other CPU. Of course kernel based I/O might do the same too..

