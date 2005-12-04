Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVLDVqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVLDVqe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 16:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVLDVqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 16:46:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43418 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932313AbVLDVqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 16:46:33 -0500
Subject: Re: Is the address space of a process continous
From: Arjan van de Ven <arjan@infradead.org>
To: Mohamed El Dawy <msdawy@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <afd776760512041337l40a1879drb8b0b526100791a8@mail.gmail.com>
References: <afd776760512041337l40a1879drb8b0b526100791a8@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 22:46:29 +0100
Message-Id: <1133732789.5188.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-04 at 15:37 -0600, Mohamed El Dawy wrote:
> Hi,
>  I have a question. In the vma_memory_address struct, there are 2
> fields "vm_start" and "vm_end". I was wondering, does the process
> address space include all addresses between those 2 addresses? or
> could there be holes inside this range?
> 
> The main reason I am asking is because I tried to call __follow_page()
> on some of those addresses and got NULL as a result. I am not sure if
> this is a hole, or just a problem with my code!

the kernel does this on demand; eg
user mmaps a range
user touches (read or writes) part of that range

each time the user gets to a page that wasn't touched/used before, the
kernel takes a fault and fills in the address.

if you get nulls it's just pages that haven't been used yet.


