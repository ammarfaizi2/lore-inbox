Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263549AbTIHUX1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263581AbTIHUX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:23:27 -0400
Received: from srahubgw.sra.com ([163.252.31.6]:61195 "EHLO srahubgw.sra.com")
	by vger.kernel.org with ESMTP id S263549AbTIHUXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:23:25 -0400
Message-ID: <16220.58678.399619.878405@irving.iisd.sra.com>
From: David Garfield <garfield@irving.iisd.sra.com>
To: linux-kernel@vger.kernel.org
Cc: andersen@codepoet.org, Matthew Wilcox <willy@debian.org>
Date: Mon, 8 Sep 2003 16:23:18 -0400
Subject: Re: kernel header separation
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: VM 6.96 under Emacs 20.7.1
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk>
	<20030903014908.GB1601@codepoet.org>
	<20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk>
	<20030905211604.GB16993@codepoet.org>
In-Reply-To: <20030905211604.GB16993@codepoet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen writes:
 > On Fri Sep 05, 2003 at 03:41:54PM +0100, Matthew Wilcox wrote:
 > > On Tue, Sep 02, 2003 at 07:49:09PM -0600, Erik Andersen wrote:
 > > > Header files intended for use by users should probably drop
 > > > linux/types.h just include <stdint.h>,,,  Then convert the 
 > > > types over to ISO C99 types.
 > > 
 > > stdint.h is a userspace header.  I suppose we could clone it for the
 > > kernel, but I don't see any need to.
 > > 
 > > > s/__u8/uint8_t/g
 > > > s/__u16/uint16_t/g
 > > > s/__u32/uint32_t/g
 > > > s/__u64/uint64_t/g
 > > 
 > > i think all these _t types are ugly ;-(
 > 
 > They may be ugly, but they are standardized and have very 
 > precise meanings defined by ISO C99, which is a very good
 > thing for code interoperability...
 > 
 >  -Erik

On the other hand, the ISO C99 definition is probably something like:
an integral type capable of storing the values 0 through 255
inclusive.  (ok, I don't have a copy of the new standard but I have
seriously examined the old one.)  I would not count on uint8_t
necessarily being unsigned on unusual hardware.  Linux on the other
hand probably means __u8 as an exactly eight bit unsigned integer
value.  While these may LOOK like identical statements, Linux is
[probably] making a significantly stronger statement.

I would say - keep the Linux types, and then document exactly what
Linux means by them somewhere.  In particular, if Linux were ported to
a 9/18/36 bit platform, what would the semantics of __u8 be?  (Ok,
maybe the documentation should say such a port is not considered to be
viable at this time.)

--David Garfield

