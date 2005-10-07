Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030520AbVJGRW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbVJGRW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030519AbVJGRW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:22:27 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:8976 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1030517AbVJGRW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:22:26 -0400
To: trond.myklebust@fys.uio.no
CC: miklos@szeredi.hu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <1128700892.8583.46.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Fri, 07 Oct 2005 12:01:32 -0400)
Subject: Re: [RFC] atomic create+open
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
	 <1128620528.16534.26.camel@lade.trondhjem.org>
	 <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
	 <1128623899.31797.14.camel@lade.trondhjem.org>
	 <E1ENani-0003c4-00@dorka.pomaz.szeredi.hu>
	 <1128626258.31797.34.camel@lade.trondhjem.org>
	 <E1ENcAr-0003jz-00@dorka.pomaz.szeredi.hu>
	 <1128633138.31797.52.camel@lade.trondhjem.org>
	 <E1ENlI2-0004Gt-00@dorka.pomaz.szeredi.hu>
	 <1128692289.8519.75.camel@lade.trondhjem.org>
	 <E1ENslH-00057W-00@dorka.pomaz.szeredi.hu>
	 <1128696477.8583.17.camel@lade.trondhjem.org>
	 <E1ENtzt-0005Jb-00@dorka.pomaz.szeredi.hu> <1128700892.8583.46.camel@lade.trondhjem.org>
Message-Id: <E1ENvth-0005UC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 07 Oct 2005 19:20:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As I believe I said earlier, open by inode number/filehandle/... don't
> exist in the NFSv4 protocol due to the potential for races.

I must have missed this.

Yes, open(O_CREAT) has race problems.  Plain open() doesn't.  So I
still don't see why you want to use the open-by-name for the
non-create case.

> No. There is no race for setattr() etc since they only do one lookup
> (and they don't set up any state on the server).
> 
> open() is the only case where we currently have to look things up twice
> (and I remind you that the second "lookup" is in fact the OPEN
> operation).

If NFS cannot do open by filehandle, then ->open_create() interface is
not enough obviously.

Miklos


