Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268085AbUIBKIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268085AbUIBKIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 06:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268067AbUIBKIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:08:00 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:466 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268085AbUIBKDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:03:12 -0400
Date: Thu, 2 Sep 2004 12:02:59 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <812032218.20040902120259@tnonline.net>
To: Oliver Hunt <oliverhunt@gmail.com>
CC: Helge Hafting <helge.hafting@hist.no>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <4699bb7b0409020245250922f9@mail.gmail.com>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain>
 <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com>
 <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
 <4136A14E.9010303@slaphack.com>
 <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
 <4136C876.5010806@namesys.com>
 <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
 <4136E0B6.4000705@namesys.com> <4699bb7b04090202121119a57b@mail.gmail.com>
 <4136E756.8020105@hist.no> <4699bb7b0409020245250922f9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

>> Depends on how the forks eventually get implemented.
>> With the file-as-directory concept, all you need is to
>> look at the file's directory part to see what is there.  (The forks,
>> implemented as files in a subdirectory.)  It is done the same way
>> as for an ordinary directory, so nothing "new".
>> 
> This still doesn't solve the problem of how we distinguish between a
> multi-fork file
> and a directory, for those old programs(ie. almost all that currently
> exist), to be able to access meaningful data we would need to either
> return just the primary fork, a serialized version of all forks in the
> file, or make the file look more or less identical to a directory.

  Well. wasn't the idea that unless programs specifically tried to
  open the file-as-dir as a directory it would look like a file?

  ls -F would show it as file. Or have I understood wrong?

> The first option could cause problems when transfering files between
> different filesystems,

  The meta-data should be deleted if it the file is copied or moved to
  a medium that doesn't support it. However a _warning_ may be shown
  to the user if there is risk to loose data.

  I do not think we should not implement something like this because
  most other filesystems in Linux doesn't support it. Think of other
  limitations there is in various ones. Large file support. Limited
  amount of files, length of file names, etc.

> the second results in programs getting metadata they can't handle, and
> the third option results in few of the advantages over, well,
> directories...  And even those applications that could handle the fork
> information nicely would need to fs type to find out whether they were
> handling a directory or a multi-forked file...

  No, if an application supported the file-as-dir then it could simply
  try to open the file as a directory. It would fail on systems that
  didn't support it.

  The meta-data and file streams would be seen as ordinary files. If
  applications support the contents or not isn't really relevant, is
  it?.

> As I say I like the idea, but I can't see anyway of implementing it in
> a way that is useful without first putting considerable effort into at
> least the VFS if not all the actual fs drivers.

  Indeed. It is important that something like this gets implemented as
  a transparent way as possible. If it could be done in a general way
  so other filesystems like ext3/4 can eventually support it then that
  would be wonderful. I do not, however, think that we should block it
  in reiser4 because no other filesystems support it.

  ~S

> --Oliver Hunt

