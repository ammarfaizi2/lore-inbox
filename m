Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269526AbUHZU7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269526AbUHZU7F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269636AbUHZU41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:56:27 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:50863 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267770AbUHZUtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:49:09 -0400
Date: Thu, 26 Aug 2004 13:44:06 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>
cc: Diego Calleja <diegocg@teleline.es>, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <45010000.1093553046@flay>
In-Reply-To: <Pine.LNX.4.58.0408261101110.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408261101110.2304@ppc970.osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, August 26, 2004 11:15:19 -0700 Linus Torvalds <torvalds@osdl.org> wrote:
> On Thu, 26 Aug 2004, Rik van Riel wrote:
>> 
>> It's a relief to know that nobody's taking my humorous
>> suggestion seriously, but now we still have the "standard
>> Unix tools can't manipulate files" problem...
> 
> I disagree. They can manipulate the files a whole lot better than they can 
> manipulate xattr's.
> 
> For example, you _could_ probably (but hey, maybe "tar" tries to strip
> slashes off the end of filenames, so this might not work due to silly
> reasons like that) back up a compound file with
> 
> 	tar cvf file.tar file file/
> 
> although unpacking it would require that tar be taught about the thing. 
> And you definitely could write a script to do the thing, ie even with an 
> unmodified tar you could do
> 
> 	tar cvf file-archive.tar file
> 	cd file
> 	tar cvf ../attribute-archive.tar .
> 
> which is a hell of a lot better than what you can do with the fsattr 
> interfaces and unmodified legacy applications.
> 
> So one of the advantages of "dir-as-file/file-as-dir" is exactly that you
> _can_ manipulate the data with legacy tools. Sure, things that traverse a
> directory tree might need some (likely fairly trivial) modifications if
> they really want to take advantage of the subfiles, but that's still
> likely to be _much_ less of an issue than with fsattr's that have a 
> totally different model entirely.

What would "test -d" and "test -f" return on these magic beasties? I can't
think of any combinations that wouldn't confuse the crap out of userspace.

M.

