Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268056AbUIGNwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268056AbUIGNwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 09:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268067AbUIGNwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 09:52:50 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:53641 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268056AbUIGNwn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 09:52:43 -0400
Date: Tue, 7 Sep 2004 15:52:25 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <16310505631.20040907155225@tnonline.net>
To: Christer Weinigel <christer@weinigel.se>
CC: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Tonnerre <tonnerre@thundrix.ch>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <m38ybmjiyz.fsf@zoo.weinigel.se>
References: <200409070206.i8726vrG006493@localhost.localdomain>
 <413D4C18.6090501@slaphack.com> <m3d60yjnt7.fsf@zoo.weinigel.se>
 <1183150024.20040907143346@tnonline.net> <m38ybmjiyz.fsf@zoo.weinigel.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Spam <spam@tnonline.net> writes:

>> > Additionally, files-as-directores does not solve the problem of 
>> > "cp a b" losing named streams.  There is curently no copyfile syscall
>> > in the Linux kernel, "cp a b" essentially does "cat a >b".  So unless
>> > cp is modified we don't gain anything.  If cp is modified to know
>> > about named streams, it really does not matter if named streams are
>> > accessed as file-as-directories, via openat(3) or via a shared library
>> > with some other interface.
>> 
>>   One suggestion is missed. It is to provide system calls for copy.
>>   That would also solve the problem. Named streams and metas would
>>   then be handled correctly. It also allows further changes to
>>   filesystems without having to patch applications yet again.

> But this still solves only part of the problem.  A backup application
> won't have any use for a copyfile syscall, it will need to be taught
> about streams.

  Yes, but backup programs always needed to be taught about new
  features. Be it new type of files, attributes or meta-data. I think
  that teaching backup applications is far better than teaching every
  application.

>>   A copy system call would also be large beneficial for networked
>>   filesystems (NFS, Samba, etc) as data wouldn't have to be
>>   transferred over the network and back.

> Definitely.  

>>   Can we make a plugin infrastructure that will let user-space plugins
>>   to be loaded for certain directories or files? If we can, then it
>>   would present a much cleaner and easier way for the user to access
>>   data he wants. In this particular example it was a tar file.

> In that case I'd argue that:

>     mount -t userfs -o driver=tarfs foo /tmp/foo

> is a rather good kernel interface for plugins.  userfs (or something
> based on userfs) is the plugin API and tarfs is a plugin. :-)

> To make this efficient, well have to allow non-root users to perform
> the mount syscall (with the limitation that they can only mount on top
> of directories they own and that the mounts have the nosuid and nodev
> flags set).

  Yes, this seem to be one solution. It isn't very dynamic in usage
  though. You can't use this directly from applications wihout
  manually doing the mount.

  This is only a solution to browsing contents of files. It doesn't
  provide a solution for using meta-data streams or other things like
  this.

  ~S

>   /Christer


