Return-Path: <linux-kernel-owner+w=401wt.eu-S1751243AbXAIJtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbXAIJtu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbXAIJtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:49:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42144 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbXAIJtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:49:49 -0500
Date: Tue, 9 Jan 2007 09:46:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mimi Zohar <zohar@us.ibm.com>, Christoph Hellwig <hch@infradead.org>,
       akpm@osdl.org, kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@watson.ibm.com
Subject: Re: mprotect abuse in slim
Message-ID: <20070109094625.GA11918@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Mimi Zohar <zohar@us.ibm.com>, akpm@osdl.org,
	kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	safford@watson.ibm.com
References: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com> <1168312045.3180.140.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168312045.3180.140.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 07:07:25PM -0800, Arjan van de Ven wrote:
> 
> > Starting with the fdtable, would it help if we move the 
> > fdtable tweaking out of slim itself and into helpers?  Or
> > can you recommend another way to implement this functionality.
> 
> Hi,
> 
> maybe this is a silly question, but do you revoke not only the current
> fd entries, but also the ones that are pending in UNIX domain sockets
> and that are already being sent to the process? If not.. then you might
> as well not bother ;)

Exactly.  What these folks want is revoke (maybe more fine grained, but
that's not the point).  And guess what folks, revoke is not trivial,
otherwise we'd have it.  If you want to volunteer to implement a full-blown
revoke that's fine, but

  a) it belongs into core code
  b) needs to be done right

