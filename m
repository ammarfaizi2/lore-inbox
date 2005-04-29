Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262930AbVD2UeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbVD2UeM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbVD2Udu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:33:50 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:34433 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262948AbVD2Uc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:32:27 -0400
Message-ID: <427299DA.3010005@austin.rr.com>
Date: Fri, 29 Apr 2005 15:32:26 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: which ioctls matter across filesystems
References: <42728964.8000501@austin.rr.com> <1114804426.12692.49.camel@lade.trondhjem.org>
In-Reply-To: <1114804426.12692.49.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>What kind of real-world applications exist out there that need inotify
>functionality, and what sort of requirements do they have (in particular
>w.r.t. the notification mechanism)?
>
>Cheers,
>  Trond
>  
>
The two cases I can think of which matter (other than the case you 
mention) are:
1) KDE File manager - autoupdate of directory listings which today calls 
D_NOTIFY (a similar feature was first done IIRC in OS/2 for support of 
the workplace shell).   Obviously this is as or more important to 
support well over the network as it is in the local fs, but the client 
implications.   I don't know whether their needs (and the equivalent in 
Gnome) map better to fcntl DNOTIFY or inotify.

2) Support of Network File Servers - The Samba example has already been 
mentioned, but it is important because it would be quite common for a 
series of Samba servers to export shares that are NFS mounted to a set 
of NFS servers (or on other platforms mounted to a cluster 
filesystem).   The CIFS network protocol has long had a notify 
mechanism, and client implementations on various operating systems use 
it, so there is pressure for Samba to support it better.   The Linux 
CIFS client can issue these calls too, but it is marked experimental and 
disabled by default as more work needs to be done to clean it up.

A loosely related issue which will matter a lot in the long run are 
figuring out a way to pass get/setlease requests as the network caching 
mechanisms would otherwise not work in three tier environments (e.g. 
SMB/CIFS client -> Samba server over NFS client mounted to -> NFS 
server, or the reverse).
