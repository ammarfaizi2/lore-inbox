Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbUBEArA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUBEAqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:46:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:32899 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265178AbUBEAnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:43:07 -0500
Date: Wed, 4 Feb 2004 16:43:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>, kmannth@us.ibm.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving
 X  (fwd)
In-Reply-To: <64260000.1075941399@flay>
Message-ID: <Pine.LNX.4.58.0402041639420.2086@home.osdl.org>
References: <51080000.1075936626@flay> <Pine.LNX.4.58.0402041539470.2086@home.osdl.org>
 <60330000.1075939958@flay> <64260000.1075941399@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Feb 2004, Martin J. Bligh wrote:
> 
> Oh hell ... I remember what's wrong with this whole bit. pfn_valid is
> used inconsistently in different places, IIRC. Linus / Andrew ... what
> do you actually want it to mean? Some things seem to use it to say
> "the memory here is valid accessible RAM", some things "there is a 
> valid struct page for this pfn". I was aiming for the latter, but a
> few other arches seemed to disagree.
> 
> Could I get a ruling on this? ;-)

It _definitely_ means "there is a valid 'struct page' for this pfn". 

To test for "there is RAM" here, you need to first check that the pfn is
valid, and then you can check what the page type is (usually that would be
PageReserved(), but it could be a highmem check or something like that
too).

		Linus
