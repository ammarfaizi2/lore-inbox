Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129776AbRAUFJe>; Sun, 21 Jan 2001 00:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbRAUFJY>; Sun, 21 Jan 2001 00:09:24 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:28681 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132316AbRAUFJL>;
	Sun, 21 Jan 2001 00:09:11 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Luyer <david_luyer@pacific.net.au>
cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: "Pass module parameters" to built-in drivers 
In-Reply-To: Your message of "Sun, 21 Jan 2001 15:54:56 +1100."
             <200101210454.f0L4sug02747@typhaon.pacific.net.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 21 Jan 2001 16:09:04 +1100
Message-ID: <27169.980053744@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2001 15:54:56 +1100, 
David Luyer <david_luyer@pacific.net.au> wrote:
>Here's a proposed v2.4 "quick fix" to allow specifying "module parameters" to
>any of the many drivers without option parsers when built in to the kernel.

Fundamental problem: you assume that each module is built from a source
of the same name, this is not true.  For example, scsi_mod is built
from several objects, including scsi.c and scsi_scan.c which contain
MODULE_PARM.  With your patch the user has to do

    scsi.c:scsihosts="..." scsi_scan.c:max_scsi_luns=n (built in)
or
    options scsi_mod scsihosts="..." max_scsi_luns=n (module)

Inconsistent methods for setting the same parameter are bad.  I can and
will do this cleanly in 2.5.  Parameters will be always be keyed by the
module name, even if they are compiled in.  Adding an inconsistent
method to 2.4 then changing to a correct method in 2.5 is a bad idea,
wait until we can do it right.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
