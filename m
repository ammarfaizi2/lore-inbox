Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268294AbUH2T6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbUH2T6j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 15:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268292AbUH2T6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 15:58:39 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:39316 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268295AbUH2T6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 15:58:32 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <41323436.80007@namesys.com>
Date: Sun, 29 Aug 2004 12:53:26 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Spam <spam@tnonline.net>, Jamie Lokier <jamie@shareable.org>,
       David Masover <ninja@slaphack.com>, Diego Calleja <diegocg@teleline.es>,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org> <4131074D.7050209@namesys.com> <Pine.LNX.4.58.0408282159510.2295@ppc970.osdl.org> <4131A3B2.30203@namesys.com> <Pine.LNX.4.58.0408291055140.2295@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408291055140.2295@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Sun, 29 Aug 2004, Hans Reiser wrote:
>  
>
>>>Realize that openat() works independently of any special streams, it's
>>>fundamentally a "look up name starting from this file" (rather than
>>>"starting from root" or "starting from cwd").
>>>      
>>>
>>well, isn't that namespace fragmentation by definition?
>>    
>>
>
>No.
>
>There's no difference between
>
>	fd = open("/usr/bin/yes", O_RDWR);
>
>and
>
>	dirfd = open("/usr/bin", O_RDONLY | O_DIRECTORY);
>	fd = openat(dirfd, "yes", O_RDWR);
>  
>
The difference is that cat uses open() not openat().

With your model, can I do:

cat filenameA/metas/permissions > filenameB/metas/permissions

find / -exec cat {}/permissions \; | grep 4777 | wc -l

If yes, then we are talking past each other somehow rather than 
disagreeing. If metafiles can be opened with both open and openat() in 
your model, then we are discussing some small detail.

I think the answer is no though, in which case you are missing the point 
of the new design. Is the answer no?

