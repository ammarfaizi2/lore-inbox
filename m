Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285310AbRLNBid>; Thu, 13 Dec 2001 20:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285309AbRLNBiY>; Thu, 13 Dec 2001 20:38:24 -0500
Received: from mailb.telia.com ([194.22.194.6]:28685 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S285305AbRLNBiN>;
	Thu, 13 Dec 2001 20:38:13 -0500
Message-Id: <200112140138.fBE1c4529186@mailb.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-rc1
Date: Fri, 14 Dec 2001 02:35:47 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.21.0112131841080.28446-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0112131841080.28446-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday den 13 December 2001 21.44, Marcelo Tosatti wrote:
> Hi,
>
> I've just copied 2.4.17-rc1 to ftp.kernel.org... Its mirroring yet,
> probably.
>
> Well, I want people with the "unfreeable" buffer/cache problem to confirm
> with me that 2.4.17-rc1 is working ok.
>
> The same change which should fix that problem also should make 2.4 a bit
> less "swap happy".
>
>

Hi,

I have run some "files bigger than memory" (streaming) tests.
Some significant differences with earlier kernel:

* write - lowered throughput (26 MB/s => 22 MB/s)

* copy - throughput better by 2/3 (16 MB/s => 25 MB/s) !

* dbench 32 - back down to lower than 2.4.12 (due to increased fairness?)
	2.4.11				18.9 MB/s
	2.4.12				23.3 MB/s
	2.4.16				34.9 MB/s
	2.4.17-rc1			20.3 MB/s
	2.4.17-rc1 (file-readahead:1000)	24.5 MB/s
	[lets forget about them now...]

* diff - usage of "file-readahead" more than doubles efficency
	(most-kernels: 11 MB/s => 2.4.17-rc1 with readahead: 25 MB/s)

The nicest thing is that it is the first kernel where readahead tuning is not 
necessary for the copy operation.
Now it is only multiple-big-concurrent-reads that _needs_ "file-readahead"

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
