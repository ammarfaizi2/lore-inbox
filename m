Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSJVPcM>; Tue, 22 Oct 2002 11:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbSJVPcM>; Tue, 22 Oct 2002 11:32:12 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52614 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262824AbSJVPcL>; Tue, 22 Oct 2002 11:32:11 -0400
Date: Tue, 22 Oct 2002 08:38:15 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: andy barlak <andyb@island.net>
Cc: Mike Anderson <andmike@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi_error device offline fix
Message-ID: <20021022083815.A61@eng2.beaverton.ibm.com>
Mail-Followup-To: andy barlak <andyb@island.net>,
	Mike Anderson <andmike@us.ibm.com>, linux-kernel@vger.kernel.org
References: <20021021155236.A10032@eng2.beaverton.ibm.com> <Pine.LNX.4.30.0210211739330.2010-100000@tosko.alm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0210211739330.2010-100000@tosko.alm.com>; from andyb@island.net on Mon, Oct 21, 2002 at 05:58:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 05:58:04PM -0700, andy barlak wrote:
> On Mon, 21 Oct 2002, Patrick Mansfield wrote:
> > Can you turn on all scsi logging - with CONFIG_SCSI_LOGGING enabled,
> > on your boot command line add a "scsi_logging=1" and send
> > the output.
> >
> > -- Patrick Mansfield
> 
> Sure.  large dmesg buffer required.  This produced a 55k file that
> I will pare down to what I consider informative.

It looks like the INQUIRY page code 0 is timing out and appears to have
hung the bus, as all other commands sent to the bus then timeout.

It's surprising that that would hang the bus.

That driver really needs at least some basic reset handling.

Try removing the scsi_load_identifier call in scsi_scan.c and
see if you can boot. And/or get sg_utils and on your 2.4 system
send a INQUIRY page 0 to the device, and see if that hangs or
not, like:

[patman@elm3a50 sg_utils]$ sudo ./sg_inq  -e -o=0 /dev/sg1
EVPD INQUIRY, page code=0x00:
 Only hex output supported
 00     00 00 00 0c 00 03 80 81  c0 c1 c2 c3 c7 c8 d1 d2    ................    

FYI sg_utils is at:

http://www.torque.net/sg/index.html#Utilities:%20sg_utils%20and%20sg3_utils
http://www.torque.net/sg/p/sg3_utils-1.01.tgz

-- Patrick Mansfield
