Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWADSSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWADSSF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWADSSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:18:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8842 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030261AbWADSSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:18:03 -0500
Date: Wed, 4 Jan 2006 18:18:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Denis Vlasenko <vda@ilport.com.ua>, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix warning in 8250.c
Message-ID: <20060104181801.GA3605@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Denis Vlasenko <vda@ilport.com.ua>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200601031012.49068.vda@ilport.com.ua> <20060104181425.GE3119@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104181425.GE3119@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 06:14:25PM +0000, Russell King wrote:
> On Tue, Jan 03, 2006 at 10:12:48AM +0200, Denis Vlasenko wrote:
> >   CC      drivers/serial/8250.o
> > /.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/serial/8250.c:1085: warning: 'transmit_chars' declared inline after being called
> > /.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/serial/8250.c:1085: warning: previous declaration of 'transmit_chars' was here
> > 
> > Since this function is not small, inlining effect is way below noise floor.
> > Let's just remove _INLINE_.
> 
> I think we want to remove _INLINE_ from both receive_chars and
> transmit_chars.  Both functions aren't small, so...

While we're at it can we please kill _INLINE_?  Those functions that should
be inlined can become inline, but this macro just obsfucates the serial code.
