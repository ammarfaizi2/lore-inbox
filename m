Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVF1UUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVF1UUC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVF1URp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:17:45 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:15561 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261264AbVF1URF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:17:05 -0400
Date: Tue, 28 Jun 2005 22:17:04 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Robert Love <rml@novell.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
Subject: Re: wrong madvise(MADV_DONTNEED) semantic
Message-ID: <20050628201704.GC4453@wohnheim.fh-wedel.de>
References: <20050628134316.GS5044@implementation.labri.fr> <20050628181620.GA1423@hexapodia.org> <1119983300.6745.1.camel@betsy> <20050628185300.GB30079@hexapodia.org> <1119986623.6745.10.camel@betsy> <20050628194128.GM4645@bouh.labri.fr> <20050628200330.GB4453@wohnheim.fh-wedel.de> <1119989111.6745.21.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1119989111.6745.21.camel@betsy>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 June 2005 16:05:11 -0400, Robert Love wrote:
> 
> I like the idea (I think someone suggested this early on) of renaming
> the current MADV_DONTNEED to MADV_FREE and then adding a correct
> MADV_DONTNEED.

Imo, that's still a crime against common sense.  Madvice should give
the kernel some advice about which data to keep or not to keep in
memory, hence the name.  It should *not* tell the kernel to corrupt
data, which currently appears to be the case.

If the application knows 100% that it is the _only_ possible user of
this data and will never again use it, dropping dirty pages might be a
sane option.  Effectively that translates to anonymous memory only.
In all other cases, dirty pages should be written back.

> And, as I said, the man page needs clarification.

Definitely.

Jörn

-- 
Eighty percent of success is showing up.
-- Woody Allen
