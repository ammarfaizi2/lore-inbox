Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266534AbRGII1u>; Mon, 9 Jul 2001 04:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266017AbRGII1k>; Mon, 9 Jul 2001 04:27:40 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:55941 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S266534AbRGII10>; Mon, 9 Jul 2001 04:27:26 -0400
From: Christoph Rohland <cr@sap.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107090944120.305-100000@mikeg.weiden.de>
Organisation: SAP LinuxLab
Date: 09 Jul 2001 10:25:25 +0200
In-Reply-To: <Pine.LNX.4.33.0107090944120.305-100000@mikeg.weiden.de>
Message-ID: <m3wv5iik5m.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Mon, 9 Jul 2001, Mike Galbraith wrote:
> I don't know exactly what is happening, but I do know _who_ is
> causing the problem I'm seeing.. it's tmpfs.  When mounted on /tmp
> and running X/KDE, the tar [1] will oom my box every time because
> page_launder trys and always failing to get anything scrubbed after
> the tar has run for a while.  Unmount tmpfs/restart X and do the
> same tar, and all is well.
> 
> (it's not locked pages aparantly. I modified page_launder to move
> those to the active list, and refill_inactive_scan to rotate them to
> the end of the active list.  inactive_dirty list still grows ever
> larger, filling with 'stuff' that page_launder can't clean until
> you're totally oom)

Do you have set the size parameter for tmpfs? Else it will grow until
oom.

Another point I see with tmpfs is the following: tmpfs writepage
simply moves the page to the swap cache. But it does not schedule a
writeout of the page. So we have to scan the swap cache to really free
memory.

Greetings
		Christoph


