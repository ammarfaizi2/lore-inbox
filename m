Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030523AbVIOREa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523AbVIOREa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 13:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbVIOREa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 13:04:30 -0400
Received: from nef2.ens.fr ([129.199.96.40]:37643 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1030523AbVIOREa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 13:04:30 -0400
Date: Thu, 15 Sep 2005 19:04:26 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel Mailing-List <linux-kernel@vger.kernel.org>
Subject: simple synchronization questions (freeing on rmmod)
Message-ID: <20050915170426.GA28104@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Thu, 15 Sep 2005 19:04:27 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm trying to learn the rudiments of kernel programming by writing a
simple module (as it turns out, a driver for my motherboard's ECC RAM
controller).  The module installs basically three things: an interrupt
handler, a timer (to make sure the controller is checked periodically,
even if it does not generate an interrupt) and a file entry in the
/proc filesystem.

My question is about synchronization when the module is being removed.
To remove the timer, I am told that I must use del_timer_sync()
(rather than just del_timer()) so as to make sure there is no instance
of the timer still running.  Now what about the interrupt handler?  Is
there a guarantee that after free_irq() there cannot be an instance of
the interrupt handler running on another process?  If not, what is the
recommended way to make sure of that before exiting the module?
Lastly, what about the /proc entry?  What is the recommended and
reliable way to make sure all open file descriptors pointing to it are
closed before exiting the module?

Thanks for your help,

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
