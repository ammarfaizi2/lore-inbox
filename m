Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266217AbUHTKbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUHTKbx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUHTKbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:31:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59565 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268042AbUHTKbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:31:40 -0400
Subject: Re: PF_MEMALLOC in 2.6
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Arjan van de Ven <arjanv@redhat.com>,
       Alan Cox <alan@redhat.com>, Greg KH <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@redhat.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1092997872.1996.51.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Aug 2004 11:31:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-08-19 at 13:41, Hugh Dickins wrote:

> Or would it solve the problem at hand, if it made itself PF_MEMALLOC
> just while servicing a request from a PF_MEMALLOC?

It's not the PF_* state of the caller who submitted the IO that matters,
though --- it's the state of all threads _waiting_ on the IO, which may
be different, and which can change even after the IO has begun.  

Eg. kswapd does a writepage, the writepage needs to allocate disk space,
and in doing so tries to access a metadata block which is already
undergoing IO from a different thread altogether.

--Stephen

