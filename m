Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbVHSTP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbVHSTP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 15:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbVHSTP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 15:15:57 -0400
Received: from mail-gw2.turkuamk.fi ([195.148.208.126]:45187 "EHLO
	mail-gw2.turkuamk.fi") by vger.kernel.org with ESMTP
	id S1030182AbVHSTP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 15:15:56 -0400
Message-ID: <4306301F.9060707@kolumbus.fi>
Date: Fri, 19 Aug 2005 22:16:47 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       vandrove@vc.cvut.cz, Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and
 mmap
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk> <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org> <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org> <20050819165332.GD29811@parcelfarce.linux.theplanet.co.uk> <20050819180218.GE29811@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050819180218.GE29811@parcelfarce.linux.theplanet.co.uk>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.13a
  |April 8, 2004) at 19.08.2005 22:15:46,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP1|June
 19, 2005) at 19.08.2005 22:16:10,
	Serialize complete at 19.08.2005 22:16:10
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>On Fri, Aug 19, 2005 at 05:53:32PM +0100, Al Viro wrote:
>  
>
>>I'm taking NFS helpers to libfs.c and switching ncpfs to them.  IMO that's
>>better than copying the damn thing and other network filesystems might have
>>the same needs eventually...
>>    
>>
>
>[something like this - completely untested]
>
>* stray_page_get_link(inode, filler) - returns ERR_PTR(error) or pointer
>to symlink body.  Said symlink body sits in a page at offset equal to
>offsetof(page, struct stray_page_link).  filler() is expected to put it
>at such offset. Page is cached.
>
>* stray_page_put_link() - ->put_link() suitable for links obtained from
>stray_page_get_link().  Unlike the usual pagecache-based variants, this
>sucker does _not_ rely on page staying cached.
>
>* nfs and ncpfs switched to the helpers above.
>
>Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
>----
>  
>

Just out of curiosity - what protects even local filesystems against 
concurrent truncate and symlink resolving when using the page cache helpers?

--Mika

