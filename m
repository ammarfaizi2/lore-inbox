Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268253AbUIFQPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268253AbUIFQPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 12:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268258AbUIFQPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 12:15:21 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:40172 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268253AbUIFQPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 12:15:02 -0400
Date: Mon, 6 Sep 2004 18:14:50 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <263863366.20040906181450@tnonline.net>
To: Christer Weinigel <christer@weinigel.se>
CC: Pavel Machek <pavel@suse.cz>, Tonnerre <tonnerre@thundrix.ch>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <m3sm9vh06b.fsf@zoo.weinigel.se>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
 <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
 <m3eklm9ain.fsf@zoo.weinigel.se> <20040905111743.GC26560@thundrix.ch>
 <1215700165.20040905135749@tnonline.net> <20040905115854.GH26560@thundrix.ch>
 <1819110960.20040905143012@tnonline.net>
 <20040906105018.GB28111@atrey.karlin.mff.cuni.cz>
 <6010544610.20040906143222@tnonline.net> <m3wtz7h2l6.fsf@zoo.weinigel.se>
 <826067315.20040906171320@tnonline.net> <m3sm9vh06b.fsf@zoo.weinigel.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>   Plugins were just another thing that could extend the functionality
>>   of these streams and meta data. Reiser4 has a plugin architecture,
>>   although not yet any run-time support for loading them. Is this so
>>   bad that we have to prevent it?

> Take an example: "expose a tar-file as streams below the file" which
> as been suggested here is IMNSHO plain silly.  I'm not saying anything
> about mounting a tar file via userfs somewhere else in the file
> system, that is quite ok, but trying to mount it on top of the same
> file which suddenly and automagically turns into a sort-of-directory
> breaks too many thing.  Let your file manager do the choice instead,
> based on the users preferences.  For example, with a tar.gz-file, I'd
> like to have a choice of "open file as a seekable file" which would
> do:

>     mount -t userfs -o driver=gunzip foo.tar.gz /tmp/xyzzy

 Where is the difference? Both would be handled by a specific driver
 or module and export the same semantics (files+dirs) with permissions
 etc to the user. With your idea you still would need the userfs
 kernel module, and with "magic plugins", as you said, you will need a
 vfs/reiser4 kernel plugin.

> Then I can work with /tmp/xyzzy as a normal file (maybe even with
> write access if the userfs driver can handle this).  Another choice in
> the same file manager would be "open file as a directory" which would
> mount the same file in _another place_ as a directory, and I can even
> have different views of the same file mounted at the same time.  With
> the named streams junk that have been suggested here, having two
> different views would be impossible.

> Sure, we could say that we add another level of indirection to the
> named streams, so that we specify the driver as the first component of
> te magic file-as-directory, i.e. foo.tar.gz/ungzipped would refer to
> the ungzipped stream and foo.tar.gz/ungzipped-and-untarred would show
> the tar file as a directory, but really, this isn't any more useful
> than doing a userfs mount.  The userfs mount does not break existing
> semantics (anymore than mount -o loop does today), and it will work
> with the existing infrastructure in the linux kernel.  The only
> advantage of files-as-directories with magic plugins in the kernel is
> that one can look at it and say "look, how neat, the filenames look
> almost the same".

  No there are _usability_ differences. I cirtanly do not want to
  mount lots of files with mount -t userfs, just to see extra
  meta-data that I want to quickly be able to use. And it also
  wouldn't work generically (searchable) with tools like find, grep,
  etc either.

  ~S

>   /Christer


