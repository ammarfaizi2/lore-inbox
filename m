Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTK2Me5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 07:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbTK2Me5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 07:34:57 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:46341 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263584AbTK2Me4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 07:34:56 -0500
Date: Sat, 29 Nov 2003 13:34:51 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andrew Clausen <clausen@gnu.org>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031129123451.GA5372@win.tue.nl>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 07:16:31AM +0200, Szakacsits Szabolcs wrote:

> 	http://mlf.linux.rulez.org/mlf/ezaz/ntfsresize.html#troubleshoot
> 
> Some users, having problems, did mention the usage of 2.6 kernel. If the
> geometry changed during the fdisk, etc process then it could result also
> booting problem?

Let me continue to stress: geometry does not exist.
Consequently, it cannot change.
fdisk does not set any geometry, it writes a partition table.

Start and size of each partition are given twice: in absolute sector
units (LBA) and in CHS units. The former uses 32 bits, and with 512-byte
sectors this works up to 2TB. People are starting to hit that boundary now.
The latter uses 24 bits, which works up to 8GB. Modern systems no longer
use it (but the details are complicated).

Usually booting goes like this: the BIOS reads sector 0 (the MBR)
from the first disk, and starts the code found there. What happens
afterwards is up to that code. If that code uses CHS units to find
a partition, and if the program that wrote the table has different
ideas about those units than the BIOS, booting may fail.

Andries

