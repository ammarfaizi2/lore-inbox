Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313673AbSDPNfX>; Tue, 16 Apr 2002 09:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313675AbSDPNfW>; Tue, 16 Apr 2002 09:35:22 -0400
Received: from elin.scali.no ([62.70.89.10]:43018 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S313673AbSDPNfV>;
	Tue, 16 Apr 2002 09:35:21 -0400
Subject: Re: Why HZ on i386 is 100 ?
From: Terje Eggestad <terje.eggestad@scali.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <l_girdwood@bitwise.co.uk>,
        BALBIR SINGH <balbir.singh@wipro.com>,
        William Olaf Fraczyk <olaf@navi.pl>,
        Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20020416100148.GA17560@venus.local.navi.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 16 Apr 2002 15:35:19 +0200
Message-Id: <1018964120.13527.37.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I seem to recall from theory that the 100HZ is human dependent. Any
higher and you would begin to notice delays from you input until
whatever program you're talking to responds. 

However in order to actually notice it you must have other programs
running that uses close to 100% CPU *AT LEAST AT THE SAME OR HIGHER
PRIORITY*. To test this, just running a couple of shells/script with
while [true;] won't slow you down until you aggressively renice the
shells/script.

THus: Setting it higher *may* improve your latency if you've other CPU
intensive task going. Setting it lower will only be a boon if you have
so many active processes that the kernel spend more than negligible time
scheduling, thus you spend fewer cycles scheduling per sec. I don't know
that *so many* is with a 1 GHz CPU is but it's very likely to be > 10.
The O(1) scheduler in progress will push that even higher.   

TJ

On Tue, 2002-04-16 at 12:01, Olaf Fraczyk wrote:
> On 2002.04.16 12:29 Liam Girdwood wrote:
> > On Tue, 2002-04-16 at 09:18, BALBIR SINGH wrote:
> > > I remember seeing somewhere unix system VII used to have HZ set to
> > 60
> > > for the machines built in the 70's. I wonder if todays pentium iiis
> > and ivs
> > > should still use HZ of 100, though their internal clock is in GHz.
> > >
> > > I think somethings in the kernel may be tuned for the value of HZ,
> > these
> > > things would be arch specific.
> > >
> > > Increasing the HZ on your system should change the scheduling
> > behaviour,
> > > it could lead to more aggresive scheduling and could affect the
> > > behaviour of the VM subsystem if scheduling happens more frequently.
> > I am
> > > just guessing, I do not know.
> > >
> > 
> > I remember reading that a higher HZ value will make your machine more
> > responsive, but will also mean that each running process will have a
> > smaller CPU time slice and that the kernel will spend more CPU time
> > scheduling at the expense of processes.
> > 
> Has anyone measured this?
> This shouldn't be a big problem, because some architectures use value 
> 1024, eg. Alpha, ia-64.
> And todays Intel/AMD 32-bit processors are as fast as Alpha was 1-2 
> years ago.
> 
> Regards,
> 
> Olaf
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

