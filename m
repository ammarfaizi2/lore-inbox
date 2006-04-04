Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWDDRef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWDDRef (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 13:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWDDRee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 13:34:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35112 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750767AbWDDRee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 13:34:34 -0400
Date: Tue, 4 Apr 2006 19:34:49 +0200
From: Jens Axboe <axboe@suse.de>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: tridge@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice support #2
Message-ID: <20060404173449.GS4385@suse.de>
References: <17452.50912.404106.256236@samba.org> <20060331095711.GK14022@suse.de> <Pine.LNX.4.64.0603311110540.27203@g5.osdl.org> <20060331194012.GE14022@suse.de> <4432A9DE.9090902@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4432A9DE.9090902@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04 2006, Andy Lutomirski wrote:
> Jens Axboe wrote:
> >On Fri, Mar 31 2006, Linus Torvalds wrote:
> >
> >>
> >>On Fri, 31 Mar 2006, Jens Axboe wrote:
> >>
> >>>> ssize_t psplice(int fdin, int fdout, size_t len, off_t ofs, unsigned 
> >>>> flags);
> >>>
> >>>I definitely see some valid reasons for adding a file offset instead of
> >>>using ->f_pos, I'll leave that decision up to Linus though. Linus?
> >>
> >>I think a file offset is fine, the one thing holding me back was just the 
> >>interface. One file offset per fd? Or just have the rule that the file 
> >>offset is for the "non-pipe" device?
> >
> >
> >Intuitively, I'd expect the offset to be tied to the non-pipe if I were
> >to eg see this for the first time. So my vote would go for that.
> >
> 
> Eee!  That means that splice(file_fd, pipe_fd, 1000) and splice(pipe_fd, 
> file_fd, 1000) have different semantics.  It also would seem to prevent 
> ever implementing direct file-to-file splicing.

The semantics as written: (fdin, fdout, len). But yes the offset gets
ugly, unless you add two offsets. And you are right it would not go well
with file -> file splicing, which btw is already implemented (just not
in 2.6.17-rc1) along with file -> socket.

-- 
Jens Axboe

