Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264461AbUGNEKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUGNEKi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 00:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265431AbUGNEKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 00:10:38 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:55774 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S264461AbUGNEKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 00:10:34 -0400
Date: Wed, 14 Jul 2004 06:10:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Zaitsev <peter@mysql.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040714041026.GX974@dualathlon.random>
References: <1089771823.15336.2461.camel@abyss.home> <20040714031701.GT974@dualathlon.random> <1089776640.15336.2557.camel@abyss.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089776640.15336.2557.camel@abyss.home>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 08:44:02PM -0700, Peter Zaitsev wrote:
> The reason for me to disable swap both in 2.4 and 2.6 is - it really
> hurts performance. In some cases performance can be 2-3 times slower
> with swap file enabled.   Using O_DIRECT and mlock() for buffers helps 
> but not completely.

in 2.4 you can disable swap just fine (with oom killer disabled). until
I/somebody fix 2.6 you can workaround this problem while still avoiding
to swap much by setting /proc/sys/vm/swappiness to 0 or similar to tell
the VM "please don't swap" even if swap is enabled ;). That will still
prevent the oom killer to kick in. The oom killer is forbidden to run
as long as `free` tells you that >= 4k of swap are still available to the
OS. There are no other fundamental vm problems left I'm aware of in
latest 2.6 besides these no-swap and oom issues.
