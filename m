Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281527AbRLAKKW>; Sat, 1 Dec 2001 05:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284040AbRLAKKH>; Sat, 1 Dec 2001 05:10:07 -0500
Received: from castle.nmd.msu.ru ([193.232.112.53]:35601 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S281527AbRLAKJr>;
	Sat, 1 Dec 2001 05:09:47 -0500
Message-ID: <20011201131759.B11856@castle.nmd.msu.ru>
Date: Sat, 1 Dec 2001 13:17:59 +0300
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Nathan Poznick <poznick@conwaycorp.net>, Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: 2.4.16 freezed up with eepro100 module
In-Reply-To: <15366.21354.879039.718967@abasin.nj.nec.com> <20011129095107.A17457@conwaycorp.net> <3C070FEC.3602CB49@pobox.com> <20011130114506.A4789@bee.lk> <15367.44557.930845.66428@abasin.nj.nec.com> <20011130163131.A12298@conwaycorp.net> <20011130161717.G504@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20011130161717.G504@mikef-linux.matchmail.com>; from "Mike Fedyk" on Fri, Nov 30, 2001 at 04:17:17PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 30, 2001 at 04:17:17PM -0800, Mike Fedyk wrote:
> 
> On Fri, Nov 30, 2001 at 04:31:31PM -0600, Nathan Poznick wrote:
> > Thus spake Sven Heinicke:
> > > 
> > > I have eepro100's on other systems and never had a problem.  They
> > > never have been made to work as hard as the DELLs though.  I am
> > > trying the same DELL with a 3C996-T 1000Bt card using the driver from
> > > 3COM (we plan on moving that system to a 1000Bt system but the switch
> > > hasn't arrived yet) and it is running at 100Bt with the same
> > > software.  If you don't hear form me assume it surrived.  Been up a
> > > day so far, took the DELL like 3 days of heavy use to crash before.
> > 
> > Ok, I finally had a chance to work on this, and here's what I know:
> > 
> > 1) I found a workload under which I was able to reliably make the
> > network on the machine die (a few hundred of the "eth0: card reports
> > no resources." errors showed up which continued until I took down the
> > network and removed the module).  Unfortunately, the workload was with
> > an in-house app, so all I can describe are the conditions associated
> > with it: 2 processes with a total of about 600 threads, 1.5gb of
> > memory, about 500 network connections, and a lot of disk and network
> > I/O. 

Do you see "can't fill rx buffer" messages?
If so, then your load is too big, and memory management is incapable of
freeing memory in time.
Right now the kernel doesn't allow to increase atomic allocation
reservation (which is a serious misfeature), so you need to hack and
change the reservation in the kernel.

If the network doesn't come alive when you remove the load, it's a second
problem, a bug in the driver.  I've seen such reports, but they aren't
frequent.  On my computer, the driver resumes operations well.
Why the driver can't do it for some people needs deep investigations.

> > 
> You can run the test against eepro100 with tcpdump redirected to a log file,
> and post that on the web somewhere.  That would probably be helpful.

tcpdumps won't help.

	Andrey
