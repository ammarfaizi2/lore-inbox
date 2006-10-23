Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751901AbWJWLLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbWJWLLr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbWJWLLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:11:47 -0400
Received: from web32412.mail.mud.yahoo.com ([68.142.207.205]:43137 "HELO
	web32412.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751901AbWJWLLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:11:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nFaiJ040FrisoG+M6yJp3hAggZbr2s/2zpyM4IPdOtEv9zsEg9SF8iwidRQldQugtUCk+wagXZUz0dEutUXm1asqsLjWhjYAab5/QtSzIoIw0Pwm0tHJqnO/zcnK3nxL4FtY3jXm4gEnOvlqYt8V76BMaoorcxXcuOEjQOr2n6E=  ;
Message-ID: <20061023111145.52479.qmail@web32412.mail.mud.yahoo.com>
Date: Mon, 23 Oct 2006 04:11:45 -0700 (PDT)
From: Giridhar Pemmasani <pgiri@yahoo.com>
Subject: Re: __vmalloc with GFP_ATOMIC causes 'sleeping from invalid context'
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1161599894.19388.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> You are not allowed to call vmalloc in atomic context, especially in
> interrupt paths. Vmalloc has to do TLB handling work and that can
> involve cross calls and other stuff that isn't IRQ friendly on all
> platforms.

This has been discussed before:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114831100404677&w=2

The problem is not with calling vmalloc in atomic context, but __vmalloc,
which can be. The proposed patch makes sure __vmalloc is not supposed to be
called in interrupt context.

Giri

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
