Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132890AbQLIApz>; Fri, 8 Dec 2000 19:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135228AbQLIApq>; Fri, 8 Dec 2000 19:45:46 -0500
Received: from Cantor.suse.de ([194.112.123.193]:46603 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132890AbQLIAp1>;
	Fri, 8 Dec 2000 19:45:27 -0500
Date: Sat, 9 Dec 2000 01:14:57 +0100
From: Andi Kleen <ak@suse.de>
To: Matthew Jacob <mjacob@feral.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, baettig@scs.ch,
        linux-kernel@vger.kernel.org
Subject: Re: io_request_lock question (2.2)
Message-ID: <20001209011457.A30226@gruyere.muc.suse.de>
In-Reply-To: <E144XLU-0004eG-00@the-village.bc.nu> <Pine.BSF.4.21.0012081603110.72881-100000@beppo.feral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.BSF.4.21.0012081603110.72881-100000@beppo.feral.com>; from mjacob@feral.com on Fri, Dec 08, 2000 at 04:03:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 04:03:58PM -0800, Matthew Jacob wrote:
> 
> 
> On Fri, 8 Dec 2000, Alan Cox wrote:
> 
> > > Yes, and I believe that this is what's broken about the SCSI midlayer. The the
> > > io_request_lock cannot be completely released in a SCSI HBA because the flags
> > 
> > You can drop it with spin_unlock_irq and that is fine. I do that with no
> > problems in the I2O scsi driver for example
> 
> I am (like, I think I *finally* got locking sorta right in my QLogic driver),
> but doesn't this still leave ints blocked for this CPU at least?

spin_unlock_irq() does a __sti()
spin_unlock() doesn't. 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
