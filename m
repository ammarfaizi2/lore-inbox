Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbSJVS7O>; Tue, 22 Oct 2002 14:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264813AbSJVS7O>; Tue, 22 Oct 2002 14:59:14 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:38308 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264812AbSJVS7J>;
	Tue, 22 Oct 2002 14:59:09 -0400
Date: Tue, 22 Oct 2002 12:05:03 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: andy barlak <andyb@island.net>
Cc: Mike Anderson <andmike@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: INQUIRY VPD page 0 hangs disk [was scsi_error device offline fix]
Message-ID: <20021022120503.A4185@eng2.beaverton.ibm.com>
Mail-Followup-To: andy barlak <andyb@island.net>,
	Mike Anderson <andmike@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20021022083815.A61@eng2.beaverton.ibm.com> <Pine.LNX.4.30.0210220905560.20878-100000@tosko.alm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0210220905560.20878-100000@tosko.alm.com>; from andyb@island.net on Tue, Oct 22, 2002 at 09:14:55AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 09:14:55AM -0700, andy barlak wrote:
> 
> On Tue, 22 Oct 2002, Patrick Mansfield wrote:
> > Try removing the scsi_load_identifier call in scsi_scan.c and
> > see if you can boot. And/or get sg_utils and on your 2.4 system
> > send a INQUIRY page 0 to the device, and see if that hangs or
> > not, like:
> 
> 
> On this 2.4.19 box with the Buslogic 958, that command hangs:
> # ./sg_inq -e -o=0 /dev/sg1
> EVPD INQUIRY, page code=0x00:
> 

That really sucks.

If you remove the scsi_load_identifier, does 2.5 boot?

We can black list your device, never sending it INQUIRY page 0.

Since there is one disk like yours out there, there are probably more,
so we should add a module/boot and maybe config time option to disable
the INQUIRY page 0.

Anyone have some other suggestion, besides throwing away the disk?

-- Patrick Mansfield
