Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUIEQUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUIEQUW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 12:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266871AbUIEQUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 12:20:22 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:65170 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S266867AbUIEQUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 12:20:15 -0400
Message-ID: <413B3CBD.1000304@eris-associates.co.uk>
Date: Sun, 05 Sep 2004 17:20:13 +0100
From: Mike Jagdis <mjagdis@eris-associates.co.uk>
Organization: Eris Associates Ltd
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Connors <tconnors+linuxkernel1094371411@astro.swin.edu.au>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       =?ISO-8859-1?Q?Sven_K?= =?ISO-8859-1?Q?=F6hler?= 
	<skoehler@upb.de>,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: why do i get "Stale NFS file handle" for hours?
References: <chdp06$e56$1@sea.gmane.org>  <1094348385.13791.119.camel@lade.trondhjem.org>  <413A7119.2090709@upb.de>  <1094349744.13791.128.camel@lade.trondhjem.org>  <413A789C.9000501@upb.de> <1094353267.13791.156.camel@lade.trondhjem.org> <slrn-0.9.7.4-19971-22570-200409051803-tc@hexane.ssi.swin.edu.au>
In-Reply-To: <slrn-0.9.7.4-19971-22570-200409051803-tc@hexane.ssi.swin.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tim Connors wrote:
> I will update one directory with rsync from one host,

You mean rsync to the server and change files directly on the fs rather 
than through an NFS client?

> and then try, a
> little later on, to operate on that directory from another host. Every
> now and then, from a single host only, a few files in that tree will
> get stale filehandles - an ls of that directory will mostly be fine
> apart from those files. They will also be fine from any other machine.

Yeah, that's what happens... Clients that had the file open are liable 
to get ESTALE. Stale file handles stick around until unmount. As long as 
they're around automount will consider the mount busy and not expire it 
(but you can unmount manually or killall -USR1 automountd).

Mike

-- 
Mike Jagdis                        Web: http://www.eris-associates.co.uk
Eris Associates Limited            Tel: +44 7780 608 368
Reading, England                   Fax: +44 118 926 6974
