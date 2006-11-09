Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423859AbWKITp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423859AbWKITp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423860AbWKITp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:45:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53689 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423859AbWKITp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:45:57 -0500
Subject: Re: [RFC][PATCH 8/8] RSS controller support reclamation
From: Arjan van de Ven <arjan@infradead.org>
To: Balbir Singh <balbir@in.ibm.com>
Cc: Linux MM <linux-mm@kvack.org>, dev@openvz.org,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       haveblue@us.ibm.com, rohitseth@google.com
In-Reply-To: <20061109193636.21437.11778.sendpatchset@balbir.in.ibm.com>
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
	 <20061109193636.21437.11778.sendpatchset@balbir.in.ibm.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 09 Nov 2006 20:45:43 +0100
Message-Id: <1163101543.3138.528.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 01:06 +0530, Balbir Singh wrote:
> 
> Reclaim memory as we hit the max_shares limit. The code for reclamation
> is inspired from Dave Hansen's challenged memory controller and from the
> shrink_all_memory() code


Hmm.. I seem to remember that all previous RSS rlimit attempts actually
fell flat on their face because of the reclaim-on-rss-overflow behavior;
in the shared page / cached page (equally important!) case, it means
process A (or container A) suddenly penalizes process B (or container B)
by making B have pagecache misses because A was using a low RSS limit.

Unmapping the page makes sense, sure, and even moving then to inactive
lists or whatever that is called in the vm today, but reclaim... that's
expensive...


