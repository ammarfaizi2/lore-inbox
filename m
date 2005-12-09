Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVLIWrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVLIWrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVLIWrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:47:42 -0500
Received: from amdext3.amd.com ([139.95.251.6]:954 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S932489AbVLIWrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:47:41 -0500
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Date: Fri, 9 Dec 2005 15:47:55 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Ben Gardner" <gardner.ben@gmail.com>
cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: i386: CS5535 chip support - cpu
Message-ID: <20051209224755.GV19006@cosmic.amd.com>
References: <20051207194226.GA2617@cosmic.amd.com>
 <808c8e9d0512090701l1f065c23radaa8ff5d800da2a@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <808c8e9d0512090701l1f065c23radaa8ff5d800da2a@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F84D6F031W1298075-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/05 09:01 -0600, Ben Gardner wrote:
> 
> I think your phrase "somewhat sane BIOS" sums up the problem nicely.
> I threw in the UART1 config because UART2 has problems. Paranoia.
> I'm not sure that the UART1 config is needed, so I'm willing to scrap
> it, or wrap it in a config option.
> 
> If you are interested in my experience with UART2, see the kernel
> buzilla report #5677.

> My guess (not based on any data) is that a BIOS call (initiated by
> Linux) uses the DDC, but doesn't restore the GPIO to its original
> state. So, again, a BIOS problem.

Reading BZ 5677, I get some perspective on your issue now.  I would agree
that the data sounds like something is subverting the GPIO pins for its
own use, and definately DDC is the logical conclusion.

Ok, so now with a bit of perspective on the issue, then I think that 
adding code to win back the serial port is useful, but it should be wrapped
in a config or command line option, so that users can decide for themselves.
After all, DDC is useful too (if you're an X user).  

> > Now, if your particular board has its own very good reasons for handling
> > this, then thats fine, but I don't think this should be accepted as CS5535
> > support, because it stands a fairly good chance of causing trouble over
> > the larger set of Geode devices.   I'll certainly listen to arguments
> > to the contrary, though.
> 
> I'm curious as to what trouble this could cause?

I'm mainly worried about resource conflicts and such, especially with the
first serial port.  I'm less worried about the second port (as you could
see from my code), but on the particular platform where that
code was most useful, we had a fixed set of features so we knew we be more
carefree.  Certainly, on the big development platforms with a full BIOS,
the code would be far more worriesome.

> Your patch looks like it would also solve the UART2 problem.
> What I still don't understand is why UART2 works fine in DOS and in
> linux 2.6.13-rc6-mm1, but not in the current kernel - in short, why is
> this needed?

Our internal BIOS defaults to DDC on the second CS5535/CS5536 serial
port, which normally isn't any big deal, because the first port is 
available, and if worse comes to worse, I can always switch over to LPC.

But on platforms like the Thin Client RDK, which is more like a production
platform, there aren't any physical serial ports populated.  So in order to
get access, our systems guys made a little dongle that plugged into
the VGA port and split out the DDC lines and turned them into a serial
connection.  And this code was born to turn off the default DDC and
enable the serial port.

> Anyway, I recommend adding sanity checks on MSR_DIVIL_GLD_CAP and
> MSR_LBAR_GPIO before writing to the IO port.  The code as-is may cause
> problems on a non-cs5535 board.

Thats a great point.  Actually, we should check for both CS5535 and 
CS5536, since the code will work on both.. :)

> Thanks for your input.

Thanks for your interest.
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

