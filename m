Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129941AbQKAAFu>; Tue, 31 Oct 2000 19:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129455AbQKAAFl>; Tue, 31 Oct 2000 19:05:41 -0500
Received: from zeus.kernel.org ([209.10.41.242]:55568 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130044AbQKAAFc>;
	Tue, 31 Oct 2000 19:05:32 -0500
Message-ID: <39FF4FD7.5C85CE56@timpanogas.org>
Date: Tue, 31 Oct 2000 16:03:51 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@suse.de>, mingo@elte.hu, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <E13qkPv-0008Nf-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> 
> > One more optimization it has.  NetWare never "calls" functions in the
> > kernel.  There's a template of register assignments in between kernel
> > modules that's very strict (esi contains a WTD head, edi has the target
> > thread, etc.) and all function calls are jumps in a linear space.
> 
> What if I jump to an invalid address - does it crash ?

The jumps are all to defined labels in the code, so there's never one
that's invalid.  The only exception are the jump tables in the MSM and
TSM lan modules, and yes it does crash is a bad driver gets loaded, but
that's the same as Linux.  NetWare avoids using jump tables since they
cause an AGI to get generated, which will interlock the processor
pipelines.  If you load an address on Intel, then immediately attempt to
use it, the processor will generate and Address Generation Interlock
(AGI) that will interlock the piplines so the request can be serviced
immediately.  This cost 2 clocks per address jump used, plus it shuts
down the paralellism in the piplines.

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
