Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310750AbSCRM7B>; Mon, 18 Mar 2002 07:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310737AbSCRM6w>; Mon, 18 Mar 2002 07:58:52 -0500
Received: from glade.nmd.msu.ru ([193.232.112.67]:39948 "HELO glade.nmd.msu.ru")
	by vger.kernel.org with SMTP id <S310695AbSCRM6l>;
	Mon, 18 Mar 2002 07:58:41 -0500
Date: Mon, 18 Mar 2002 15:58:32 +0300
From: Andrey Slepuhin <pooh@msu.ru>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx driver v6.2.4 "queue abort message" questions
Message-ID: <20020318155832.A8849@glade.nmd.msu.ru>
In-Reply-To: <20020315140239.A22884@opengraphics.com> <200203151931.g2FJVMI79884@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 12:31:22PM -0700, Justin T. Gibbs wrote:
> >I just tried applying the aic7xxx 6.2.5 driver patch to replace 6.2.4
> >that is in 2.4.18, and it actually appears to have removed the problem.
> 
> This was a known issue that was corrected in 6.2.5.  The driver was
> referencing an uninitialized register on the card, which cause the
> parity error.  The uninitialized reference was harmless as the value
> was ignored in the cases that it was uninitialized, but the panic it
> created was a bit rough on users. 8-)

This weekend I ran into exactly the same problem with parity errors,
but after updating to 6.2.5 driver version, kernel completely stalls just
after the line
  SCSI subsystem driver Revision: 1.00

The system in problem is:

Dual PIII-1266,
SuperMicro P3TDER motherboard,
onboard aic7899 SCSI controller:
  Bus  0, device   5, function  1:
    SCSI storage controller: Adaptec 7899P (#2) (rev 1).
      IRQ 27.
      Master Capable.  Latency=64.  Min Gnt=40.Max Lat=25.
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 64 bit memory at 0xfeaff000 [0xfeafffff].
  Bus  0, device   5, function  0:
    SCSI storage controller: Adaptec 7899P (rev 1).
      IRQ 26.
      Master Capable.  Latency=64.  Min Gnt=40.Max Lat=25.
      I/O at 0xd000 [0xd0ff].
      Non-prefetchable 64 bit memory at 0xfeafc000 [0xfeafcfff].


I tried both updating driver for kernel 2.4.18-ac3 and switching to
kernel 2.4.19-pre3-ac1 - the same effect. Though on another computer with
Asus P2B-DS motherboard (onboard aic7890) kernel 2.4.19-pre3-ac1 works fine.

Regards,
Andrey.

-- 
A right thing should be simple (tm)
