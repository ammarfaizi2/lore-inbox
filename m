Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276445AbRJCQOl>; Wed, 3 Oct 2001 12:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276439AbRJCQOb>; Wed, 3 Oct 2001 12:14:31 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:51706 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S276426AbRJCQOX>; Wed, 3 Oct 2001 12:14:23 -0400
Date: Wed, 3 Oct 2001 17:14:51 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS data corruption in very simple configuration
Message-ID: <20011003171451.A5209@redhat.com>
In-Reply-To: <200109221000.GAA11263@out-of-band.media.mit.edu> <15276.34915.301069.643178@beta.reiserfs.com> <20010925131304.I23320@mikef-linux.matchmail.com> <20010926154311.C12560@redhat.com> <20010930203831.A25387@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010930203831.A25387@mikef-linux.matchmail.com>; from mfedyk@matchmail.com on Sun, Sep 30, 2001 at 08:38:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 30, 2001 at 08:38:31PM -0700, Mike Fedyk wrote:
 
> >From what you're describing, it looks like the contents of test after a
> truncate won't be overwritten by another transaction until the deletion of
> those blocks has made it to disk...  So, while in ordered, or journal mode,
> I'd end up with "a" in test, but with writeback mode there is no such
> guarantee.
> 
> Am I missing something?
> 
> Are there any known cases where ext3 will not be able to recover pervious
> data when a write wasn't able to complete?

It depends on what the application is doing.  Applications often open
an existing file with O_TRUNC, write to it, then close it.  If you
crash between the truncate and the write being committed, then you'll
get a perfectly legal, sane, consistent, empty file on recovery.

--Stephen
