Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbTICIZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTICIZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:25:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58667 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261682AbTICIZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:25:31 -0400
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Matt Tolentino" <metolent@snoqualmie.dp.intel.com>,
       <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
Subject: Re: [UPDATED PATCH] EFI support for ia32 kernels
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE678@fmsmsx406.fm.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Sep 2003 02:25:18 -0600
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE678@fmsmsx406.fm.intel.com>
Message-ID: <m1wucqp9ch.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tolentino, Matthew E" <matthew.e.tolentino@intel.com> writes:

> > As I have heard the story.
> > 
> > The guys at Intel were having problems getting a traditional
> > PC style BIOS to run on the first Itaniums, realized they
> > had a opportunity to come up with a cleaner firmware interface
> > and came up with EFI.  Open Firmware was considered but dropped
> > because it was not compatible with ACPI, and they did not want to
> > dilute the momentum that had built up for ACPI.
> 
> Yes, Itanium has had EFI since the beginning.  

Except EFI came very late in the game.  I have talked to the Intel guys
who thought it up.  And from a practical standpoint the EFI interface
is still stabilizing.

> > And now since Intel has something moderately portable, they intend
> > to back port it to x86 and start using/shipping it sometime early next
> > year.
> 
> Hmmm...  It's not so much of a back port as it is the implementation of the
> interface on x86 boxes.  In fact, the EFI sample implementation can be used on
> boxes with legacy BIOSes and the interface is consistent with what is currently
> shipped on ia64 platforms.  The intention is to have an interface to the
> firmware that is portable and consistent.  For example, much of the linux loader
> is shared between ia64 and x86.  Assuming add-in cards have EFI compliant
> drivers, this also makes option ROM and even system BIOS upgrades easy with EFI
> utilities and without the need for DOS.

Getting EFI drivers in a byte code format would of course be nice.
But mostly this helps the Itanium, not x86.  I can already get
standard x86 option roms.

As for not using DOS, DOS by any other name....  Even if it does uses GUIDs now.

As for the linux loader being able to share code that is great but
have you noticed how huge elilo is?

I have used EFI and I have ported etherboot to it.  It is ok, but from a
practical standpoint very little changes.  You still have to know which
apis are really supported and which one are not etc.  EFI is not tied
as closely to the hardware as the legacy PC BIOS which is a plus.  The fact
you have to have an AML interpreter to get some very trivial information, is
a down side, as is the fact that it is a new interface.  

The fact that EFI's home is on a very expensive and slow platform also
does not help.  From the Intel side I can see how it is certainly the
coming trend and it is the thing to embrace.  I am much more in the
wait and see camp.

Open source firmware where bugs could be fixed would be another
issue, but so far EFI is a buggy piece of binary firmware.  I have
to tolerate it if I am going to do Itanium, and but my customers don't
want it.  They would rather rewrite the firmware.

> > What I find interesting is that I don't see it addressed how the 16bit
> > BIOS calls in setup.S can be bypassed on x86.  And currently while it
> > works to enter at the kernels 32bit entry point if you know what you
> > are doing it is still officially not supported. 
>  
> If one can obtain the required system configuration information from EFI before
> booting the kernel and pass this information to the kernel so as to enable
> kernel initialization, then why else might we even need the 16 bit BIOS calls in
> setup.S that essentially perform the same function?  I'm curious why it wouldn't
> be better to enter the kernel in 32 bit, protected mode?

I totally agree that it is reasonable to bypass setup.S.  But to do that
reliably requires consensus that the 32bit entry point is stable.  That
has not happen yet, and your patch did nothing to address that.  I
know it has to happen because I know the boot process, and what has to
happen to boot with a different x86 BIOS implementation.

Entering via the 32bit entry point has not been previously discussed.
H. Petern Anvin has not been convinced it should be a stable kernel
entry point.  The documentation has not been updated.  A recent RedHat
kernel has even shipped with a different 32bit kernel entry point.

My hunch is that most of the EFI code should actually live in another
subarch.  I think the kernel has support for compiling in multiple
subarches.  If not it is simply because no one has gotten that far yet.

Eric
