Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288071AbSCRQZB>; Mon, 18 Mar 2002 11:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288748AbSCRQYt>; Mon, 18 Mar 2002 11:24:49 -0500
Received: from glade.nmd.msu.ru ([193.232.112.67]:34829 "HELO glade.nmd.msu.ru")
	by vger.kernel.org with SMTP id <S288071AbSCRQYl>;
	Mon, 18 Mar 2002 11:24:41 -0500
Date: Mon, 18 Mar 2002 19:24:30 +0300
From: Andrey Slepuhin <pooh@msu.ru>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: aic7xxx driver v6.2.5 freezes the kernel
Message-ID: <20020318192430.B8849@glade.nmd.msu.ru>
In-Reply-To: <20020315140239.A22884@opengraphics.com> <200203151931.g2FJVMI79884@aslan.scsiguy.com> <20020318155832.A8849@glade.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 03:58:32PM +0300, Andrey Slepuhin wrote:
> On Fri, Mar 15, 2002 at 12:31:22PM -0700, Justin T. Gibbs wrote:
> > >I just tried applying the aic7xxx 6.2.5 driver patch to replace 6.2.4
> > >that is in 2.4.18, and it actually appears to have removed the problem.
> > 
> > This was a known issue that was corrected in 6.2.5.  The driver was
> > referencing an uninitialized register on the card, which cause the
> > parity error.  The uninitialized reference was harmless as the value
> > was ignored in the cases that it was uninitialized, but the panic it
> > created was a bit rough on users. 8-)
> 
> This weekend I ran into exactly the same problem with parity errors,
> but after updating to 6.2.5 driver version, kernel completely stalls just
> after the line
>   SCSI subsystem driver Revision: 1.00

[snip]

I tracked the problem down to ahc_read_seeprom(), which hangs in
CLOCK_PULSE() at aic7xxx_93cx6.c:161. But I have no idea what happens,
because this code is the same as in 6.2.4 version of the driver.

Regards,
Andrey.

-- 
A right thing should be simple (tm)
