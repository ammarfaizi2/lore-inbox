Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270025AbUJHPcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270025AbUJHPcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270023AbUJHPcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:32:23 -0400
Received: from findaloan.ca ([66.11.177.6]:46471 "EHLO findaloan.ca")
	by vger.kernel.org with ESMTP id S270022AbUJHPbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:31:17 -0400
Date: Fri, 8 Oct 2004 11:27:01 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Willy Tarreau <willy@w.ods.org>
Cc: "David S. Miller" <davem@davemloft.net>,
       Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041008152701.GB13183@mark.mielke.cc>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	"David S. Miller" <davem@davemloft.net>,
	Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
References: <20041006193053.GC4523@pclin040.win.tue.nl> <003301c4abdc$c043f350$b83147ab@amer.cisco.com> <20041006200608.GA29180@dspnet.fr.eu.org> <20041006163521.2ae12e6d.davem@davemloft.net> <20041007001937.GA48516@dspnet.fr.eu.org> <20041006172959.47c25e3d.davem@davemloft.net> <20041008064104.GF19761@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041008064104.GF19761@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 08:41:04AM +0200, Willy Tarreau wrote:
> On Wed, Oct 06, 2004 at 05:29:59PM -0700, David S. Miller wrote:
> > It absolutely does help the programs not using select(), using
> > blocking sockets, and not expecting -EAGAIN.
> As I asked in a previous mail in this overly long thread, why not returning
> zero bytes at all. It is perfectly valid to receive an UDP packet with 0
> data bytes, and any application should be able to support this case anyway.
> In case of TCP, this would be a problem because the app would think it
> indicates the last byte has been received. But in case of UDP, there is no
> problem.

0 isn't correct either. No zero length packet was successfully received.

I agree with the current read() behaviour. It's the select() behaviour
that I consider to be wrong. Patching return values is just a hacky way
of avoiding the issue.

The issue can be more easily avoided by saying 'the Linux developers
believe that the use of select() with blocking file descriptors is
invalid or not recommended, and have chosen not to ensure that this
use of system calls is reliable'. "We're not POSIX compliant in this
case" isn't good enough for me. One acknowledges the issue. The other
ignores it.

Cheers,
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

