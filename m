Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUHDKdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUHDKdz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 06:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUHDKdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 06:33:55 -0400
Received: from holomorphy.com ([207.189.100.168]:53690 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264045AbUHDKdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 06:33:54 -0400
Date: Wed, 4 Aug 2004 03:33:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Liu Tao <liutao@safe-mail.net>
Cc: arjanv@redhat.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Add a writer prior lock methord for rwlock
Message-ID: <20040804103337.GN2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Liu Tao <liutao@safe-mail.net>, arjanv@redhat.com,
	lkml <linux-kernel@vger.kernel.org>
References: <4110A7AF.2060903@safe-mail.net> <1091610963.2792.13.camel@laptop.fenrus.com> <4110BA81.4030309@safe-mail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4110BA81.4030309@safe-mail.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 06:29:21PM +0800, Liu Tao wrote:
> write_forcelock() should be used to avoid readers starve writers, or for 
> writers
> to update shared data as far as possiable, since it prevents new readers 
> acquire
> the lock while it's waiting for existing readers release their locks. 
> I'm not clear
> who will need it now,  since it doesn't affect the original read_lock() 
> and write_lock()
> I tried it.

Unfortunately this will deadlock. read locks are acquired recursively.
The algorithms dependent on this need to be redesigned.


-- wli
