Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVCGK0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVCGK0S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 05:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVCGK0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 05:26:18 -0500
Received: from ns.suse.de ([195.135.220.2]:24224 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261736AbVCGK0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 05:26:13 -0500
Date: Mon, 7 Mar 2005 11:26:09 +0100
From: Karsten Keil <kkeil@suse.de>
To: Domen Puncer <domen@coderock.org>
Cc: Ralph Corderoy <ralph@inputplus.co.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
       jlamanna@gmail.com
Subject: Re: [patch 1/8] isdn_bsdcomp.c - vfree() checking cleanups
Message-ID: <20050307102609.GB11334@pingi3.kke.suse.de>
Mail-Followup-To: Domen Puncer <domen@coderock.org>,
	Ralph Corderoy <ralph@inputplus.co.uk>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
	jlamanna@gmail.com
References: <20050306223800.1BBDC1EC90@trashy.coderock.org> <200503070007.j2707n403396@blake.inputplus.co.uk> <20050307002133.GG32564@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307002133.GG32564@nd47.coderock.org>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 01:21:33AM +0100, Domen Puncer wrote:
> On 07/03/05 00:07 +0000, Ralph Corderoy wrote:
> > 
> > Hi Domen,
> > 
> > > -		if (db->dict) {
> > > -			vfree (db->dict);
> > > -			db->dict = NULL;
> > > -		}
> > > +		vfree (db->dict);
> > > +		db->dict = NULL;
> > 
> > Is it really worth always calling vfree() which calls __vunmap() before
> > db->dict is determined to be NULL in order to turn three lines into two?
> 
> Four lines into two :-)
> 
> > Plus the write to db->dict which might otherwise not be needed.  The old
> > code was clear, clean, and fast, no?
> 
> Shorter and more readable code is always better, right? And speed really
> doesn't seem to be an issue here.
> 

I also prefer the old code, since it make clear, that you must be careful
here, since the function can be called with already freed db->dict, and for
me this version is not better readable as the old one.

-- 
Karsten Keil
SuSE Labs
ISDN development
