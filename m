Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbTLaRkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 12:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265216AbTLaRko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 12:40:44 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:28387 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S265215AbTLaRkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 12:40:43 -0500
Date: Wed, 31 Dec 2003 10:42:06 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 - Watchdog patches (BK consistency checks)
Message-ID: <20031231174206.GA14338@bounceswoosh.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030906125136.A9266@infomag.infomag.iguana.be> <200312300836.16559.edt@aei.ca> <20031230131350.A32120@hexapodia.org> <200312311001.48154.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <200312311001.48154.edt@aei.ca>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31 at 10:01, Ed Tomlinson wrote:
>I am not saying I do not want do have consistency checks done.  I do want
>to control _when_ and how often they run

I don't see how it would be valid to not do a consistency check after
every network operation, which is what it does now...

Every time you are modifying your archive from a remote source, the
consistency check makes sure you don't have corruption in the transfer
that was previously undetected, or corruption in the underlying
archive which is about to accept the changes.  Since you can only do
network updates at a time when your own archive is in a "checked-in"
state, if the network update fails or detects corruption, you can
clone what you'd already checked in to a new location and recover
trivially.  The most work you can lose is the delta between your last
changeset and the current one, assuming you keep some sort of backups
around.

What exactly would you do if you'd been working "offline" for 3 weeks,
went to sync, and it said that your archive was corrupted?  Or should
it try to merge into a corrupt archive anyway?  Should that archive
that was corrupt, and then had possibly good changes layered on top of
it, be valid for attempting a clone?

I think that limiting the consistency checking could be like opening a
*very big* can of worms.




-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

