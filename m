Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281116AbRK3Wci>; Fri, 30 Nov 2001 17:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281142AbRK3Wca>; Fri, 30 Nov 2001 17:32:30 -0500
Received: from ns.conwaycorp.net ([24.144.1.3]:58525 "HELO mail.conwaycorp.net")
	by vger.kernel.org with SMTP id <S281077AbRK3Wbi>;
	Fri, 30 Nov 2001 17:31:38 -0500
Date: Fri, 30 Nov 2001 16:31:31 -0600
From: Nathan Poznick <poznick@conwaycorp.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 freezed up with eepro100 module
Message-ID: <20011130163131.A12298@conwaycorp.net>
In-Reply-To: <15366.21354.879039.718967@abasin.nj.nec.com> <20011129095107.A17457@conwaycorp.net> <3C070FEC.3602CB49@pobox.com> <20011130114506.A4789@bee.lk> <15367.44557.930845.66428@abasin.nj.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15367.44557.930845.66428@abasin.nj.nec.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Sven Heinicke:
> 
> I have eepro100's on other systems and never had a problem.  They
> never have been made to work as hard as the DELLs though.  I am
> trying the same DELL with a 3C996-T 1000Bt card using the driver from
> 3COM (we plan on moving that system to a 1000Bt system but the switch
> hasn't arrived yet) and it is running at 100Bt with the same
> software.  If you don't hear form me assume it surrived.  Been up a
> day so far, took the DELL like 3 days of heavy use to crash before.

Ok, I finally had a chance to work on this, and here's what I know:

1) I found a workload under which I was able to reliably make the
network on the machine die (a few hundred of the "eth0: card reports
no resources." errors showed up which continued until I took down the
network and removed the module).  Unfortunately, the workload was with
an in-house app, so all I can describe are the conditions associated
with it: 2 processes with a total of about 600 threads, 1.5gb of
memory, about 500 network connections, and a lot of disk and network
I/O. 

2) I switched from using the eepro100 module to using intel's e100
module, and I was unable to reproduce the problem, even under a
heavier load than before.  Haven't seen so much as a peep about eth0
problems in the logs since I switched over.

So for now, I'll be sticking with the e100 driver, since it appears to
have solved my problem (at least for now).

-- 
Nathan Poznick <poznick@conwaycorp.net>
PGP Key: http://drunkmonkey.org/pgpkey.txt

"This is wild, I swear..."
-Tom Servo (as Hercules). #410
