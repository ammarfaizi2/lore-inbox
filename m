Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271868AbRIDBBY>; Mon, 3 Sep 2001 21:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271869AbRIDBBP>; Mon, 3 Sep 2001 21:01:15 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:16433 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S271868AbRIDBBC>; Mon, 3 Sep 2001 21:01:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Patrick Dreker <patrick@dreker.de>
Organization: Chaos Inc.
To: Tim Waugh <twaugh@redhat.com>, Michael Ben-Gershon <mybg@netvision.net.il>
Subject: Re: lpr to HP laserjet stalls
Date: Tue, 4 Sep 2001 02:56:56 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B93E289.7F121DE9@netvision.net.il> <20010903221142.J20060@redhat.com>
In-Reply-To: <20010903221142.J20060@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15e4WO-0007uH-00@wintermute>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag 03 September 2001 23:11 schrieb Tim Waugh:
> On Mon, Sep 03, 2001 at 11:05:29PM +0300, Michael Ben-Gershon wrote:
> > It is intermittent, but very frequent. It is difficult to print more
> > than about 10 sheets without it happening sometime.
>
> Take a look at Documentation/parport.txt: see the 'Troubleshooting'
> section.
I had the same problem here with my Epson Stylus Color 600. I did not matter 
whether I sent the output directly to the printer (cat file.txt > /dev/lp0) 
or used cups or lpd. It just stuck in random places. Fiddling with parport 
settings did not change anything.

In debugging the problem I found out that if one attaches an strace to the 
stuck output process (strace -p pid) the output continues. The strace always 
consisted of either write or read calls (can't remember right now, though 
write seems more logical) the first of which after attaching with strace was 
a request for 8192 Bytes which returned short with usually some 100 bytes. 
All folowing calls had the full 8192 requested Bytes as return value.

All of this vanished, when I replaced all occurrences of /dev/lp0 in my 
printer configuration by /dev/par0. I has been working flawlessly since then.

I have changed quite a bit on my system since that time, but using 
/dev/printers/0 under devfs also works fine here.

> Tim.
> */

-- 
Patrick Dreker
---------------------------------------------------------------------
> Is there anything else I can contribute?
The latitude and longtitude of the bios writers current position, and
a ballistic missile.        
                         Alan Cox on linux-kernel@vger.kernel.org
