Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVCQC0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVCQC0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 21:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVCQC0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 21:26:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31711 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261784AbVCQCZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 21:25:54 -0500
Subject: Re: [patch] Syscall auditing - move "name=" field to the end
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050316224117.GC28536@shell0.pdx.osdl.net>
References: <4238A65C.7020908@rainbow-software.org>
	 <20050316224117.GC28536@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 17 Mar 2005 02:25:01 +0000
Message-Id: <1111026301.6833.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 (2.2.0-10) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-16 at 14:41 -0800, Chris Wright wrote:
> * Ondrej Zary (linux@rainbow-software.org) wrote:
> > This patch moves the "name=" field to the end of audit records. The 
> > original placement is bad because it cannot be properly parsed. It is 
> > impossible to tell if the name is "/bin/true" or "/bin/true inode=469634 
> > dev=00:00" because the "inode=" and "dev=" fields can be omitted.

Consider: 

open("/bin/true\naudit(1111008484.824:89346): ...", O_RDONLY);

I don't think this patch is enough -- either we need to escape the text
completely or just dump it as hex instead of a string. One option would
be to dump it in quotes as a string if all chars in the string are in
the range 0x20-0x7e, and as hex otherwise. That slightly complicates the
parsing, but not by much, and still gives you plain text in the majority
of cases while protecting against abuse.

-- 
dwmw2

