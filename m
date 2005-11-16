Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbVKPPBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbVKPPBo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbVKPPBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:01:44 -0500
Received: from web34113.mail.mud.yahoo.com ([66.163.178.111]:65108 "HELO
	web34113.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030352AbVKPPBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:01:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VyUkfaQdJFKyMnKADUPtzYC/532ebrRTSepqo+fiwXuDdKw2XRFEzdoY9WkXPYzz3EkoIRZYbu5wF79hYj95yBncCoTmfNTh72hCMngUXszmMrpxxqvpOxHfZT6kxO0lxSCc07i/X3qKWThXsWVdDT1UPWgfPrXo4/6ZFRuBVsg=  ;
Message-ID: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
Date: Wed, 16 Nov 2005 07:01:40 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap over nfs leads to excessive system load
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1132149812.8812.16.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> Anyhow, does the following patch help?

Unfortunately, not:

samples  %        symbol name
545009   15.2546  find_get_pages_tag
450595   12.6120  mpage_writepages
383196   10.7255  release_pages
381479   10.6775  unlock_page
351513    9.8387  clear_page_dirty_for_io
317784    8.8947  pci_conf1_write
167918    4.7000  __lookup_tag
160701    4.4980  page_waitqueue
59142     1.6554  _spin_lock_irqsave
47655     1.3338  skb_copy_bits
39136     1.0954  __wake_up_bit
38143     1.0676  _read_lock_irqsave


With reducing the window size to 32k, things aren't much different:
samples  %        symbol name
474589   21.2001  find_get_pages_tag
370512   16.5509  mpage_writepages
310556   13.8727  release_pages
302571   13.5160  unlock_page
286541   12.7999  clear_page_dirty_for_io
119717    5.3478  page_waitqueue
109920    4.9102  __lookup_tag
33313     1.4881  pci_conf1_write
29198     1.3043  __wake_up_bit
27075     1.2095  _read_lock_irqsave
25009     1.1172  _read_unlock_irq

... except the performance is much worse than with the 2M buffer (hence the 2M choice).  With the
smaller buffer, the throughput starts at 8M/sec and quickly drops to 1M/sec.

-Kenny



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
