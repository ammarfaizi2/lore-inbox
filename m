Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVKETjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVKETjT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 14:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVKETjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 14:39:19 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:41272 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932302AbVKETjT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 14:39:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bdDkwuSqom29enuEQJ89/BN/LPpKjUqhSx2545TxQdSPh72emgkMlK4miFrYevtf2bSv9WnlcPjNyd7mTfUlZ03/LyjjG1zunhfOys5jmgI7uEpFTBe2zfO7/HZT53TH90XfYrjXZKTYo2C3xyqcFLgbmFLkfWSkjfSjMEkuB+I=
Message-ID: <35fb2e590511051139n2964f51ct761b8d97de86580d@mail.gmail.com>
Date: Sat, 5 Nov 2005 19:39:18 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: PATCH: fix-readonly-policy-use-and-floppy-ro-rw-status
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051105190130.GP7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051105182728.GB27767@apogee.jonmasters.org>
	 <20051105103358.2e61687f.akpm@osdl.org>
	 <20051105184028.GD27767@apogee.jonmasters.org>
	 <20051105184408.GO7992@ftp.linux.org.uk>
	 <35fb2e590511051051o16e3e763x821f12555261c4cc@mail.gmail.com>
	 <20051105190130.GP7992@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/05, Al Viro <viro@ftp.linux.org.uk> wrote:

> ->remount_fs() certainly can refuse to go r/w - you don't need anything
> new for that, just don't leave MS_RDONLY in *flags.

Sure.

> The real trouble starts when fs wants to go r/o on its own

Although the situation here is really the other way around -
filesystem is mounted readonly (at least in this case with floppies -
but there are probably others too) and wants to go rw. When asked, we
need to check that the media is able to do handle that transition.
Currently I've bodged floppy.c to store this in policy/readonly (which
is what got me looking at genhd last week) but really there should be
a better way - one where we do this once we get to do_remount_sb or
whatever. This seems to be missing functionality.

> e.g. when it sees an error bad enough to warrant that.  And that, BTW, is very
> likely to require more than just one bit in ->policy - we want all IO on that device
> to fail until after we actually close it during umount.  As it is, we can get anything,
> including block allocations (e.g. if we have a dirty mapping and it gets written to disk).

Ok. So what you're saying is that this is more complex than I'd
implied and you're right :-) But aside from that, you're the expert
and I'm willing to go be a patch monkey, so just tell me what you
think is worth trying...

Jon.
