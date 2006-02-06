Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWBFR0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWBFR0x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWBFR0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:26:53 -0500
Received: from fmr23.intel.com ([143.183.121.15]:44511 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932243AbWBFR0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:26:53 -0500
Date: Mon, 6 Feb 2006 09:17:26 -0800
From: Benjamin LaHaise <bcrl@linux.intel.com>
To: linux-kernel@vger.kernel.org
Subject: Badness in blk_do_ordered
Message-ID: <20060206171726.GA16324@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a machine using ICH6 SATA and nbd, I just got this from the current git 
HEAD (e3f749c4af69c4344d89f11e2293e3790eb4eaca):

nbd: registered device at major 43
Badness in blk_do_ordered at block/ll_rw_blk.c:550

Call Trace: <IRQ> <ffffffff801e6414>{blk_do_ordered+753}
       <ffffffff801e25e8>{elv_next_request+36} <ffffffff80287b7b>{scsi_request_fn+120}
       <ffffffff801e4597>{blk_run_queue+48} <ffffffff801e653e>{bar_end_io+0}
       <ffffffff80286feb>{scsi_next_command+46} <ffffffff802870e3>{scsi_end_request+192}
       <ffffffff8028733b>{scsi_io_completion+452} <ffffffff802a089e>{sd_rw_intr+544}
       <ffffffff80286d67>{scsi_device_unbusy+85} <ffffffff80287afe>{scsi_softirq_done+212}
       <ffffffff801e5feb>{blk_done_softirq+123} <ffffffff8012ed48>{__do_softirq+80}
       <ffffffff8010bb46>{call_softirq+30} <ffffffff8010d415>{do_softirq+47}
       <ffffffff8010d3dc>{do_IRQ+62} <ffffffff80108f01>{mwait_idle+0}
       <ffffffff8010aea4>{ret_from_intr+0} <EOI> <ffffffff80108f37>{mwait_idle+54}
       <ffffffff80108ee2>{cpu_idle+98} <ffffffff8053a7a5>{start_kernel+434}
       <ffffffff8053a286>{_sinittext+646}

Anyone else seeing this?

		-ben
