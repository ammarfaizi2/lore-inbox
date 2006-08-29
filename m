Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWH2J7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWH2J7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWH2J7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:59:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22971 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964868AbWH2J7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:59:19 -0400
Subject: Re: [PATCH -mm] lib/rwsem.c: un-inline rwsem_down_failed_common()
From: Arjan van de Ven <arjan@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <11555.1156845039@warthog.cambridge.redhat.com>
References: <20060828200416.GA31315@rhlx01.fht-esslingen.de>
	 <11555.1156845039@warthog.cambridge.redhat.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 29 Aug 2006 11:59:09 +0200
Message-Id: <1156845549.2722.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 10:50 +0100, David Howells wrote:
> Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> 
> > Un-inlining rwsem_down_failed_common() (two callsites) reduced
> > lib/rwsem.o on my Athlon, gcc 4.1.2 from 5935 to 5480 Bytes (455 Bytes saved).
> 
> Maybe this should be judged according to CONFIG_CC_OPTIMIZE_FOR_SIZE.

gcc already does this if you don't manually specify the inline
keyword ;)

static functions get inlined if they're small enough in relation to the
nr of call sites, where "small enough" is a function of -O2 vs -Os. So
leaving away inline makes gcc do its smarts.


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

