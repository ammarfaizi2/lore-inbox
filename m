Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUBWLgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 06:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUBWLgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 06:36:22 -0500
Received: from smtp3.att.ne.jp ([165.76.15.139]:32176 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S261914AbUBWLgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 06:36:16 -0500
Message-ID: <015e01c3fa01$346bb0d0$34ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Date: Mon, 23 Feb 2004 20:35:06 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> First it is worth noting that the existing practice is that ttys
> always use the character set encoding of the user.

Each tty uses the character set encoding of that tty's user.  There were
times when I needed to have some tty windows open using EUC (ordinary work
on that Linux machine) and some tty windows open using SJIS (editing files
which would be sent to cellular telephones), in the same X session.  They
worked.

> Even X cut and paste frequently abuses the iso8859-1 range,

I'll take your word for it.  I've copied and pasted EUC strings, I've copied
and pasted SJIS strings, I don't know if X copy and paste abused EUC or SJIS
ranges, but it worked.

One thing I never thought of trying to test is to copy and paste between one
tty using EUC and one tty using SJIS.

> Now the work is how to get multiple locales to play nicely with each
> other.  utf-8 and unicode are convenient for that as they preserve the
> existing assumptions that terminals, filenames, and text files are
> all using the same character set encoding, even when multiple locales
> are involved.
>
> So within one machine utf-8 solves the multiple locale problem.

That preserves a nice fiction.  If you depend on assuming that fiction,
you'll get useless results.

> The rule ``All data that passing through a pseudo-tty is in the
> character set encoding specified by the locale of the owner of the
> tty'' seems both reasonable and no significant change from the current
> status quo.

Yes, that is a return to usability.

> On the wire between two machines I recommend passing unicode
> characters.

Why should the wire get a different encoding than the user set in the
pseudo-tty?  Consider TeraTerm.  The user tells TeraTerm what character set
is in use on the wire, which is the same as the character set in use on the
remote side (where sshd or whatever server provides the pseudo-tty).
TeraTerm converts between that and the local character set (where the
TeraTerm program and window and user get the character set decided for them
by someone in Sasazuka or Redmond).

> By convention glibc stores unicode values in wchar_t.

That is hard to believe.  glibc existed before Unicode did and wchar_t
existed before Unicode did.  I sure thought that glibc existed in Japan at
the time, but I could be wrong, I didn't say this is impossible but merely
hard to believe.  In commercial Unix systems, wchar_t held either EUC or
SJIS depending on the vendor.

As usual I do not even have time to keep up with this thread, so if you have
questions then please CC me personally, though I don't know if I'll have
time to investigate anything that needs it.

