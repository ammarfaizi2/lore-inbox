Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUCIQRZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbUCIQRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:17:25 -0500
Received: from CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com ([24.112.162.124]:787
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id S262060AbUCIQRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:17:10 -0500
Message-ID: <404DEDED.5080308@coplanar.net>
Date: Tue, 09 Mar 2004 11:16:45 -0500
From: Jeremy Jackson <jerj@coplanar.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Arthur Corliss <corliss@digitalmages.com>
CC: Tim Schmielau <tim@physik3.uni-rostock.de>, Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] 2.6.x BSD Process Accounting w/High UID
References: <Pine.LNX.4.44.0403041451360.20043-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0403041103500.24930@bifrost.nevaeh-linux.org> <Pine.LNX.4.53.0403042242190.29818@gockel.physik3.uni-rostock.de> <Pine.LNX.4.58.0403041324330.20616@bifrost.nevaeh-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arthur Corliss wrote:

> 
> 
> If the numbers we're logging are meaningless, then hell, yes, let's fix them
> all!

I believe the answer (to seamless backwards compatibility) lies in 
struct acct's ac_pad[10] member.

3 options exist that I can see:

1) put the high 16 bits in there, with a magic # (at then end of?) 
ac_pad.  THe old tools will be none the wiser, the new tools will 
autodetect which format the acct file is in.  Ugly but easy.

2) just make the uid/gid 32bits, and put a magic#  (at the end of?) 
ac_pad.  The old tools will choke, but the new tools will autodetect. 
If you push the new tools out a couple of years ahead, then merge the 
fix, acceptance will be fairly smooth.  Clean but painful.

or
3) make the split of 16 bits interim with one magic#, make the tools 
detect 3 formats, and in a few years, switch from the bastard 32bit to 
the clean one (different magic #).  This will give tools time to become 
standard.
Combines best of both of the above.

You can do the above with the time stuff too, but 10 bytes spare might 
constrain things a bit.  Heck, make the struct bigger, as long as there 
is a magic #, userspace should be ok.  Right now, "file" command can't 
tell what the heck the file is.  Bit wasteful to put magic in every 
record though.

While you're at it, make a switch for a tool that prints out 
ac_exitcode, without reading the binary acct file (or it's dump).

Cheers,
-- 
Jeremy Jackson
Coplanar Networks
http://www.coplanar.net

