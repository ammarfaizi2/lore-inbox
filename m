Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289859AbSBEXUf>; Tue, 5 Feb 2002 18:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289862AbSBEXTa>; Tue, 5 Feb 2002 18:19:30 -0500
Received: from maila.telia.com ([194.22.194.231]:2559 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S289859AbSBEXSy>;
	Tue, 5 Feb 2002 18:18:54 -0500
Message-Id: <200202052318.g15NIfF27385@maila.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Ed Tomlinson <tomlins@cam.org>,
        list linux-kernel <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Retest: Re: New VM Testcase (2.4.18pre7 SWAPS) (2.4.17-rmap12b OK)
Date: Wed, 6 Feb 2002 00:15:36 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200202042227.g14MRFN12329@maile.telia.com> <20020205003614.1036BF6E7@oscar.casa.dyndns.org>
In-Reply-To: <20020205003614.1036BF6E7@oscar.casa.dyndns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesdayen den 5 February 2002 01.36, Ed Tomlinson wrote:
> On February 4, 2002 05:24 pm, Roger Larsson wrote:
> > When examining Karlsbakk problem I got into one quite different myself.
> >
> > I have a 256MB UP PII 933 MHz.
> > When running the included program with an option of 200
> > (serving 200 clients with streaming data á 10MB... on first run
> > it creates the data, from /dev/urandom - overkill from /dev/null is ok!)
> >
> > ddteset.sh 200
> > [testcase initially written by Roy Sigurd Karlsbakk, he does not get
> > into this - but he has more RAM]
> >

I rerun the testcases, this time the 2.4.18-pre8 did not go as deep - and 
survived. But had worse performance - then I remembered... I had added
file readahead. Retested again - it still survived...

echo "file_readahead:255"> /proc/ide/hda/settings

The results from all tested kernels standard and with readahead follows...

2.4.18pre7
	start: with 'bi' at 12000
	after awhile 'bi' hovers at 7000-9000 (sporadic swap outs)
	after yet some time it starts to swap in too - but without performance loss

2.4.18pre7 with file_readahead:255
	start: bi at 15000-18000
	after awhile heavy swap out: 600(!)-10000
	after yet some time, now with swap in too: 1000-6000

2.4.18pre7 w. Ed Tomlinsons patch
	start: bi at 12000
	stays at: 9000-12000
	more swapout causes throughput loss: 5000-9000
	but finally stabilizes at 7000-10000

2.4.18pre7 w. Ed Tomlinsons patch and file_readahead
	start: bi at 15000-23000
	...
	rather soon ends up in both swapping in and out...
	(about the same throughput at 2.4.18pre7)

2.4.17rmap12c
	during the whole testrun: bi at 10000-12000
	exept for some short dips downto at most 8000

2.4.17rmap12c with file_readahead
	during whole testrun: bi at 20000-23000
	short dips downto 16000 (once 9000)

This should be a picture, but... some other day...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
