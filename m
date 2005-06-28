Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVF1Uid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVF1Uid (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVF1Uhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:37:39 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:11813 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S261485AbVF1UhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:37:12 -0400
Date: Tue, 28 Jun 2005 13:37:07 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: wrong madvise(MADV_DONTNEED) semantic
Message-ID: <20050628203707.GD30079@hexapodia.org>
References: <20050628134316.GS5044@implementation.labri.fr> <20050628181620.GA1423@hexapodia.org> <1119983300.6745.1.camel@betsy> <20050628185300.GB30079@hexapodia.org> <1119986623.6745.10.camel@betsy> <20050628194128.GM4645@bouh.labri.fr> <20050628200330.GB4453@wohnheim.fh-wedel.de> <1119989111.6745.21.camel@betsy> <20050628201704.GC4453@wohnheim.fh-wedel.de> <20050628202053.GO4645@bouh.labri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050628202053.GO4645@bouh.labri.fr>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 10:20:53PM +0200, Samuel Thibault wrote:
> Jörn Engel, le Tue 28 Jun 2005 22:17:04 +0200, a écrit :
> > If the application knows 100% that it is the _only_ possible user of
> > this data and will never again use it, dropping dirty pages might be a
> > sane option.  Effectively that translates to anonymous memory only.
> 
> And private file mappings?

So long as the mapping exists, the data should not disappear.  So a
MAP_PRIVATE mapping should behave just like a MAP_SHARED mapping, and
both need to be fixed to not lose data due to madvise(MADV_DONTNEED).
(I agree with Joern, MADV_FREE seems like an ill-advised extension.)

If this means some swap needs to be allocated, well, so be it.

-andy
