Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268447AbRG3Ntb>; Mon, 30 Jul 2001 09:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268600AbRG3NtV>; Mon, 30 Jul 2001 09:49:21 -0400
Received: from egghead.curl.com ([216.230.83.4]:4869 "HELO egghead.curl.com")
	by vger.kernel.org with SMTP id <S268597AbRG3NtM>;
	Mon, 30 Jul 2001 09:49:12 -0400
From: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
To: Chris Mason <mason@suse.com>
Cc: Chris Wedgwood <cw@f00f.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <151150000.996453157@tiny>
Date: 30 Jul 2001 09:49:20 -0400
In-Reply-To: <151150000.996453157@tiny>
Message-ID: <s5gpuaiplwf.fsf@egghead.curl.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Chris Mason <mason@suse.com> writes:

> Correct, in the current 2.4.x code, its a quirk.  fsync(any object) ==
> fsync(all pending metadata, including renames).

This does not help.  The MTAs are doing fsync() on the temporary file
and then using the *subsequent* rename() as the committing operation.

> Anyway, during a rename, this patch updates the inode transaction
> tracking stuff so an fsync on the file should also commit the
> directory changes.  But, that isn't something I really intend to
> advertise much, since the accepted linux way is fsync(dir).

It would be nice to have an option (on either the directory or the
mountpoint) to cause all metadata updates to commit to the journal
without causing all operations to be fully synchronous.  This would
provide compatibility with BSD-centric code without taking the
performance hit of synchronous data.  Heck, just having link() and
rename() perform a commit would be good enough for almost all
applications.

 - Pat
