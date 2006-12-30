Return-Path: <linux-kernel-owner+w=401wt.eu-S1030222AbWL3Cp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWL3Cp6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 21:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWL3Cp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 21:45:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56512 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030222AbWL3Cp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 21:45:57 -0500
Date: Fri, 29 Dec 2006 21:45:54 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: potential for buffer_head shrinkage.
Message-ID: <20061230024554.GA12306@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at struct buffer_head, it seems that b_state
uses at most 15 bits, where it's defined as a 64bit entity
due to it being used by bit_spin_lock and friends.

Given it's not uncommon for a few hundred thousand of these
to be present, I wonder if it's worth the effort of folding
b_count into the upper bits of b_state, thus shrinking
buffer_head by 16 bits?  This would still leave 32 bits
'wasted' for further bh_state_bits expansion if necessary.

Opinions?

		Dave

-- 
http://www.codemonkey.org.uk
