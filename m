Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWHKMqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWHKMqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 08:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWHKMqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 08:46:43 -0400
Received: from web25812.mail.ukl.yahoo.com ([217.146.176.245]:19324 "HELO
	web25812.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932216AbWHKMqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 08:46:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=bzRsIFdn0DU3uN0W7ZkJ03u+A+1GkKn1hcUP3NnBGr1Sj5exUI3LnV+yDj7UeFYwBOgQBa4DVethV6RshYAc124ermMjTL2tGz8WJy0Js0Uq453nIlBegAHOO30x1XsWbkV847OWsEvWvcqZpdkP3PTqkE7AfKjgEOiW8WRte04=  ;
Message-ID: <20060811124638.99233.qmail@web25812.mail.ukl.yahoo.com>
Date: Fri, 11 Aug 2006 12:46:38 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : Re : Re : sparsemem usage
To: Andy Whitcroft <apw@shadowen.org>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <44DC3F47.70508@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> It does produce real numbers, it tells you how many reserved pages you
> have.  The places that this is triggered we are interested in why we
> have no memory left.  We are not interested in how many pages are known
> but reserved as against how many pages are backed by page*'s but are
> really holes; they are mearly pages we can't use out of the total we are
> tracking.  We care about how many are not reserved, and how many of
> those are available.
> 
> It would be 'as simple' as adding a PG_real page bit except for two things:
> 
> 1) page flags bits are seriously short supply; there are some 24
> available of which 22 are in use.  Any new user of a bit would have to
> be an extremely valuable change with major benefit to the kernel, and
> 

It's indeed an issue. Could we instead use a combination of flags
that can't happen together. For example PG_Free|PG_Reserved ?

> 2) if you were to try and populate a PG_real flag it would need to be
> populated for _all_ architectures (and there are a lot) for it to be of
> any use.  As you have already noted there is no consistent way to find
> out whether a page is ram so it would be major exercise to get these
> bits setup during boot.
> 
> I think we should take (2) as a hint here.  If we don't have a
> consistent interface for finding whether a page is real or not, we
> obviously have no general need of that information in the kernel.
> 

or maybe _because_ we don't have a consistent interface for finding 
whether a page is real or not, we end up with a strange thing called
page_is_ram() which could be the same for all arch and be implemented
very simply.

BTW, can you try in a linux tree:

$ grep -r page_is_ram arch/

and see how it's implemented...

thanks

Francis
