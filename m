Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129086AbQJ3RmB>; Mon, 30 Oct 2000 12:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129089AbQJ3Rlv>; Mon, 30 Oct 2000 12:41:51 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25686 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129086AbQJ3Rlf>; Mon, 30 Oct 2000 12:41:35 -0500
Date: Mon, 30 Oct 2000 18:41:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030184109.C21935@athlon.random>
In-Reply-To: <20001030025600.B20271@vger.timpanogas.org> <Pine.LNX.4.21.0010301212590.3186-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0010301212590.3186-100000@elte.hu>; from mingo@elte.hu on Mon, Oct 30, 2000 at 12:13:52PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 12:13:52PM +0100, Ingo Molnar wrote:
> simple, write a TUX protocol module for it. FTP protocol module is on its
> way. Stay tuned.

TUX modules are kernel modules (I mean you have to write kernel space code for
doing TUX ftp). Don't you agree that zero-copy sendfile like ftp serving would
be able to perform equally well too? I mean: isn't better to spend the efforts
to make an userspace API to run fast instead of moving every network
functionality that needs high performance completly in kernel? People may need
to write high performance network code for custom protocols, this way they will
end creating kernel modules with system-crashing bugs, memory leaks and kernel
buffer overflows (chroot+nobody+logging won't work anymore). (plus they will
get into pain while debugging)

It's obvious kernel code runs faster and you can also do assumptions about
scheduler and current CPU that you can't do in userspace, but is that so
relevant in term of ftp server numbers compared to only skipping the memory
copies?

About the TUX cgi module I had a fast look and I noticed cgis run by tux
executes two clones(2) and one exec(2) and then they have to pay the startup of
the interpreters for each cgi request. So at this stage of tux I guess that for
perl/php pages tux would better redirected them to an apache.  Maybe php and
perl tux (kernel) modules are in your todo list? (I think they would be a bad
idea though) One other way to handle efficiently the interpreted-cgi load
without redirecting the cgi request to a full apache is to have a background
php/perl interpreter listening to new cgis in input and filling the tux pipe in
output.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
