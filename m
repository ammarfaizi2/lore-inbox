Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbRDSQdx>; Thu, 19 Apr 2001 12:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131323AbRDSQdo>; Thu, 19 Apr 2001 12:33:44 -0400
Received: from pop.gmx.net ([194.221.183.20]:64714 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S131317AbRDSQdh>;
	Thu, 19 Apr 2001 12:33:37 -0400
Message-ID: <3ADF14D7.B1ADC8C2@gmx.at>
Date: Thu, 19 Apr 2001 18:39:51 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Paul Flinders <P.Flinders@ftel.co.uk>, linux-kernel@vger.kernel.org,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Help with Fasttrack/100 Raid on Linux
In-Reply-To: <Pine.LNX.4.10.10104171921300.23608-100000@master.linux-ide.org> <3ADDF370.FAEF5117@gmx.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilfried Weissmann wrote:
> 
> Andre Hedrick wrote:
> >
> > The really easy thing to do is to come up with the personality rules you
> > want to se and let me create the API.  I can make drives talk, listen,
> > dance, spin, flip, etc.....

[snip]

> Talking about the API... These should be the basic steps that we need to
> do (unordered, this is just brainstorming):
> 
> *) device_size_calculation() should use a callback of the raid level to
> get the device size. Or the code should be completly moved over to the
> <raid level>_run()'s.
> 
> *) Hide/unhide disks from the userland (this is just a cosmetic issue).
> 
> *) Shift sectors and shrink capacity of disks so that the existing raid
> levels can access the disks according to the ata-raid layout.
> 
> *) Get the configuration sector from disk. Analyse the configuration and
> setup disks and md-devices.
> 
> *) All raid pers. must be able to handle I/O that requests sectors from
> more than only one disk.
> 
> *) Partitioned raid devices must be handled somehow.

OK, partitions are already handeled!

One additional thing: I am thinking were to put the configuration
detection code. For now I will try to put it at the end of md_init().
But I still have to figure out how I can read the config sector and
start a new md.
An API interface for that would also be great! My solution can only be
an ugly work-around. md_init() just seems not to be the right function
for that.

regards,
Wilfried

PS: I do not want to flood lkml with my stuff. Should we discuss this in
private?

-- 
Wilfried Weissmann ( mailto:Wilfried.Weissmann@gmx.at )
Mobile: +43 676 9444465
