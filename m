Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRDGTXh>; Sat, 7 Apr 2001 15:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130487AbRDGTX1>; Sat, 7 Apr 2001 15:23:27 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:47025 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130485AbRDGTXO>;
	Sat, 7 Apr 2001 15:23:14 -0400
Message-ID: <3ACF6920.465635A1@mandrakesoft.com>
Date: Sat, 07 Apr 2001 15:23:12 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
Cc: Gunther Mayer <Gunther.Mayer@t-online.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mj@suse.cz,
        reinelt@eunet.at
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <20010407111419.B530@redhat.com> <3ACF5F9B.AA42F1BD@t-online.de> <20010407200340.C3280@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> It would allow support for new multi-IO cards to generally be the
> addition of about two lines to two files (which is currently how it's
> done), rather than having separate mutant hybrid monstrosity drivers
> for each card (IMHO)..

;-)

My point of view is that hacking the kernel so that two device drivers
can pretend they are not driving the same hardware is silly.  With such
hardware there are always inter-dependencies, and you can either hack
special case code into two or more drivers, or create one central
control point from which knowledge is dispatched.  Like I mentioned in a
previous message, the Via parport code is ugly and should go into a Via
superio driver.  It is simply not scalable to consider the alternative
-- add superio code to parport_pc.c for each ISA bridge out there.  I
think the same principle applies to this discussion as well.  It's just
ugly to keep hacking in special cases to handle hardware that is
multifunction like this.

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
