Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136670AbREGVs0>; Mon, 7 May 2001 17:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136678AbREGVsQ>; Mon, 7 May 2001 17:48:16 -0400
Received: from colorfullife.com ([216.156.138.34]:17683 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S136670AbREGVsL>;
	Mon, 7 May 2001 17:48:11 -0400
Message-ID: <3AF71818.F58139C6@colorfullife.com>
Date: Mon, 07 May 2001 23:48:08 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zero^H^H^H^Hsingle copy pipe
In-Reply-To: <E14wscv-00046J-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > The main problem is that map_user_kiobuf() locks pages into memory.
> > It's a bad idea for pipes. Either we must severely limit the maximum
> 
> You only have to map them for the actual copy.

The current map_user_kiobuf() doesn't have an 'mm' parameter, I can only
use it from the context of the writer.
I could use map_user_kiobuf_mm(), but the kiobuf structure is far too
large, I really don't want a huge structure (> 8 kB?) for a simple 4 kB
single copy transfer.
Including a memset(,0,sizeof(*iobuf) in kiobuf_init().

I think reusing the ptrace interface (access_process_vm()) is the better
solution.

--
	Manfred
