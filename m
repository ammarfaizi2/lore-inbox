Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVDSMG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVDSMG6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 08:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVDSMG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 08:06:58 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:42450 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261463AbVDSMGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 08:06:55 -0400
To: Olivier Galibert <galibert@pobox.com>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: alloc_pages and struct page *
References: <20050419105004.GA7612@dspnet.fr.eu.org>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 19 Apr 2005 13:06:50 +0100
In-Reply-To: <20050419105004.GA7612@dspnet.fr.eu.org> (Olivier Galibert's
 message of "Tue, 19 Apr 2005 12:50:04 +0200")
Message-ID: <tnxu0m3ezs5.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert <galibert@pobox.com> wrote:
> If I get a struct page * from a call to alloc_pages with a non-zero
> order, how do I get the struct page * of te following pages from the
> same allocation in order to use them in calls to tcp_sendpage?

page++;

The page structures are kept in an array, "mem_map" if
CONFIG_DISCONTIGMEM is not set or something like
"discontig_node_data[nid].node_mem_map" otherwise (this is true for
the ARM architecture, should be similar on the others). "alloc_pages"
allocates a contiguous range of pages from an array (and doesn't cross
a node boundary).

-- 
Catalin

