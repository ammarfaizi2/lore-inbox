Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbTJWDUb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 23:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTJWDUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 23:20:31 -0400
Received: from mail.storm.ca ([209.87.239.66]:18863 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id S261601AbTJWDU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 23:20:29 -0400
Message-ID: <3F97498D.9050704@storm.ca>
Date: Thu, 23 Oct 2003 11:22:53 +0800
From: Sandy Harris <sandy@storm.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] frandom - fast random generator module
References: <3F8E552B.3010507@users.sf.net> <bn40oa$i4q$1@gatekeeper.tmr.com> <bn46q9$1rv$1@cesium.transmeta.com> <bn4aov$jf7$1@gatekeeper.tmr.com> <bn4l5q$v73$1@cesium.transmeta.com> <20031022025602.GH17713@pegasys.ws> <20031022122251.A3921@borg.org>
In-Reply-To: <20031022122251.A3921@borg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kent Borg wrote:

> I regularly use:
> 
>   $ head -c 4 /dev/random | ./mnencode
> 
> ... I pipe 4 (rarely more) bytes into mnencode, ...
> ... So I have a lot of passwords that look like
> corona-million-binary or ...

That's not secure; four bytes give only 2^32 = 4 billion odd
possibilities. An enemy can easily enumerate them all as the
start of an attack.

> For more information on mnencode see
> <http://www.tothink.com/mnemonic/>.
> 
Neat utility, and one I didn't know about. Thanks.
> 
> -kb, the Kent who would like to see the kernel's random number
> generator improved

I think we'd all like to see it improved if possible. The question
is how, and why?

>(better entropy estimation, better entropy management,

I see no problems there.

The estimation is of course imperfect, but seems conservative
and reasonable.

There are only two ways I can see to manage entropy -- use a pool
as /dev/random does or just use a couple of hash contexts as
Yarrow does. Methinks the pool approach is better because it
gives a higher upper bound on entropy used. The implementation
in /dev/random looks fine to me, too.

Do you have anything specific? What do you think is wrong in
these areas, and can you suggest a fix?

> ability to supply some initial entropy early in the
> boot--for embedded devices

Once you have a file system, that's easy. Just cat or dd a
saved entropy file into /dev/random. You can play with pool
size #defines in the /dev/random code and constants in the
shellscript to adjust the details.

Do you think you need this before there's a file system? Why?
Or are you thinking of boxes that don't have a file system?
Or not writable? Not local?

> --and even speed),

I suspect that's the real issue. People report using other
things because /dev/urandom is too slow.

Can we speed up /dev/urandom? Or perhaps write a PRNG daemon?

If all we need is a library, there's an RC4-based one named
prng.c in the FreeS/WAN libraries.
http://www.freeswan.org/freeswan_snaps/CURRENT-SNAP/doc/manpage.d/ipsec_prng.3.html

Two threads discussing the desin start at:
http://lists.freeswan.org/pipermail/design/2002-March/002166.html
http://lists.freeswan.org/pipermail/design/2002-March/002207.html

> but the Kent who doesn't
> want the kernel to be exploded into a catalogue of competing random
> number generators.

I'm with you there.



