Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWCGHYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWCGHYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 02:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWCGHYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 02:24:33 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:44763 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932435AbWCGHYc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 02:24:32 -0500
Date: Tue, 7 Mar 2006 09:24:30 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Phillip Susi <psusi@cfl.rr.com>
cc: linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] udf: fix uid/gid options and add uid/gid=ignore and
 forget options
In-Reply-To: <440CFCA6.5090100@cfl.rr.com>
Message-ID: <Pine.LNX.4.58.0603070920360.15092@sbz-30.cs.Helsinki.FI>
References: <4409EB37.5050308@cfl.rr.com> <84144f020603051122k33872fa7p1e7baebcc2b67cda@mail.gmail.com>
 <440B8C16.4050008@cfl.rr.com> <Pine.LNX.4.58.0603060924450.11070@sbz-30.cs.Helsinki.FI>
 <440CFCA6.5090100@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2006, Phillip Susi wrote:
> > >        inode->i_uid = le32_to_cpu(fe->uid);
> > > -      if ( inode->i_uid == -1 ) inode->i_uid =
> > > UDF_SB(inode->i_sb)->s_uid;
> > > +      if ( inode->i_uid == -1 || UDF_QUERY_FLAG(inode->i_sb,
> > > UDF_FLAG_UID_IGNORE) )
> > > +        inode->i_uid = UDF_SB(inode->i_sb)->s_uid;
> > 
> > Formatting.
> 
> What exactly do you mean by formatting?

Looks like you're using two spaces. Indentation is one tab and one tab is 
exactly eight characters (see Documentation/CodingStyle).

On Mon, 6 Mar 2006, Phillip Susi wrote:
> Yes, if you chown a file that is owned by -1 on disk, you do want it to be
> saved back with the new id, unless you set the forget option.

Okay, fair enough. I see akpm has taken your patch. Please make sure the 
mount options are documented. Thanks!

(Please note that we didn't fix the unconditional memset now, so there's 
 dead code in udf_update_inode(). The check for TAG_IDENT_USE will always 
 fail.)

			Pekka
