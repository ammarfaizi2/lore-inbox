Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268771AbUIGXrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268771AbUIGXrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 19:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268775AbUIGXrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 19:47:15 -0400
Received: from mx02.qsc.de ([213.148.130.14]:51623 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S268771AbUIGXrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 19:47:05 -0400
Date: Wed, 08 Sep 2004 01:45:58 +0200
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: Christer Weinigel <christer@weinigel.se>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Tonnerre <tonnerre@thundrix.ch>,
       Spam <spam@tnonline.net>, ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, Jamie Lokier <jamie@shareable.org>,
       Christoph Hellwig <hch@lst.de>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Chris Wedgwood <cw@f00f.org>, Christer Weinigel <christer@weinigel.se>
Subject: Re: silent semantic changes with reiser4
Message-ID: <413E4836.nailFFM11WGWE@pluto.uni-freiburg.de>
References: <200409070206.i8726vrG006493@localhost.localdomain>
 <413D4C18.6090501@slaphack.com> <m3d60yjnt7.fsf@zoo.weinigel.se>
 <1183150024.20040907143346@tnonline.net>
 <413DD5B4.nailC801GI4E2@pluto.uni-freiburg.de>
 <m34qm9kbcl.fsf@zoo.weinigel.se>
 <413E3280.nailEK92X8CU7@pluto.uni-freiburg.de>
 <m3n001its8.fsf@zoo.weinigel.se>
In-Reply-To: <m3n001its8.fsf@zoo.weinigel.se>
User-Agent: nail 11.7pre 9/8/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel <christer@weinigel.se> wrote:

> Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de> writes:
> > Excuse me, but there's really nothing broken here with POSIX and cp.
> > You're just making an insulting talk about a part of the specification
> > which currently serves GNU/Linux and other Unix-like environments very
> > well, and has done so for about twelve years now.
> "Broken" in the sense "POSIX mandates something that users wouldn't
> expect".

Only if one breaks it by making extensions in an inappropriate way.
This is not a fault of POSIX. POSIX usually allows a lot of sane ways
to introduce extensions. There are usually valid interoperability
arguments for behavior prescribed by POSIX. It is really not one of
those standards where you want to ignore every second word because
it is obviously nothing but committee nonsense.

> > > or the environment variale POSIXLY_CORRECT is set.
> > Cool, data loss depending upon an environment variable which is even
> > currently used by many programs unaware of such results. This really
> > sounds like good engineering to me.
> How would you consider cp to cause "data loss" if it _besides_ copying
> the normal stream _also_ copied any named streams or xattrs belonging
> to the stream?

You are reversing the argument. If additional streams are introduced
inappropriately by extending the semantics of S_IFREG files, POSIX
requires cp to lose the data. Your proposal would then make this loss
of additional stream data dependent on an environment variable that
is already in wide use. If it was set by accident, the data would be
lost.

Besides, copying xattrs is usually permitted (POSIX.1-2004, XCU cp):

# If the implementation provides additional or alternate access control
# mechanisms (see the Base Definitions volume of IEEE Std 1003.1-2001,
# Section 4.4, File Access Permissions), their effect on copies of files
# is implementation-defined.

It is also permitted to add other S_IFXXX types and then let cp act
in an implementation-defined manner on them (cf. my earlier message
<413E40D1.nailFBI11XFML@pluto.uni-freiburg.de>).

The 'standardized' data loss would only occur if the standardized type
of regular file, S_IFREG, was abused. This would really not be a fault
of POSIX.

> Lots of GNU utilities already differ from POSIX mandated behaviour
> because the authors of those utilities belive that the POSIX mandated
> behaviour is confusing.

Sure, but it is not the preferred method of adding features. In
addition, most of the existing POSIXLY_CORRECT influences are
nothing but cosmetical details in comparison to copying/not
copying stream data.

	Gunnar
