Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVAUQWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVAUQWc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbVAUQWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:22:32 -0500
Received: from shinjuku.bdi.com ([63.124.198.36]:50353 "EHLO shinjuku.bdi.com")
	by vger.kernel.org with ESMTP id S262413AbVAUQWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:22:21 -0500
Message-ID: <41F12C75.5040007@bdi.com>
Date: Fri, 21 Jan 2005 11:23:17 -0500
From: "Aaron D. Ball" <adb@bdi.com>
Organization: Boston Dynamics
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Vladimir Saveliev <vs@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: knfsd and append-only attribute:  "operation not permitted"
References: <8381054C-6B13-11D9-BFA6-000D933B35AA@bdi.com>	 <1106318654.3200.38.camel@tribesman.namesys.com> <1106322787.30627.5.camel@lade.trondhjem.org>
In-Reply-To: <1106322787.30627.5.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Known-Correspondent: 65.194.110.56 is a relay host (learned as non-spam)
X-Virus-Scan: clamd says this checks out OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>fr den 21.01.2005 Klokka 17:44 (+0300) skreiv Vladimir Saveliev:
>  
>
>> fs/nfsd/vfs.c:nfsd_open() refuses to open append only files.
>
>
>Append-only is an unsupported concept in the all existing revisions of
>the NFS protocol. In fact, NFS has no support for append writes at all:
>they have to be emulated by the clients.
>  
>
OK, but that certainly shouldn't preclude read access.  The way it is 
now, you can't even list append-only directories.  It seems like this 
check should treat append-only files as read-only, only failing to open 
them if write access is requested, rather than failing all the time like 
it does now.

In this particular case, I'm not using append-only files, but rather 
using immutable files and append-only directories to create an archival 
space where things can be added but not changed.  Even if the protocol 
can't deal with append-only regular files, isn't it possible to allow 
mkdir but not rmdir?

