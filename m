Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVFRXXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVFRXXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 19:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVFRXXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 19:23:10 -0400
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:20417 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S262204AbVFRXXA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 19:23:00 -0400
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <f192987705061303383f77c10c@mail.gmail.com>
	<yw1xslzl8g1q.fsf@ford.inprovide.com> <42AFE624.4020403@poczta.fm>
	<200506150454.11532.pmcfarland@downeast.net>
	<42AFF184.2030209@poczta.fm> <yw1xd5qo2bzd.fsf@ford.inprovide.com>
	<42B04090.7050703@poczta.fm>
	<20050615212825.GS23621@csclub.uwaterloo.ca> <42B0BAF5.106@poczta.fm>
	<yw1xll5a1vyd.fsf@ford.inprovide.com> <42B43424.6090708@poczta.fm>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Sun, 19 Jun 2005 01:22:56 +0200
In-Reply-To: <42B43424.6090708@poczta.fm> (Lukasz Stelmach's message of
 "Sat, 18 Jun 2005 16:48:04 +0200")
Message-ID: <yw1xekazs10v.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Stelmach <stlman@poczta.fm> writes:

> Måns Rullgård napisał(a):
>>>>What do you do if the underlying filesystem can not store some unicode
>>>>characters that are allowed on others?
>>>
>>>That's why UTF-8 is suggested. UTF-8 has been developed to "fool" the
>>>software that need not to be aware of unicodeness of the text it manages
>>>to handle it without any hickups *and* to store in the text information
>>>about multibyte characters.What characters exactly you do mean? NULL?
>>>There is no NULL byte in any UTF-8 string except the one which
>>>terminates it.
>> 
>> That's exactly how ext3, reiserfs, xfs, jfs, etc. all work.  A few
>> filesystems are tagged as using some specific encoding.  If your
>> filesystem is marked for iso-8859-1, what should a kernel with a
>> conversion mechanism do if a user tries to name a file 김?
>
> Return -ENOENT? I am guessing.

Doesn't seem very friendly.

> But please tell me what should do userland software if it runs with
> locale set to something.iso-8859-2 and finds 김 in the directory?

I suppose it will display ęš (0x80 doesn't seem be a printable
iso-8859-2 character).  You told it to use iso-8859-2 in the first
place, so what do you expect?

> That is the same problem. And for now ISO 8-bit encodings are far
> more popolar and usefull with contemporary tools than UTF-8.

ISO 8-bit encodings are more common with characters they can
represent.  These are a small minority of all characters commonly
used.

> That is why I think suggestion of a layer in the kernel that would
> translate filenames form utf-8 stored on the media to e.g. latin2
> used by tools is quite reasonable. Especially when there is more
> than one encoding for a particular language (think Russian,
> Polish). Even more, with such a facility transition would be much
> more greaceful since you could have utf-8 filesystem and then you
> can worry about tools other tools. The filesystem is already
> populated with UFT-8 names.

How is the kernel to know what to translate to/from?

>>>>I think UDF is a better filesystem for many types of media since it is
>>>>able to me more gently to the sectors storing the meta data than VFAT
>>>>ever will be.
>>>I've tried cd packet writing with UDF and it gives insane overhead of
>>>about 20%. What metadata you'd like to store for example on your
>>>flashdrive or a floppy disk?
>> 
>> Filename, timestamps, all the usual.
>
> That's why IMHO FAT is quite enough for this purpose.

FAT has a bad habit of constantly hammering the same sectors over and
over.  This can wear out cheap flash media in no time at all.

-- 
Måns Rullgård
mru@inprovide.com
