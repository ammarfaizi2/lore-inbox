Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266878AbRGFWaH>; Fri, 6 Jul 2001 18:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266879AbRGFW36>; Fri, 6 Jul 2001 18:29:58 -0400
Received: from p021.as-l031.contactel.cz ([212.65.234.213]:24580 "EHLO
	p021.as-l031.contactel.cz") by vger.kernel.org with ESMTP
	id <S266878AbRGFW3u>; Fri, 6 Jul 2001 18:29:50 -0400
Date: Fri, 6 Jul 2001 23:43:38 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: What are rules for acpi_ex_enter_interpreter?
Message-ID: <20010706234338.D1831@ppc.vc.cvut.cz>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDF38@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDF38@orsmsx35.jf.intel.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 04:05:43PM -0700, Grover, Andrew wrote:
> Thanks for the report on the locking issue. A fix is checked in locally.
> 
> > From: Petr Vandrovec [mailto:vandrove@vc.cvut.cz]
> > Replying to myself, after following change in additon to acpi_ex_...
> > poweroff on my machine works. It should probably map type 0 
> > => 0, 3 => 1
> > and 7 => 2, but it is hard to decide without VIA datasheet, so change
> > below is minimal change needed to get poweroff through ACPI 
> > to work on my 
> > ASUS A7V.
> 
> How did you discover slp typ values of 2 worked, where 7 did not? Did you
> just try all possibilities (0-7)?

Yes, in Borland TurboDebugger under MSDOS. 

0 and 7 do nothing, 
1 power offs, but power led blinks and I was not able to get machine back 
  to life without unplugging power cord (it did not react to reset or 
  power button). Maybe when it is correctly suspended, or when there is
  running ACPI interpreter, it can return back to life, but not under MSDOS.
2 power offs and LED is off
3 did nothing and 
4-6 locked machine up just after outw(). Maybe it does something, but
  when tried from TD it just stopped react to anything (incl. poweroff)
  except reset button.

If bit 0x2000 is not set, it does nothing, and if you write random values
to SLP port, it somehow switches to another mode where it reads back
as 0x0000 and does not react to any outw values :-( Reset fixes this state...

I hope that I remember states 3-6 correctly, but at least two of them
are lockup, and at least one of them was nothing. But I'm 100% sure on
0,1,2 and 7.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

