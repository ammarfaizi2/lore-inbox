Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWFTNx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWFTNx3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 09:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWFTNx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 09:53:28 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:4325 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750994AbWFTNx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 09:53:27 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Steven Whitehouse <steve@chygwyn.com>
Subject: Re: [RFC] [PATCH 1/8] inode_diet: Replace inode.u.generic_ip with inode.i_private
Date: Tue, 20 Jun 2006 15:53:23 +0200
User-Agent: KMail/1.9.1
Cc: Theodore Tso <tytso@thunk.org>, linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <200606201345.45332.arnd.bergmann@de.ibm.com> <1150806849.3856.1370.camel@quoit.chygwyn.com>
In-Reply-To: <1150806849.3856.1370.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606201553.23908.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 June 2006 14:34, Steven Whitehouse wrote:
> 
> Yes, although I'm not sure that it would be as significant as the memory
> saved by removing the pointer bearing in mind the relative numbers of
> the structures that you'd expect to see in a "normal" working system. We
> could also try and reduce this by creating a special inode cache which
> would be shared by all filesystems which did still need just struct
> inode + private pointer for example.

To take this further, you could indeed split struct inode into a smaller
struct that has all the important parts and a derived struct that has
i_private as well as other members that are used only by a minority
of file systems.

Alternatively, it might be possible to stuff i_private into the same
union as i_pipe, i_cdev and i_bdev. The rationale here being that
a file system implementing different file types already is complex
enough that you would normally want your own alloc_inode for a
derived struct. The simple file systems OTOH normally only support
regular files, and sometimes directories.

	Arnd <><
