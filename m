Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266302AbUFPNEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266302AbUFPNEL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 09:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUFPNBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 09:01:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12260 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266287AbUFPM6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:58:03 -0400
Date: Wed, 16 Jun 2004 13:57:54 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: foo@porto.bmb.uga.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: processes hung in D (raid5/dm/ext3)
Message-ID: <20040616125754.GF6627@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>, foo@porto.bmb.uga.edu,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040615062236.GA12818@porto.bmb.uga.edu> <20040615030932.3ff1be80.akpm@osdl.org> <20040615150036.GB12818@porto.bmb.uga.edu> <20040615162607.5805a97e.akpm@osdl.org> <20040616021633.GB13672@porto.bmb.uga.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616021633.GB13672@porto.bmb.uga.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 10:16:33PM -0400, foo@porto.bmb.uga.edu wrote:
> # pvdisplay /dev/md0
> # vgdisplay vg0
> # lvdisplay 

LVM2/device-mapper diagnostics
==============================

If you use the 'lvs' reporting tool, we'll get fuller information more 
concisely, so we can check for any anomalies. 
[Unlikely to be any based on what you've posted so far, but worth
eliminating the possibility.]

Run:
  vgs -v
  lvs -v
  pvs -v

Can you confirm that you're not running *any* LVM or device-mapper
commands during your backup sequence?

Confirm the versions by running:
  lvm version
  dmsetup targets

And dump the static device-mapper state, by running:
  dmsetup -v table
  dmsetup status

[I'll get that fixed to provide a column-based output too.]

And finally mount sysfs and run
  ls -ld .../block/dm-*

[This lot ought to get scripted.]

Alasdair
-- 
agk@redhat.com
