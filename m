Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWCTNNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWCTNNr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWCTNNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:13:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45959 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932175AbWCTNNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:13:46 -0500
Subject: Re: DoS with POSIX file locks?
From: Arjan van de Ven <arjan@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: matthew@wil.cx, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu>
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu>
	 <20060320121107.GE8980@parisc-linux.org>
	 <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu>
	 <20060320123950.GF8980@parisc-linux.org>
	 <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 14:13:43 +0100
Message-Id: <1142860423.3114.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 13:52 +0100, Miklos Szeredi wrote:
> > Right.  Um.  I took it out back in March 2003 after enough people
> > convinced me it wasn't worth trying to account for all the memory
> > processes use, and the userbeans project would take care of it anyway.
> > Haha.
> > 
> > It's hard to fix the accounting.  You have to deal with one thread
> > allocating the lock, and then a different thread freeing it.  We never
> > actually accounted for posix locks (which are the ones we really needed
> > to!) and on occasion had current->locks go negative, with all kinds of
> > associated badness.
> 
> Things look fairly straightforward if the accounting is done in
> files_struct instead of task_struct. 

that's the wrong place; you can send fd's over unix sockets to other
processes....



the better solution is to account per user struct, and keep a pointer
(and a refcount) of that user struct inside your lock data somehow.


