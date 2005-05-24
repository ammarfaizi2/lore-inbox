Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVEXRCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVEXRCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVEXRCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:02:43 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:65459 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261154AbVEXRBX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 13:01:23 -0400
Message-ID: <42935DE1.4040301@freenet.de>
Date: Tue, 24 May 2005 19:01:21 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC/PATCH 2/4] fs/mm: execute in place (3rd version)
References: <1116866094.12153.12.camel@cotte.boeblingen.de.ibm.com> <1116869420.12153.32.camel@cotte.boeblingen.de.ibm.com> <20050524093029.GA4390@in.ibm.com>
In-Reply-To: <20050524093029.GA4390@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:

> OK, though this leaves filemap.c alone which is good, I have to admit
>
>that this entire duplication of read/write routines really worries me.
>
>There has to be a third way.
>  
>
Just thinking loud here:
When looking at patch v2, the read split is done in do_generic_mapping_read
vs do_xip_mapping read. In the write path, the split is at
generic_file_xip_write,
generic_file_buffered_write and generic_file_direct_write.
How about abstracting on that interface? Like make those become address
space operations. This way, the filesystems could select the corresponding
function. No need to distinguish between xip, direct_IO, and classic
readpage/writepage in the generic code anymore.
Would this go in the direction you're thinking Suparna? Is it worth a
try to see
how it comes out? Opinions anyone?

cheers,
Carsten

