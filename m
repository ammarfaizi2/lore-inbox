Return-Path: <linux-kernel-owner+w=401wt.eu-S1030183AbXALTxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbXALTxI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 14:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbXALTxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 14:53:08 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:59438 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030183AbXALTxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 14:53:06 -0500
Date: Fri, 12 Jan 2007 21:53:03 +0200 (EET)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Mimi Zohar <zohar@us.ibm.com>,
       akpm@osdl.org, kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@watson.ibm.com
Subject: Re: mprotect abuse in slim
In-Reply-To: <20070112192812.GC10445@sergelap.austin.ibm.com>
Message-ID: <Pine.LNX.4.64.0701122149040.14304@sbz-30.cs.Helsinki.FI>
References: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com>
 <1168312045.3180.140.camel@laptopd505.fenrus.org> <20070109094625.GA11918@infradead.org>
 <20070109231449.GA4547@sergelap.austin.ibm.com>
 <84144f020701120145r13d5d7bbndf652692f729ad9d@mail.gmail.com>
 <20070112192812.GC10445@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007, Serge E. Hallyn wrote:
> Hmm, would revokefs need to be explicitly stacked on top of the fs,
> or could we just swap out fdt[fd] for the revokefs file, and have
> the revokefs file's private data point to the original inode, with
> it's write function returning an error, and read being passed through?

Swapping the fds should be sufficient.

On Fri, 12 Jan 2007, Serge E. Hallyn wrote:
> Do you (or hch) then have a problem with these functions (sitting either
> in fs/revoke.c or fs/file_table.c) calling mprotect to remove the write
> permission from the mmap'ed segment?  i.e. was the main objection to
> mprotect being called from "just anywhere"?

I haven't seen the original patches so I don't knw what hch objected to. 
It is not enough that we do mprotect, tough. We also must make sure the 
task can't do mprotect on its own nor remap the memory region.
