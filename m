Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUHDMqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUHDMqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 08:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUHDMpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 08:45:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40662 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264857AbUHDMn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 08:43:59 -0400
Date: Wed, 4 Aug 2004 14:43:36 +0200
From: Jens Axboe <axboe@suse.de>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
Cc: linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040804124335.GK10340@suse.de>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408041233.i74CX93f009939@wildsau.enemy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04 2004, H.Rosmanith (Kernel Mailing List) wrote:
> 
> hi,
> 
> I've written a patch for cdrecord/cdrtools. I've sent it to Joerg Schilling
> already, but got no answer so far. Probably he's on vaccation.
> 
> I'm sending this to LKML too, because I've read about some ... nebulosity
> with respect to scsi device numbering as used by cdrtools.
> 
> To cut a long story short: the patch avoids cdrecord having to use the
> "virtual" scsi device numbering in the form of "ATAPI:x.y.z" and allows
> you to use the name of the device, e.g. /dev/hdc instead.
> 
> By removing the IDE to virtual scsi bus/host/lun mapping, a lot of confusion
> can be avoided especially if you have a lot devices of this kind in one
> system.
> 
> with kind regards,
> Herbert "herp" Rosmanith
> 
> Version: cdrtools-2.01a34
> 
> Solution: when the device specified in dev= starts with "/dev/hd" and
>           this device can be found in /proc/ide, then cdrecord (and all
>           it's components, such as e.g. cdrdao) is forced to use the
>           ATAPI driver.
> 
> The patch is really very short and works at least on our system.
> 
> with kind regards,
> Herbert Rosmanith
> 
> --- snip ---
> diff -ru cdrtools-2.01.orig/libscg/scsi-linux-ata.c cdrtools-2.01/libscg/scsi-linux-ata.c
> --- cdrtools-2.01.orig/libscg/scsi-linux-ata.c	Sat Jun 12 12:48:12 2004
> +++ cdrtools-2.01/libscg/scsi-linux-ata.c	Wed Aug  4 14:19:31 2004
> @@ -42,6 +42,11 @@
>   * You should have received a copy of the GNU General Public License along with
>   * this program; see the file COPYING.  If not, write to the Free Software
>   * Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + *
> + * Sat Jun 12 12:48:12 CEST 2004 herp - Herbert Rosmanith
> + *     Force ATAPI driver if dev= starts with /dev/hd and device
> + *     is present in /proc/ide/hdX
> + *

That's an extremely bad idea, you want to force ATA driver in either
case.

-- 
Jens Axboe

