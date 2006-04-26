Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWDZLDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWDZLDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 07:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWDZLDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 07:03:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12686 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932387AbWDZLDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 07:03:40 -0400
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
From: Arjan van de Ven <arjan@infradead.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain>
	 <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com>
	 <1146038324.5956.0.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI>
	 <1146040038.7016.0.camel@laptopd505.fenrus.org>
	 <20060426100559.GC29108@wohnheim.fh-wedel.de>
	 <1146046118.7016.5.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Apr 2006 13:03:34 +0200
Message-Id: <1146049414.7016.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 13:57 +0300, Pekka J Enberg wrote:
> On Wed, 26 April 2006 10:27:18 +0200, Arjan van de Ven wrote:
> > > > what I would like is kfree to become an inline wrapper that does the
> > > > null check inline, that way gcc can optimize it out (and it will in 4.1
> > > > with the VRP pass) if gcc can prove it's not NULL.
> 
> On Wed, 2006-04-26 at 12:05 +0200, Jörn Engel wrote:
> > > How well can gcc optimize this case? 
> 
> On Wed, 26 Apr 2006, Arjan van de Ven wrote:
> > if you deref'd the pointer it'll optimize it away (assuming a new enough
> > gcc, like 4.1)
> 
> Here are the numbers for allyesconfig on my setup.
> 
> 				Pekka
> 
> gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)


this is an ancient gcc without VRP so yeah the growth is expected ;)

