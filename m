Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267998AbUIAXlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbUIAXlF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267779AbUIAXkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:40:39 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:12225 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268119AbUIAXXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:23:45 -0400
Date: Thu, 2 Sep 2004 00:23:25 +0100
From: Dave Jones <davej@redhat.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Module unloading policy (should be killed from .config ?)
Message-ID: <20040901232325.GA31943@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"J.A. Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1094079597l.8614l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094079597l.8614l.0l@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 10:59:57PM +0000, J.A. Magallon wrote:
 > Hi all...
 > 
 > Since 2.6.8.1-mm3, my system hangs when I modprobe -r ipt_MASQUERADE
 > (yup, you guessed, its an SMP box). Just locks hard.
 > 
 > A kernel build without module unloading seems to work. I heard about
 > module unloading not being safe, but this is the first time it hits me
 > seriously.

I wrote a script a while ago that modprobe'd & rmmod'd every module
it could find. Results weren't pretty.

Lessons learned:
- lots of driver writers don't take into consideration the fact the hardware
  might not be present when the driver does probing.
- Those that do, fail to clean up properly in this case.
- A lot of drivers leave junk in sysfs/procfs after rmmod which causes
  great fun for the next driver that gets loaded that uses the same subsystems.

It's been a few months since I last ran that script, but I'll bet
the results today aren't much better than they were back then
despite a bunch of problems I reported getting fixed.

		Dave

