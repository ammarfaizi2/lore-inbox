Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUE3FKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUE3FKq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 01:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUE3FKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 01:10:46 -0400
Received: from ms-smtp-03-smtplb.ohiordc.rr.com ([65.24.5.137]:47046 "EHLO
	ms-smtp-03-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S261718AbUE3FKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 01:10:44 -0400
From: Rob <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: linux-kernel@vger.kernel.org
Subject: Re: seperate environments for different kernels
Date: Sun, 30 May 2004 01:12:44 -0500
User-Agent: KMail/1.6.2
References: <Pine.GSO.4.58.0405292206320.2487@tokyo.cc.gatech.edu>
In-Reply-To: <Pine.GSO.4.58.0405292206320.2487@tokyo.cc.gatech.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405300112.44866.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 May 2004 09:13 pm, Younggyun Koh wrote:
> Hi,
>
> i want to run linux 2.6.6 kernel, which needs upgrade of some system tools
> such as module-init-tools and nfs-utils. but other guys using the same
> machine with 2.4 kernel don't want me to upgrade them.
>

sorry, typo bug: that statement is actually 
[ `uname -r` == "2.x.x-this-script's-desired-version" ] || exit

and since mod-init-tools are in /, you may need to actually replace them all 
with wrapper scripts which call up the right one, passing all command-line 
arguments to the real one... you install the 2.4 utils, move them all (i.e., 
to *-2.4) then the same for 2.6, and make a script with the original name 
that calls the 2.6 binary when uname -r returns a 2.6 kernel, likewise with 
2.4, etc.

even easier: you may be able to get away with this hack:

mount --bind /some-dir/2.6-bin /bin
mount --bind /some-dir/2.6-lib /lib
mount --bind /some-dir/2.6-sbin /sbin
mount --bind /some-dir/2.6-etc /etc
and so on.

do this in a script that starts with that statement above, so that only when 
*your* kernel runs, it maps over the 2.4 kit without touching it.

-- 
Rob Couto [rpc@cafe4111.org]
computer safety tip: use only a non-conducting, static-free hammer.
--
