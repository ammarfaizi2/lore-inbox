Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbUCXRt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 12:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUCXRt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 12:49:26 -0500
Received: from ns.suse.de ([195.135.220.2]:39838 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263792AbUCXRtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 12:49:25 -0500
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
References: <20040324002149.GT4677@tpkurt.garloff.de.suse.lists.linux.kernel>
	<16480.55450.730214.175997@napali.hpl.hp.com.suse.lists.linux.kernel>
	<4060E24C.9000507@redhat.com.suse.lists.linux.kernel>
	<16480.59229.808025.231875@napali.hpl.hp.com.suse.lists.linux.kernel>
	<20040324070020.GI31589@devserv.devel.redhat.com.suse.lists.linux.kernel>
	<16481.13780.673796.20976@napali.hpl.hp.com.suse.lists.linux.kernel>
	<20040324072840.GK31589@devserv.devel.redhat.com.suse.lists.linux.kernel>
	<16481.15493.591464.867776@napali.hpl.hp.com.suse.lists.linux.kernel>
	<4061B764.5070008@BitWagon.com.suse.lists.linux.kernel>
	<16481.49534.124281.434663@napali.hpl.hp.com.suse.lists.linux.kernel>
	<20040324172454.GP31589@devserv.devel.redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Mar 2004 18:49:21 +0100
In-Reply-To: <20040324172454.GP31589@devserv.devel.redhat.com.suse.lists.linux.kernel>
Message-ID: <p73wu5at9su.fsf@brahms.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> writes:
> 
> Nope.  Think about multithreaded apps.  Furthermore, getting the exact
> extents of the particular stack is difficult to find for applications,
> but e.g. the threading library has to know such things.

It's actually not that difficult. You just have to read /proc/self/maps
and check for the mapping of your current stack pointer.
For the main stack GROWSDOWN will inherit the x or nx on growing
down.

And cache a flag about this in a TLS variable.

-Andi
