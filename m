Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWECAGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWECAGM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 20:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWECAGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 20:06:12 -0400
Received: from cantor2.suse.de ([195.135.220.15]:8909 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965047AbWECAGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 20:06:11 -0400
From: Neil Brown <neilb@suse.de>
To: Al Boldi <a1426z@gawab.com>
Date: Wed, 3 May 2006 10:05:53 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17495.62433.136481.543828@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 009 of 11] md: Support stripe/offset mode in raid10
In-Reply-To: message from Al Boldi on Tuesday May 2
References: <20060501152229.18367.patches@notabene>
	<1060501053054.23009@suse.de>
	<200605021938.45254.a1426z@gawab.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 2, a1426z@gawab.com wrote:
> NeilBrown wrote:
> > The "industry standard" DDF format allows for a stripe/offset layout
> > where data is duplicated on different stripes. e.g.
> >
> >   A  B  C  D	
> >   D  A  B  C	
> >   E  F  G  H	
> >   H  E  F  G	
> >
> > (columns are drives, rows are stripes, LETTERS are chunks of data).
> 
> Presumably, this is the case for --layout=f2 ?

Almost.  mdadm doesn't support this layout yet.  
'f2' is a similar layout, but the offset stripes are a lot further
down the drives.
It will possibly be called 'o2' or 'offset2'.

> If so, would --layout=f4 result in a 4-mirror/striped array?

o4 on a 4 drive array would be 

   A  B  C  D
   D  A  B  C
   C  D  A  B
   B  C  D  A
   E  F  G  H
   ....

> 
> Also, would it be possible to have a staged write-back mechanism across 
> multiple stripes?

What exactly would that mean?  And what would be the advantage?

NeilBrown
