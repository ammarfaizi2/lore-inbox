Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264162AbTKZL5L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 06:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbTKZL5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 06:57:11 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:29602 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264162AbTKZL5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 06:57:10 -0500
Subject: Re: 2.4.20-18 size-4096 memory leaks
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: yuval yeret <yuval_yeret@hotmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1069844249.3fc487195c258@imp.gcu.info>
References: <1069844249.3fc487195c258@imp.gcu.info>
Content-Type: text/plain
Organization: 
Message-Id: <1069847824.2031.16.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Nov 2003 11:57:05 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2003-11-26 at 10:57, Jean Delvare wrote:

> I just wanted to let you know that I have been experiencing similar
> leaks. So far, I wasn't enable to find where the leak was, but your
> theory matches my observations:
> 
> 1* On two systems running 2.4.20-2.4.22 kernels, I observed that the
> free memory as reported by top was going down regularly, by blocks of 4
> or 8kB at an average rate of 90kB/min. Sometimes the value would
> stabilize, but I couldn't understand why. What was lost as "free"
> memory
> increased "buffers" from the same amount.

That's not a leak, it simply sounds like cache effects.  atime updates
result in journal commits under ext3, and those use at least a couple of
buffers at a time (one for the metadata descriptor block in the journal,
one for the journal commit.)  Those aren't leaks --- they are temporary
use of cache, and once the IO has complete the memory can be immediately
reclaimed by the kernel if it is needed for anything else.

Cheers, 
 Stephen


