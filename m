Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288951AbSANTun>; Mon, 14 Jan 2002 14:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288984AbSANTt3>; Mon, 14 Jan 2002 14:49:29 -0500
Received: from ns.ithnet.com ([217.64.64.10]:37127 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288951AbSANTsf>;
	Mon, 14 Jan 2002 14:48:35 -0500
Date: Mon, 14 Jan 2002 20:48:18 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory problem with bttv driver
Message-Id: <20020114204818.24a253cc.skraw@ithnet.com>
In-Reply-To: <E16QBLq-0002Mu-00@the-village.bc.nu>
In-Reply-To: <20020114184334.0a1712d4.skraw@ithnet.com>
	<E16QBLq-0002Mu-00@the-village.bc.nu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002 17:56:54 +0000 (GMT)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > Can this be highmem-related?
> 
> That would make complete sense if so. The bttv uses vmalloc_32(), as the
> card has 32bit limits, and I am not running bttv (nor I suspect are most
> people) with highmem enabled

Ok. I tracked it down. It is definitely VMALLOC-stuff. I increased the
VMALLOC_RESERVE from 128 to 256 MB and now it _works_. Here is a list of loaded
modules, maybe one (or several) of those are known to be vmalloc-fans :-)


Module                  Size  Used by
tuner                   8048   1  (autoclean)
bttv                   60848   0 
i2c-algo-bit            7040   1  [bttv]
i2c-core               12224   0  [tuner bttv i2c-algo-bit]
videodev                4768   2  [bttv]
NVdriver              720128  14  (autoclean)
parport_pc             12432   1  (autoclean)
lp                      5984   0  (autoclean)
parport                12736   1  (autoclean) [parport_pc lp]
nfs                    73024   2  (autoclean)
lockd                  47056   1  (autoclean) [nfs]
sunrpc                 62496   1  (autoclean) [nfs lockd]
ipv6                  158464  -1  (autoclean)
uhci                   24896   0  (unused)
usbcore                48640   1  [uhci]
3c59x                  25312   1  (autoclean)
emu10k1                58080   0 
sound                  54064   0  [emu10k1]
ac97_codec              9504   0  [emu10k1]
hisax                 168112   4 
isdn                  115088   6  [hisax]
slhc                    4304   0  [isdn]
serial                 44128   0  (autoclean)


How can I find out?

Regards,
Stephan

