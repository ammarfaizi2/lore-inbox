Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbRGIL1z>; Mon, 9 Jul 2001 07:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbRGIL1p>; Mon, 9 Jul 2001 07:27:45 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:33179 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S267028AbRGIL13>; Mon, 9 Jul 2001 07:27:29 -0400
From: Christoph Rohland <cr@sap.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107091130580.448-100000@mikeg.weiden.de>
Organisation: SAP LinuxLab
Date: 09 Jul 2001 13:25:31 +0200
In-Reply-To: <Pine.LNX.4.33.0107091130580.448-100000@mikeg.weiden.de>
Message-ID: <m3vgl28huc.fsf@linux.local>
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
>> But still this may be a hint. You are not running out of swap,
>> aren't you?
> 
> I'm running oom whether I have swap enabled or not.  The inactive
> dirty list starts growing forever, until it's full of (aparantly)
> dirty pages and I'm utterly oom.
>
> With swap enabled, I keep allocating until there's nothing left.
> Actual space usage is roughly 30mb (of 256mb), but when you can't
> allocate anymore you're toast too, with the same dirt buildup.

AFAIU you are running oom without the oom killer kicking in. 

That's reasonable with tmpfs: the tmpfs pages are accounted to the
page cache, but are not freeable if there is no free swap space. So
the vm tries to free memory without success. (The same should be true
for ramfs but exaggerated by the fact that ramfs can never free the
page)

In the -ac series I introduced separate accounting for shmem pages and
do reduce the page cache size by this count for meminfo and
vm_enough_memory. Perhaps the oom coding needs also some knowledge
about this?

Greetings
		Christoph


