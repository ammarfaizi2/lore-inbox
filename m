Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbTDGKu3 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 06:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTDGKu3 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 06:50:29 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:3850 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S263373AbTDGKu2 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 06:50:28 -0400
Date: Mon, 7 Apr 2003 13:02:03 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
Message-ID: <20030407110203.GA53597@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <3E907A94.9000305@kegel.com> <200304062156.37325.oliver@neukum.org> <1049663559.1602.46.camel@dhcp22.swansea.linux.org.uk> <b6qo2a$ecl$1@cesium.transmeta.com> <b6qnr6$s4h$1@abraham.cs.berkeley.edu> <20030407100915.A2493@clueful.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030407100915.A2493@clueful.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 10:09:15AM +0100, Malcolm Beattie wrote:
> Here's another example along similar lines: you can open a file
> O_APPEND and pass the descriptor along to another process (e.g. a
> security mediator process that hands out a file descriptor to a
> less-trusted recipient that it can use for appending entries only).
> fcntl() explicity prevents the clearing of the O_APPEND flag on a
> file which was opened with O_APPEND. With flink, one could flink()
> and re-open without O_APPEND: security hole.

That would be a big security hole waiting to happen though.  Nothing
forces the less trusted recipient not to send in zeroes or finish the
lines (for a text file) or respect a particular format (for a binary
file).

In practice, I tend to think that any secutiry scheme flink breaks is
brittle at best.  It requires passing a fd to a file which is owned by
the same uid than the untrusted process, and rely somehow on the
directory structure to prevent direct access to said file.  But the
trusted process must have had access to the file somehow, so, well,
it's really, really brittle.

/proc breaking it already isn't very surprising.

  OG.

