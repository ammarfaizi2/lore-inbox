Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267480AbUIOEiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267480AbUIOEiU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 00:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267588AbUIOEiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 00:38:19 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:19942 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S267480AbUIOEiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 00:38:03 -0400
Date: Tue, 14 Sep 2004 21:37:13 -0700
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
To: Arnout Engelen <arnouten@bzzt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: truncated lines in /proc/net/tcp
Message-Id: <20040914213713.14ce5348.randy.dunlap@verizon.net>
In-Reply-To: <20040910163003.GT11646@bzzt.net>
References: <20040910163003.GT11646@bzzt.net>
Organization: YPO4
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [4.5.49.23] at Tue, 14 Sep 2004 23:38:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004 18:30:03 +0200 Arnout Engelen wrote:

Note:  netdev@oss.sgi.com would be more appropriate for this.


| Hi,
| 
| I noticed lines in the output of /proc/net/tcp sometimes appear 'truncated', like
| this:
| 
|   52: 010310AC:9D95 030310AC:1770 06 00000000:00000000 03:0000146C
|   00000000     0        0 0 2 c4e3f0c0
| 
| (also notice that the inode is '0' instead of some large integer)
| 
| This is print by the code at:
| 
|   http://lxr.linux.no/source/net/ipv4/tcp_ipv4.c?v=2.6.8.1#L2504

That line is used/printed if socket state is case TCP_SEQ_STATE_ESTABLISHED:
or case TCP_SEQ_STATE_LISTENING:
(line 2559).  However, if socket state is case TCP_SEQ_STATE_OPENREQ:,
get_openreq4() is called to print the info, and if socket state is
case TCP_SEQ_STATE_TIME_WAIT:, get_timewait4_sock() is called to
print the info.  The first case includes 5 fields after the %p (pointer),
while the 2nd and 3rd cases do not.  Is that the truncation that you
are referring to?

| Maybe the value of 'tp' gets invalidated at some point during the
| gathering of the data to be printed there?

That doesn't quite explain it.

| (note that I'm not myself a kernel developer. I ran into this when
| writing a userspace application and decided I wanted to know why this
| happened. I saw this behaviour on a 2.4.26 kernel, but the code 
| doesn't appear to be significantly different in 2.6. I'm not subscribed 
| to the LKML, so if you want to ask me something please CC me personally).

Expect different output formats depending on socket state.

--
~Randy
