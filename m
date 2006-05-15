Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751618AbWEOQSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbWEOQSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 12:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWEOQSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 12:18:52 -0400
Received: from secure.htb.at ([195.69.104.11]:1029 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S1751604AbWEOQSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 12:18:52 -0400
Date: Mon, 15 May 2006 18:18:41 +0200
From: Richard Mittendorfer <delist@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "Xin Zhao" <uszhaoxin@gmail.com>
Subject: Re: NFS readdir problem
Message-Id: <20060515181841.27fc86de.delist@gmx.net>
In-Reply-To: <4ae3c140605150836i3f8d3890pa8568bf7d0431a7b@mail.gmail.com>
References: <4ae3c140605150836i3f8d3890pa8568bf7d0431a7b@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
X-Face: &0P^N,K:@}b8ykW@3d!=n}3D;*Cf{9KYT>>+gcM)XyIMRkBSDg|ur7Zen^BlzmJVr&!;7KT6\t+sHI69\fW(}.=PM+(`w_jnzZ.HbWb/KM"`795_k(&\Lje|'g\cm$4e%Zy*I)hJz-z0!}xkm@!>U0rO{>~[YZUs/=B{}R%#nZ8eBt'{,*>kTTKl_kj'vzrl5|'j5SBiFy#!Sj,p_zl;)q.lpSI\Er"]D`bZY@#+']kJW/YsqvRzi0GR!7ifpt$?]0TYcNs.*wC5OukokPm~R&mmW\q&DL@='khZEET;3ryo[0_mC^K~7,ZvHkj
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1FffmM-0002ZT-00*eUtuth7RaGE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach "Xin Zhao" <uszhaoxin@gmail.com> (Mon, 15 May 2006 11:36:53
-0400):
> Hi,

Hello,

> I use NFS to read a remote directory, which contains 56 entries. But
> after the read, "ls -al" only show 26, 31, or 51 entries in three test
> runs.
> 
> I have read the NFS  code "encode_entry" and related "nfs_readdir",
> "nfs3_proc_readdir"..., but haven't find the right place that can
> cause this problem.
> 
> Is there anyone has similar experience? Please help!

There is a note in the performance section from the NFS-HOWTO[1]. It
suggests adjusting the r- and wsize mount parameters:

_._. .._ _  .... . ._. .  __..__  _._. .._ _  .... . ._. .

Directly after mounting with a larger size, cd into the mounted file
system and do things like ls, explore the filesystem a bit to make sure
everything is as it should. If the rsize/wsize  is too large the
symptoms are very odd and not 100% obvious. A typical symptom is
incomplete file lists when doing ls, and no error messages, or reading
files failing mysteriously with no error messages. After establishing
that the given rsize/ wsize works you can do the speed tests again.
Different server platforms are likely to have different optimal sizes.
_._. .._ _  .... . ._. .  __..__  _._. .._ _  .... . ._. .

[1] http://www.tldp.org
> Thanks,
> -x

sl ritch
