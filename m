Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279378AbRJ2Sya>; Mon, 29 Oct 2001 13:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279377AbRJ2SyJ>; Mon, 29 Oct 2001 13:54:09 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:6660 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279372AbRJ2Sx6>; Mon, 29 Oct 2001 13:53:58 -0500
Message-ID: <3BDDA4C0.F4391EC@zip.com.au>
Date: Mon, 29 Oct 2001 10:49:36 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: harri@synopsys.COM
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c59x:command 0x3002 did not complete! Status=0xffff
In-Reply-To: <3BDD9FF4.D54DC0C9@Synopsys.COM>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> 
> Hi folks,
> 
> Does anybody know what this message in kern.log means?
> 
>         eth0: command 0x3002 did not complete! Status=0xffff
> 

There's a function in the driver which issues reset commands to the
hardware and then spins, waiting for completion.  Usually it takes
a single PCI cycle.  In your case it timed out.

It look to me like the NIC is powered down.  Could you please
send me a bunch of info:

- Does the interface actually work after this message, or is
  it dead?

- If the latter, did you warmboot from another OS?

- Does it help if you add the line

	options 3c59x enable_wol=1

  to /etc/modules.conf?  (This is a misnomer - enable_wol
  enables the driver's power management functions).

Thanks.
