Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbWASA01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbWASA01 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161096AbWASA01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:26:27 -0500
Received: from mail.suse.de ([195.135.220.2]:53393 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161094AbWASA00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:26:26 -0500
From: Neil Brown <neilb@suse.de>
To: "John Stoffel" <john@stoffel.org>
Date: Thu, 19 Jan 2006 11:26:18 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17358.56490.127364.327688@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 001 of 5] md: Split disks array out of raid5 conf structure so it is easier to grow.
In-Reply-To: message from John Stoffel on Tuesday January 17
References: <20060117174531.27739.patches@notabene>
	<1060117065614.27831@suse.de>
	<17357.271.619918.45917@smtp.charter.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 17, john@stoffel.org wrote:
> >>>>> "NeilBrown" == NeilBrown  <neilb@suse.de> writes:
> 
> NeilBrown> Previously the array of disk information was included in
> NeilBrown> the raid5 'conf' structure which was allocated to an
> NeilBrown> appropriate size.  This makes it awkward to change the size
> NeilBrown> of that array.  So we split it off into a separate
> NeilBrown> kmalloced array which will require a little extra indexing,
> NeilBrown> but is much easier to grow.
> 
> Neil,
> 
> Instead of setting mddev->private = NULL, should you be doing a kfree
> on it as well when you are in an abort state?

The only times I set 
  mddev->private = NULL
it is immediately after
   kfree(conf)
and as conf is the thing that is assigned to mddev->private, this
should be doing exactly what you suggest.

Does that make sense?

NeilBrown
