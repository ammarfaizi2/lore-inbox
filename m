Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263412AbTK3JgV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 04:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTK3JgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 04:36:20 -0500
Received: from main.gmane.org ([80.91.224.249]:45770 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263412AbTK3JgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 04:36:17 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Date: Sun, 30 Nov 2003 12:35:41 +0300
Message-ID: <pan.2003.11.30.09.35.40.502335@altlinux.ru>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl> <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk> <20031129170103.GA6092@iliana> <20031129221424.GA5456@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Cc: bug-parted@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Nov 2003 23:14:24 +0100, Andries Brouwer wrote:

> On Sat, Nov 29, 2003 at 06:01:03PM +0100, Sven Luther wrote:
> 
>> The only problem is that your BIOS will probably not be able
>> to boot from it
> 
> You seem to misunderstand the boot sequence.
> The BIOS does not generally do any parsing of partition tables.

In theory, the BIOS does not need to look in the partition tables. 
However, in practice it does this :(

Many BIOSes look at least at the partition table in the MBR to autodetect
the CHS parameters which were used when partitioning the disk.  E.g. if
you partition a disk with LBA turned off in the BIOS (so the CHS
parameters will have 16 heads), then notice the mistake and turn LBA on,
in many cases BIOS will still show 16 heads in the CHS parameters. 
However, after cleaning the MBR the same BIOS with the same settings will
report 255 heads.

Who knows what such BIOS will do if it will find something other than a
DOS partition table in the first sector...

