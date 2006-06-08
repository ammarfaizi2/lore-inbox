Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWFHGqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWFHGqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 02:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWFHGqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 02:46:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:57311 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932531AbWFHGqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 02:46:34 -0400
Message-ID: <4487C7C4.7090302@suse.de>
Date: Thu, 08 Jun 2006 08:46:28 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jamagallon@ono.com
Subject: Re: 2.6.17-rc6-mm1
References: <20060607104724.c5d3d730.akpm@osdl.org>	<20060608003153.36f59e6a@werewolf.auna.net>	<20060607154054.cf4f2512.akpm@osdl.org> <p73irnctmcc.fsf@verdi.suse.de>
In-Reply-To: <p73irnctmcc.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I don't see an explicit check in alternatives.c for the main kernel
> vs init sections and with CPU hotplug the alternatives can be applied
> arbitarily after the system has booted.  So it would just stomp
> over the init text pages which are used for something else now.

very close to the end of the file:

  alternatives_smp_module_add(NULL, "core kernel",
                              __smp_locks, __smp_locks_end,
                              _text, _etext);

The core kernel is just a "special" module (where we keep track of the
.text section boundaries too), and LOCKs outside the _text -> _etext
range are never ever patched.

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
http://www.suse.de/~kraxel/julika-dora.jpeg
