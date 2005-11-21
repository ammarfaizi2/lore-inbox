Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVKUAw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVKUAw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 19:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVKUAw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 19:52:58 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:35753 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932151AbVKUAw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 19:52:57 -0500
Message-ID: <43811A61.70405@austin.rr.com>
Date: Sun, 20 Nov 2005 18:52:49 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Koeppe <mkoeppe@gmx.de>
CC: linux-cifs-client@lists.samba.org, samba-technical@lists.samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: support for mknod to windows now in cifs vfs
References: <437EAA7F.5050907@austin.rr.com> <Pine.LNX.4.62.0511202323230.27607@vmdebian.local.koeppe-net.de>
In-Reply-To: <Pine.LNX.4.62.0511202323230.27607@vmdebian.local.koeppe-net.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Koeppe wrote:

>
> For the mapping of the lower 9 mode bits to NT security entries, I 
> just found a good description from Corinna at 
> http://cygwin.com/cygwin-ug-net/ntsec.html#ntsec-mapping
>
> I encountered the same ACE reordering in explorer with sfu files, but 
> didn't think about these deny entries enough. At least in this regard, 
> cygwin and sfu seem to be compatible. So, Steve, this may be 
> interesting to you for implementing chmod.
>
> And it might be of interest to the samba people, if they decide to 
> implement an sfu option on the server side.
>
>
> Martin
>
Martin,
Once again thank you for finding useful data on hard problems.   I don't 
think this will be too hard to code into the cifs vfs (I also wish ntfs 
already had worker functions for setfacl and chmod similar to this...) 
but now the interesting question is how fast it is worth coding and 
getting in mainline -
1)  acl and chmod mapping (ie the ntfs security descriptor like way, 
rather than Samba-only posix acl way),  and
2) Kerberos/SPNEGO session setup

are the two most common requests for the cifs vfs these days.   The 
upcall for Kerberos support is begun but not complete, and it has taken 
longer than I had hoped partly due to lack of examples - the only uses 
of the new cn.ko (Linux "connector") posted so far are simpler 
(notification up, rather than "request up /response down").
