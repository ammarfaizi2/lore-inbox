Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTETAmF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbTETAmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:42:05 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:48008 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S263397AbTETAmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:42:00 -0400
Subject: Re: Recent changes to sysctl.h breaks glibc
From: David Woodhouse <dwmw2@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3EC9660D.2000203@zytor.com>
References: <20030519165623.GA983@mars.ravnborg.org>
	 <Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>
	 <babhik$sbd$1@cesium.transmeta.com>	<m1d6ie37i8.fsf@frodo.biederman.org>
	 <3EC95B58.7080807@zytor.com> <m18yt235cf.fsf@frodo.biederman.org>
	 <3EC9660D.2000203@zytor.com>
Content-Type: text/plain; charset=ISO-8859-15
Organization: 
Message-Id: <1053392095.21582.48.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Tue, 20 May 2003 01:54:55 +0100
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: hpa@zytor.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-20 at 00:17, H. Peter Anvin wrote:
> Your message assumes that the ABI remains fixed.  This is totally and
> utterly and undeniably WRONG.  There are rules for how it may evolve,
> but it very much does evolve.  No amount of handwaving or putting
> underscores in weird places will change that.

To a large extent, however, it merely grows. And in a lot of cases when
it grows due to new syscalls, new interfaces, etc., you have to add
matching code to glibc to use them _anyway_, so it's no problem for
glibc's version of the headers to lag behind until the appropriate
support is added.

You are, however, correct that the correct fix is to have completely
separate headers which define the ABI. Then the real kernel headers in
include/linux and include/asm can include them, and C libraries can also
use them without contamination.

This requires that someone sit down and cut'n'paste large amounts of
structures and definitions from include/linux/*.h into the new header
files. I've been tempted to do that on occasion but what's held me up
has been the fact that there isn't yet a consensus on how it should be
laid out.

For compatibility with older libc, one approach would be to add a new
directory to the include path which matches the existing layout
(linux/usrinclude/linux, linux/usrinclude/asm-*), and use #include_next
from the actual kernel headers to pull in those files.

Alternatively, we could go further and take the opportunity to rearrange
stuff further; I'm not sure what we really gain from that though other
than extra pain.

If Linus would approve a strategy for rearranging the headers such that
people can work on it without suspecting that they're just wasting their
time, I think it could get done for 2.6.

It's not the kind of thing you do in private and present as a fait
accomplis -- if it isn't quite right, you end up having to do the whole
thing from scratch, afaict.
 
-- 
dwmw2

¹ but admittedly not all.


