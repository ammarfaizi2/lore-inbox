Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263716AbTKRQZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 11:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbTKRQZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 11:25:27 -0500
Received: from pat.uio.no ([129.240.130.16]:17095 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263716AbTKRQZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 11:25:26 -0500
To: Andi Kleen <ak@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, hpa@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: OT: why no file copy() libc/syscall ??
References: <1068512710.722.161.camel@cube.suse.lists.linux.kernel>
	<20031111133859.GA11115@bitwizard.nl.suse.lists.linux.kernel>
	<20031111085323.M8854@devserv.devel.redhat.com.suse.lists.linux.kernel>
	<bp0p5m$lke$1@cesium.transmeta.com.suse.lists.linux.kernel>
	<20031113233915.GO1649@x30.random.suse.lists.linux.kernel>
	<3FB4238A.40605@zytor.com.suse.lists.linux.kernel>
	<20031114011009.GP1649@x30.random.suse.lists.linux.kernel>
	<3FB42CC4.9030009@zytor.com.suse.lists.linux.kernel>
	<p734qx7rmyf.fsf@oldwotan.suse.de>
	<20031118154921.GA28942@mail.shareable.org>
	<20031118170509.71bfb039.ak@suse.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 Nov 2003 11:25:16 -0500
In-Reply-To: <20031118170509.71bfb039.ak@suse.de>
Message-ID: <shsk75xy783.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andi Kleen <ak@suse.de> writes:

    >> > That would be buggy because existing users of sendfile don't
    >> > know about this and would silently only copy part of the file
    >> > when a signal happens.
    >>
    >> That doesn't make sense.  There aren't any existing users of
    >> sendfile to copy files.

     > [ignore the mail, it was an stuck mail queue]

     > But note that arbitary changes in the signal handling would
     > affect all users of sendfile, not just those that attempt to
     > copy files or do other things that should be done in user
     > space.

That 'change' is already in effect for people who mount their NFS
partitions with the "intr" or "soft" flags.

See the return value of generic_file_sendfile(): it already has the
read()/write-like semantics of returning number of bytes written if
non-zero, or the value of desc.error if not.

Cheers,
  Trond
