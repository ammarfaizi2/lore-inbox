Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269210AbTGORlB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269185AbTGORjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:39:37 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:52637 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S269191AbTGORjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:39:19 -0400
Date: Tue, 15 Jul 2003 18:53:58 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch] vesafb fix
Message-ID: <20030715175358.GB15505@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jamie Lokier <jamie@shareable.org>, Gerd Knorr <kraxel@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
References: <20030715141023.GA14133@bytesex.org> <20030715173557.GB1491@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715173557.GB1491@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 06:35:57PM +0100, Jamie Lokier wrote:
 > There used to be a vesafb problem with MTRRs when the framebuffer had
 > an odd size: 2.5MB of RAM (my laptop has this).
 > 
 > It would create an MTRR for the first 0.5MB of the framebuffer, and
 > then try to create another for the subsequent 2MB.
 > 
 > The latter failed because it's not suitably aligned - i.e. there was a
 > problem in th logic which splits non-power-of-two regions.
 > Is that fixed these days?

Better would be to use change_page_attr to manipulate PAT bits.
We then wouldn't have to worry at all about alignment, running out
of MTRRs, or collisions with other MTRRs.

		Dave

