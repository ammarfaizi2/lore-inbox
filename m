Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUDUJwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUDUJwY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 05:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264497AbUDUJwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 05:52:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35013 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264373AbUDUJwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 05:52:22 -0400
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040421021010.GC23621@mail.shareable.org>
References: <1080771361.1991.73.camel@sisko.scot.redhat.com>
	 <20040416223548.GA27540@mail.shareable.org>
	 <1082411657.2237.128.camel@sisko.scot.redhat.com>
	 <20040421021010.GC23621@mail.shareable.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1082541128.2060.14.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Apr 2004 10:52:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2004-04-21 at 03:10, Jamie Lokier wrote:

> msync(0) has always had behaviour consistent with the <=2.4.9 and
> >=2.5.68 MS_ASYNC behaviour, is that right?

Not sure about "always", but it looks like it recently at least.  2.2
msync was implemented very differently but seems, from the source, to
have the same property --- do_write_page() calls f_op->write() on msync,
and MS_SYNC forces an fsync after the writes.  But 2.4 and 2.6 share
much more similar code to each other.  So all since 2.2 seem to do the
fully-async, deferred writeback behaviour for flags==0.

--Stephen

