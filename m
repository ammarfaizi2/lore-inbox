Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUFXMGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUFXMGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 08:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbUFXMGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 08:06:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6798 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264298AbUFXMF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 08:05:58 -0400
Date: Thu, 24 Jun 2004 08:05:34 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: using gcc built-ins for bitops?
Message-ID: <20040624120534.GW21264@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040624070936.GB30057@devserv.devel.redhat.com> <20040624020022.0601d4ae.akpm@osdl.org> <20040624113151.GA21376@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624113151.GA21376@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 01:31:51PM +0200, Arjan van de Ven wrote:
> On Thu, Jun 24, 2004 at 02:00:22AM -0700, Andrew Morton wrote:
> > For the implementation it would be nice to have the old-style
> > implementations in one header and the new-style ones in a separate header. 
> > That would create a bit of an all-or-nothing situation, but that should be
> > OK?
> 
> In addition I stuck those in asm-generic since they no longer are
> architecture specific....

This is not going to work.
Say on x86_64, __builtin_ctzl (~word) ends up __ctzdi2 (~word) call in GCC
3.4.x, which is not defined in the kernel (in 3.5 it will be bsfq).
On a bunch of arches which don't have an instruction for ffz operation
it will always result in a library call.

	Jakub
