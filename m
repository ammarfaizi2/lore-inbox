Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263972AbUGRNBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUGRNBq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 09:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbUGRNBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 09:01:46 -0400
Received: from mother.openwall.net ([195.42.179.200]:39840 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S263972AbUGRNBo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 09:01:44 -0400
Date: Sun, 18 Jul 2004 16:59:25 +0400
From: Solar Designer <solar@openwall.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: question about /proc/<PID>/mem in 2.4 (fwd)
Message-ID: <20040718125925.GA20133@openwall.com>
References: <20040707234852.GA8297@openwall.com> <Pine.LNX.4.44.0407181336040.2374-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407181336040.2374-100000@einstein.homenet>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2004 at 01:41:34PM +0100, Tigran Aivazian wrote:
> > | 	setuidapp < /proc/self/mem
[...]
> In the above example there is nothing forbidden and the current state of 
> things doesn't prevent the program from reading it's own address space.
> 
> Thus I see absolutely nothing special about the case:
> 
> # setuidapp < /proc/self/mem
> 
> and this program reading stdin.

The problem is the program does not know its stdin corresponds to a
process' address space and it does not know it is making use of a
privilege to read it.  A correctly written SUID root program may
reasonably assume that the data it obtains from stdin is whatever the
unprivileged user has provided, -- and, for example, display such data
back to the user (as a part of an error message or so).  If we permit
reads from /proc/<pid>/mem based on credentials of the read(2)-calling
process only, this assumption would be violated resulting in security
holes.

Oh, by the way, I've just noticed that the above example is not
entirely correct.  In order to read setuidapp's own address space
(after the kernel has been patched according to your proposal), it
should have been:

$ exec setuidapp < /proc/self/mem

-- 
Alexander Peslyak <solar@openwall.com>
GPG key ID: B35D3598  fp: 6429 0D7E F130 C13E C929  6447 73C3 A290 B35D 3598
http://www.openwall.com - bringing security into open computing environments
