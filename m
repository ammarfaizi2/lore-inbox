Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269197AbUHaUwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269197AbUHaUwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269171AbUHaUfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:35:40 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:35791 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S269076AbUHaU3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:29:44 -0400
Date: Tue, 31 Aug 2004 22:29:31 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1508726027.20040831222931@tnonline.net>
To: Linus Torvalds <torvalds@osdl.org>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
 <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 31 Aug 2004, Horst von Brand wrote:
>> 
>> You do need extra tools anyway, placing them in the kernel is cheating (and
>> absolutely pointless, IMHO).

> I agree.

> There's no point to having the kernel export information that is already
> inherent in the main stream.

  There are two things you are saying in the same sentence here. One I
  do  not  agree  with.  There is point to export information from the
  main  stream  to  secondary file streams. Just it doesn't have to be
  done by the kernel.

  Just  do  not limit things to a few defined types of things that can
  be  stored in a stream. IMHO a file stream should be able to contain
  just  about  anything  the user wishes. That said, the kernel should
  not have to know about the contents.

> I've seen all these examples of exposing MP3 ID information as a "side
> stream", and that's TOTALLY POINTLESS! The information is already there,
> it's in a standard format, and exporting it as a stream buys you 
> absolutely nothing.

  True.  But this is the case for this specific example. I have stated
  previously  about what I think would be legitimate uses as examples.
  Of  course  these  apply  to  me  and  what  I work with. One of the
  examples   were  to  add  streams  that  contained  descriptions  or
  keywords.

> Where named attributes make sense is when they are _independent_ data.
> Data that is only tangentially related to the main stream itself, and
> which the main stream _cannot_ encompass because of some real technical
> issue.

> In a graphical environment, the "icon" stream is a good example of this.
> It literally has _nothing_ to do with the data in the main stream. The
> only linkage is a totally non-technical one, where the user wanted to
> associate a secondary stream with the main stream _without_ altering the
> main one. THAT is where named streams make sense.

> But if you want to look at one particular file inside a tar-file, do so in
> user space. There are zero advantages to exposing it as a side-stream, and
> there are absolutely _tons_ of disadvantages.

  The  tar archive support seem (is) to be useless because tar is also
  so supported and implemented in every type of application out there.
  It is also easy to script and otherwise work with.

  But  the  idea to be able to extend the filesystem to show/represent
  data  as  file streams and meta directores is very good.

  Someone might come up with an idea to allow browsing and changing of
  data  inside  XML files. Of course this may already be done with sed
  and other tools.

> In short, named streams only make sense if:
>  - they are tied to the file some way that is _independent_ of the file
>    contents (since if it's dependent on the file contents, you're just a
>    ton better off regenerating it with a caching server)
>  - there are serious reasons to keep the lookup synchronized (since if
>    there isn't such a reason, you're just better off with a separate
>    shadow tree in user space)

> And realize that the "separate shadow tree" actually works very well.
> That's how version control systems like CVS have always worked. It's
> certainly how you can make icon information work too. If you use a tool
> for accessing the data, the tool can maintain coherency and you'll never
> care about the side stream.

  Just  that  with  shadow  trees  (I assume they are stored simply in
  another  folder  beside  the  file)  you  won't be able to "cp filea
  /mnt/backup" and keep the extra stuff.

  Sure  icons  could  also easily be stores as file.icon, just like on
  the Amiga :). It just isn't as nice.

> Which means that normally we really don't _want_ named streams. In 99% of
> all cases we can use equally good - and _much_ simpler - tool-based
> solutions.

> Which means that the only _real_ technical issue for supporting named
> streams really ends up being things like samba, which want named streams
> just because the work they do fundamentally is about them, for externally
> dictated reasons. Doing named streams for any other reason is likely just
> being stupid.

  I  doubt  it would be stupid. Perhaps today just not needed for many
  things.

> Once you do decide that you have to do named streams, you might then
> decide to use them for convenient things like icons. But it should very
> much be a secondary issue at that point.

  I think we focus to much on the actual contents of these streams. Do
  we  really  have  to  know  what will in the future be stored inside
  these streams?

  For  example.  Applications may use file streams for locking instead
  of having a .lock file. The future isn't known, and we shouldn't try
  to  limit  what  we can put in the streams. You said 99% of the uses
  won't  need  them.  True.  The  same is with xattr, ACLs and so many
  other things.

  Even  if 0.1% of the users today would use it I think we should have
  the support for named streams.

  ~S

>     Linus

