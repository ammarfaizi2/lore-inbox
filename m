Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVF1Ud3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVF1Ud3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVF1UdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:33:25 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:38601 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261443AbVF1UbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:31:03 -0400
Date: Tue, 28 Jun 2005 22:30:57 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Robert Love <rml@novell.com>, Andy Isaacson <adi@hexapodia.org>,
       linux-kernel@vger.kernel.org
Subject: Re: wrong madvise(MADV_DONTNEED) semantic
Message-ID: <20050628203057.GD4453@wohnheim.fh-wedel.de>
References: <20050628134316.GS5044@implementation.labri.fr> <20050628181620.GA1423@hexapodia.org> <1119983300.6745.1.camel@betsy> <20050628185300.GB30079@hexapodia.org> <1119986623.6745.10.camel@betsy> <20050628194128.GM4645@bouh.labri.fr> <20050628200330.GB4453@wohnheim.fh-wedel.de> <1119989111.6745.21.camel@betsy> <20050628201704.GC4453@wohnheim.fh-wedel.de> <20050628202053.GO4645@bouh.labri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050628202053.GO4645@bouh.labri.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 June 2005 22:20:53 +0200, Samuel Thibault wrote:
> Jörn Engel, le Tue 28 Jun 2005 22:17:04 +0200, a écrit :
> > If the application knows 100% that it is the _only_ possible user of
> > this data and will never again use it, dropping dirty pages might be a
> > sane option.  Effectively that translates to anonymous memory only.
> 
> And private file mappings?

As in inode->i_nlink == 0?  Yes, if you can prove that only this one
thread still has it open.  How to deal with multithreaded processes?
I don't know and would default to "write it back" again.

Besides, writing the dirty pages to backing store can only hurt
performance, never correctness.  The data could already be synced at
the time of the madvice call anyway.

Jörn

-- 
This above all: to thine own self be true.
-- Shakespeare
