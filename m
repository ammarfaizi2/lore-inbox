Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132037AbRDGVwu>; Sat, 7 Apr 2001 17:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131988AbRDGVwk>; Sat, 7 Apr 2001 17:52:40 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:2486 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S131985AbRDGVwc>;
	Sat, 7 Apr 2001 17:52:32 -0400
Message-ID: <3ACF8C1C.7CFF675A@mandrakesoft.com>
Date: Sat, 07 Apr 2001 17:52:28 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Cc: no To-header on input <"unlisted-recipients:;"@havoc.gtf.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <20010407111419.B530@redhat.com> <3ACF5F9B.AA42F1BD@t-online.de> <20010407200340.C3280@redhat.com> <3ACF6920.465635A1@mandrakesoft.com> <3ACF790B.72171236@t-online.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gunther Mayer wrote:
> 
> Jeff Garzik wrote:
> >
>  Like I mentioned in a
> > previous message, the Via parport code is ugly and should go into a Via
> > superio driver.  It is simply not scalable to consider the alternative
> > -- add superio code to parport_pc.c for each ISA bridge out there.  I
> > think the same principle applies to this discussion as well.
> 
> Yes, superio will go away and replaced by user level utility:
> http://home.t-online.de/home/gunther.mayer/lssuperio-0.61.tar.bz2

The entire point of superio is -not- configuration.  That's what your
BIOS setup does, and/or user-level utilities.

The point of superio support is that you can obtain 100% accurate probe
information for legacy ISA devices, by looking at the information
exported by the ISA bridge.  There is no need for "probing" per se,
because you know whether or not the parallel port is enabled, exactly
what IRQ it's on, and exactly what DMA channel it uses.

So, a superio probe occurs first because it provides the maximum
information at the least cost.  Since ISA devices must still be
supported, the ISA probe should come after the PCI probe (which includes
PCI superio stuff).  ISA probes to ports already registered via the
superio probe fail at the request_region level, avoiding any unnecessary
hardware access at those ports.  There are tertiary benefits to such a
scheme as well, I'll be glad to elaborate on if people are interested in
the nitty gritty (read: boring) details.

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
