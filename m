Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTJOPcY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 11:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTJOPcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 11:32:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4105 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263426AbTJOPcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 11:32:23 -0400
Date: Wed, 15 Oct 2003 16:32:12 +0100
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-ID: <20031015153212.GA5197@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20031014105514.GH765@holomorphy.com> <20031014045614.22ea9c4b.akpm@osdl.org> <20031015121208.GA692@elf.ucw.cz> <20031015125109.GQ16158@holomorphy.com> <20031015132054.GA840@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015132054.GA840@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 03:20:54PM +0200, Pavel Machek wrote:

 > Do you want to say that calculation is different, already? We should
 > probably make 2.5 version match 2.4 version, that's what users
 > expect. Who changed it and why?

More a case of who didn't change it (in 2.6 at least).
This routine was identical until rev 1.42 of 2.4 when hch changed it to how
it stands today, with the comment...

[PATCH] memsetup fixes (again)

The mem= fixes from Red Hat's tree had a small bug:
if mem= was not actually used with the additional features, but
int plain old way, is used the value as the size of memory it
wants, not the upper limit.  The problem with this is that there
is a small difference due to memory holes.
				    
I had one report of a person using mem= to reduce memory size for
a broken i386 chipset thaty only supports 64MB cached and the rest
as mtd/slram device for swap.  I got broken as the boundaries changed.


Assuming this patch is correct, it needs forward porting to 2.6

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
