Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbVLOUwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVLOUwh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbVLOUwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:52:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38337 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751066AbVLOUwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:52:36 -0500
Date: Thu, 15 Dec 2005 15:52:21 -0500
From: Dave Jones <davej@redhat.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: agpgart.ko can't be unloaded
Message-ID: <20051215205221.GG19354@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
References: <m3acf2i05d.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3acf2i05d.fsf@defiant.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 09:19:10PM +0100, Krzysztof Halasa wrote:
 > Hi,
 > 
 > I recently noticed that agpgart.ko (and corresponding hardware driver)
 > can't be unloaded:
 > 
 > Module                  Size  Used by
 > intel_agp              19228  1 
 > agpgart                27592  1 intel_agp
 > 
 > The same is true for via_agp and probably for all other drivers.
 > 
 > The problem is agpgart increases reference count of hw driver
 > to prevent it from being unloaded, and the hw driver references
 > agpgart so agpgart can't be unloaded either.
 > 
 > Should agpgart be split into 2 parts, one (which would have to be unloaded
 > first) managing the thing and the other - the library referenced by
 > hw drivers?

the reference on the chipset driver should only be bumped when
/dev/agpgart is open()'d, but currently that isn't the case.

 > I wouldn't write about this but there is code to unload them so I think
 > it's not intentional.

The reference counting has been horked since the 'new' module loader
appeared[*], and never got fixed as I've nearly always found something
more important to work on, and it's not really a problem for 99%
of users.  If someone found the time to write a patch to make it do the 
right thing though, I'd be happy to merge it as long as it's done
correctly.

		Dave

[*] In fact, my first attempt at fixing it way back then may have
even made the problem worse.
