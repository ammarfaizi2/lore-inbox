Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWEAXKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWEAXKF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 19:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWEAXKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 19:10:05 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:2244 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S932311AbWEAXKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 19:10:01 -0400
In-Reply-To: <445690F7.5050605@am.sony.com>
References: <20060429232812.825714000@localhost.localdomain>	<20060429233922.167124000@localhost.localdomain> <F989FA67-91B5-493B-9A12-D02C3C14A984@kernel.crashing.org> <445690F7.5050605@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FE7E70B5-F0CD-4254-8555-27EC2A70C316@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org, paulus@samba.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-kernel@vger.kernel.org,
       cbe-oss-dev@ozlabs.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 11/13] cell: split out board specific files
Date: Tue, 2 May 2006 01:09:53 +0200
To: Geoff Levand <geoffrey.levand@am.sony.com>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Segher, a problem with your suggestion is that our
> makefiles don't have as rich a set of logical ops as the
> config files.  Its easy to express 'build A if B', but not
> so easy to do 'build A if not C'.  To make this work
> cleanly I made PPC_CELL denote !SOME_HYPERVISOR_THING,
> so I can have constructions like this in the makefile:

Not just that, but we can have a kernel image supporting both
the "raw" hardware _and_ stuff with a hypervisor underneath.

All CONFIG_<whatever> should always be used as a positive,
never a negative.  My bad :-)

So it really should be

	depends on PPC_CELL_NATIVE

or similar.  Having PPC_CELL mean "native" / "raw" is not the
way to go, there will be many many hypervisors in the future,
it would be nice to have PPC_CELL mean just that, "support for
the Cell architecture" in general, kernels running on various
hypervisors will see the hardware virtualised to varying degrees.


Segher

