Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbTATOSE>; Mon, 20 Jan 2003 09:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265880AbTATOSE>; Mon, 20 Jan 2003 09:18:04 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:34579 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265857AbTATOSC>; Mon, 20 Jan 2003 09:18:02 -0500
Date: Mon, 20 Jan 2003 14:27:03 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: size in /proc/modules
Message-ID: <20030120142703.GA58326@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18actG-0000uv-00*HHzxYJ2YXd2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/proc/modules size field includes init_size in 2.5. Why ?

The removal of sensible values in /proc/ksyms means that oprofile can no
longer attribute module samples reliably. The only information we have
is module_core address, and size == core_size+init_size. Since init code
is removed in sys_init_module, this will overestimate, and can lead to
overlapping with the start of another module, afaics.

In 2.4, we had size(.text), which could underestimate (think
.text.exit), but that is not a big problem.

Rusty, does this fall under another one of your "corner cases" ? (what I
would call "flaky code" ...)

Or I have I just missed something obvious ?

regards
john

-- 
"Anyone who quotes Rusty in their sig is an idiot."
	- me
