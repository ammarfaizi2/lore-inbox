Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbQKNUaR>; Tue, 14 Nov 2000 15:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130540AbQKNUaI>; Tue, 14 Nov 2000 15:30:08 -0500
Received: from hera.cwi.nl ([192.16.191.1]:57263 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129908AbQKNU3x>;
	Tue, 14 Nov 2000 15:29:53 -0500
Date: Tue, 14 Nov 2000 20:59:50 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_EISA note in Documentation/Configure.help
Message-ID: <20001114205950.A25349@veritas.com>
In-Reply-To: <00111317072200.00727@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <00111317072200.00727@localhost.localdomain>; from elenstev@mesatop.com on Mon, Nov 13, 2000 at 05:07:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2000 at 05:07:22PM -0700, Steven Cole wrote:

> +EISA support
> +CONFIG_EISA
> +  The Extended Industry Standard Architecture (EISA) bus was
> +  developed as an open alternative to the IBM MicroChannel bus.
> +
> +  The EISA bus provided some of the features of the IBM MicroChannel
> +  bus while maintaining backward compatibility with cards made for
> +  the older ISA bus. The EISA bus saw limited use between 1988 and 1995
> +  when it was made obsolete by the PCI bus.
> +
> +  Say Y here if you are building a kernel for an EISA-based machine.
> +
> +  Otherwise, say N.

Hmm.

(i) I am a bit unhappy about adding configuration options
like this. It regularly happens that I want to compile some kernel
for some machine and have to grep the source and look at the config
files how to enable something. A machine with RTL-8139? Let me see,
that requires CONFIG_EXPERIMENTAL. (Not today, but until recently.)
How do I get FireWire? Also requires CONFIG_EXPERIMENTAL. This
CONFIG_EXPERIMENTAL is a very strange option. I know about my hardware,
perhaps, but there is no reason to suppose that I know about the
progress in development of Linux drivers for this hardware.
Instead of having a global CONFIG_EXPERIMENTAL we should have
a warning at each place that the driver is alpha.

If one does "make xconfig" then one sees a greyed out area,
and the sometimes nontrivial puzzle is how to enable it.
But with "make menuconfig" one never even sees the option,
making configuration even more troublesome: where would FireWire be?
Not in the global menu. In what subcategory should I search for it?
Again a grep on the kernel source is easier.

(ii) In particular about this CONFIG_EISA and the given explanation.
I have a computer, yes, several. But do I know whether it has
an EISA bus? A week ago I hardly knew what EISA was, and would have
been unable to answer. Today I know the answer for a handful of them
but have not yet investigated the others.
Now, if this knowledge was of major importance for the kernel
then perhaps I had to learn about such details.
However, CONFIG_EISA is almost completely superfluous, is not
required at compile time, can easily be tested at run time,
in other words adding such an option is a very stupid thing to do.

[Steven, you understand that I would have written under CONFIG_EISA:
say Y here - there is never any reason to say N, unless there exists
hardware where the canonical probing hangs the machine.]

The number of configuration options should be minimized.
That is good for the user - fewer questions to answer.
That is good for the kernel programmer - fewer boolean combinations
of options to worry about.

(iii) Now about EISA itself. Recently I worked on the lp486e.c
driver for the on board ethernet of some machine with Intel Panther
motherboard. The driver is fine, but how do I find the ethernet address?
Somewhere in the EISA configuration area. Is it possible to parse
this area? Maybe not really - it looks like there are only two places
with knowledge about the location and structure of this area: the BIOS
and the ECU program, and the details are different for each machine.

What use is knowing that a machine has EISA slots? As far as I can see
the only use is to ask for the EISA ID of the card.
Should we? I collected 600 .cfg files and estimate that this is
less than 5% of what exists - we do not want a data base built
into the kernel, I think. But the kernel could collect these
EISA IDs at boot time, enabling drivers to inquire.
Right now there are a few drivers that look at this info privately.

(iv) Finally a question: does anyone know of a URL for the
EISA standard?

Andries


[PS I would like to be mistaken about the impossibility of
parsing the EISA configuration area. There is useful info
there, e.g. about dma and irq. It would be nice if this info
were available.]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
