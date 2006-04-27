Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWD0Guw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWD0Guw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWD0Guw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:50:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35805 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964969AbWD0Guw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:50:52 -0400
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
From: Arjan van de Ven <arjan@infradead.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.58.0604270926380.20454@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain>
	 <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com>
	 <1146038324.5956.0.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI>
	 <1146040038.7016.0.camel@laptopd505.fenrus.org>
	 <20060426100559.GC29108@wohnheim.fh-wedel.de>
	 <1146046118.7016.5.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI>
	 <1146049414.7016.9.camel@laptopd505.fenrus.org>
	 <20060426110656.GD29108@wohnheim.fh-wedel.de>
	 <Pine.LNX.4.58.0604270853510.20454@sbz-30.cs.Helsinki.FI>
	 <445061DC.5030008@yahoo.com.au>
	 <Pine.LNX.4.58.0604270926380.20454@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 08:50:40 +0200
Message-Id: <1146120640.2894.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 09:28 +0300, Pekka J Enberg wrote:
> On Thu, 27 Apr 2006, Nick Piggin wrote:
> > Not to dispute your conclusions or method, but I think doing a
> > defconfig or your personal config might be more representative
> > of % size increase of text that will actually be executed. And
> > that is the expensive type of text.
> 
> True but I was under the impression that Arjan thought we'd get text 
> savings with GCC 4.1 by making kfree() inline.

not savings in text size, I'll settle for the same size.
What we gain is less branches in the hotpath... eg a kfree that gets
optimized now has one less branch. Note that the branch predictor isn't
going to help you for these 100% cases, since the same branch "slot" is
shared between all callers; with this inline the branch predictor at
least gets to keep stats for each of the callers individually.
That is where the gain is....

