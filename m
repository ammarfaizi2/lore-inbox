Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbUK0B7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUK0B7C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbUK0Bqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:46:40 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263033AbUKZTia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:30 -0500
Date: Thu, 25 Nov 2004 09:06:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Sami Farin <7atbggg02@sneakemail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] VmLib wrapped: executable brk
Message-ID: <20041125170620.GY2714@holomorphy.com>
References: <Pine.LNX.4.44.0411251611220.5235-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0411251611220.5235-100000@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 04:18:51PM +0000, Hugh Dickins wrote:
> In some cases /proc/<pid>/status shows VmLib: 42949..... kB.
> If READ_IMPLIES_EXEC then the break area is VM_EXEC, but omitted from
> exec_vm since do_brk contains no __vm_stat_account call.  Later munmaps
> count its pages out of exec_vm, hence (exec_vm - VmExe) can go negative.
> do_brk is right not to call __vm_stat_account, its pages shouldn't need
> to be counted.  What's wrong is that __vm_stat_account is counting all
> the VM_EXEC pages, whereas (to mimic 2.4 and earlier 2.6) it should be
> leaving VM_WRITE areas and non-vm_file areas out of exec_vm.
> VmLib may still appear larger than before - where a READ_IMPLIES_EXEC
> personality makes what was a readonly mapping of a file now executable
> e.g. /usr/lib/locale stuff.  And a program which mprotects its own text
> as writable will appear with wrapped VmLib: sorry, but while it's worth
> showing ordinary programs as ordinary, it's not worth much effort to
> avoid showing odd ones as odd.

These both look straightforward corrections of oversights on my part.
My apologies for whatever confusion they may have caused.


-- wli
