Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVETPTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVETPTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 11:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVETPTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 11:19:21 -0400
Received: from iona.labri.fr ([147.210.8.143]:8666 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S261492AbVETPSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 11:18:54 -0400
Date: Fri, 20 May 2005 17:18:46 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org
Subject: spin_unlock_bh() and preempt_check_resched()
Message-ID: <20050520151846.GP3690@bouh.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm wondering about macros like _spin_unlock_bh(lock):
do { \
        _raw_spin_unlock(lock); \
        preempt_enable(); \
        local_bh_enable(); \
        __release(lock); \
} while (0)

Is there a reason for using preempt_enable() instead of a simple
preempt_enable_no_resched() ?

Since we know bottom halves are disabled, preempt_schedule() will always
return at once (preempt_count!=0), and hence preempt_check_resched() is
useless here...

Regards,
Samuel
