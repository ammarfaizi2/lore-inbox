Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWBVWEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWBVWEn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWBVWEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:04:42 -0500
Received: from mail.fieldses.org ([66.93.2.214]:60622 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751468AbWBVWEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:04:41 -0500
Date: Wed, 22 Feb 2006 17:04:35 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, Oleg Drokin <green@linuxhacker.ru>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: FMODE_EXEC or alike?
Message-ID: <20060222220435.GJ28219@fieldses.org>
References: <20060220221948.GC5733@linuxhacker.ru> <20060220215122.7aa8bbe5.akpm@osdl.org> <1140530396.7864.63.camel@lade.trondhjem.org> <20060221232607.GS22042@fieldses.org> <1140564751.8088.35.camel@lade.trondhjem.org> <20060222195721.GC28219@fieldses.org> <1140644216.7879.7.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140644216.7879.7.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.11+cvs20060126
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 04:36:56PM -0500, Trond Myklebust wrote:
> On Wed, 2006-02-22 at 14:57 -0500, J. Bruce Fields wrote:
> > On Tue, Feb 21, 2006 at 06:32:31PM -0500, Trond Myklebust wrote:
> > > Hmm... I don't think you want to overload write deny bits onto
> > > FMODE_EXEC. FMODE_EXEC is basically, a read-only mode, so it
> > > would mean that you could no longer do something like
> > > 
> > >   OPEN(READ|WRITE,DENY_WRITE) 
> > > 
> > > which I would assume is one of the more frequent Windoze open modes.
> > 
> > Since exec will never use the above combination, I don't think the
> > current proposal mandates any particular semantics in that case.
> > 
> > So I'm assuming that we could choose the semantics to fit nfsd's
> > purposes.  Am I missing anything?
> 
> Yes. I'm saying that your mapping of the  NFSv4 DENY_WRITE share mode
> into FMODE_EXEC will _only_ work for the specific combination
> OPEN(READ,DENY_WRITE).

I understand that if FMODE_WRITE|FMODE_EXEC opens must fail, then
FMODE_EXEC is a poor fit for DENY_WRITE.

What I don't understand is the source of the requirement that
FMODE_WRITE|FMODE_EXEC opens be disallowed.

The only users of FMODE_EXEC introduced by Oleg's patch use a hardcoded
FMODE_READ|FMODE_EXEC, so it doesn't seem to impose any constraints on
the meaning of FMODE_WRITE|FMODE_EXEC.

--b.
