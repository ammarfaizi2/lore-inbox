Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271398AbTGXBBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 21:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271399AbTGXBBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 21:01:47 -0400
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:48281 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S271398AbTGXBBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 21:01:46 -0400
Date: Wed, 23 Jul 2003 20:16:51 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: some modules refuse to autoload
Message-ID: <20030724011651.GA2435@glitch.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030717215139.GA19877@glitch.localdomain> <bfmsu5$l2k$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfmsu5$l2k$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 08:58:45PM +0000, bill davidsen wrote:
> Is hdd set to anything special? And is hdc set to cdrom? If not, try
> an explicit "hdc=cdrom" on the boot line. I have had to do this on
> several systems, in spite of dmesg telling me the kernel knows that
> it's a CD.

Thanx for the suggestion, but it unfortunately doesn't appear to have
made any difference. :-( The full kernel command-line was
"acpismp=force hdc=cdrom hdd=cdrom" (hdc is a DVD-ROM, and hdd is a
CD-RW).

   # mount /cdrom
   mount: /dev/hdc is not a valid block device
   # grep ide /proc/modules
   # mount -t iso9660 /dev/hdc /cdrom
   mount: /dev/hdc is not a valid block device
   # modprobe ide-cd
   end_request: I/O error, dev hdc, sector 0
   hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
   Uniform CD-ROM driver Revision: 3.12
   end_request: I/O error, dev hdd, sector 0
   hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
   # mount -t iso9660 /dev/hdc /cdrom
   mount: block device /dev/hdc is write-protected, mounting read-only
   ISO 9660 Extensions: Microsoft Joliet Level 3
   ISO 9660 Extensions: RRIP_1991A

I can't find any messages under /var/log or dmesg to indicate that a
module load was attempted for block-major-22 (or anything else, for
that matter).

I appreciate the suggestion, tho!
