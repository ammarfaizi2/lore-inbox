Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287009AbRL1U1u>; Fri, 28 Dec 2001 15:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287003AbRL1U1n>; Fri, 28 Dec 2001 15:27:43 -0500
Received: from web12303.mail.yahoo.com ([216.136.173.101]:44069 "HELO
	web12303.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287009AbRL1U1Z>; Fri, 28 Dec 2001 15:27:25 -0500
Message-ID: <20011228202724.99671.qmail@web12303.mail.yahoo.com>
Date: Fri, 28 Dec 2001 12:27:24 -0800 (PST)
From: Myrddin Ambrosius <imipak@yahoo.com>
Subject: IGMPv3 (and the network code in general)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-802426236-1009571244=:99127"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-802426236-1009571244=:99127
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

   Well, I finally got to work on IGMPv3 for Linux.
Bad
Mistake! This looks like it'll be some seriously heavy
work,
if I'm going to do this properly, and not just make
some
half-hearted effort.

   First, IGMPv3 starts off apparently trivial - an
extended
IGMP header, a few #defines, one function, and a
couple
of structures. No biggie. But then it starts to get
fun.....

   Auxiliary data structures are the next layer in
IGMPv3.
The draft IGMPv3 document doesn't define any, but
there
is one for authentication, also in draft form, which
begins
to make things complicated.

   Parallel to all of this (and part of IGMPv3) is SSM
(Source Specific Multicast). Built around that, is
MSNIP
(Multicast Source Notification of Interest Protocol),
which
then has extensions for proxying. There's an RTCP
extension for SSM, but I'm going to ignore that. MSNIP
looks like it is going to be the biggest chunk of the
code.
The bulk of the API extensions, structures, etc, are
all
MSNIP stuff.

   I've included a diff for igmp.h, which inserts my
(shaky)
interpretation of the relevent draft documents' specs
for the
required structures, defines and functions. I've
backetted
the new code with #if define's. That way, it's visible
as to
what bit of code is intended for what, and the
extensions
can be selectively compiled in. (I've a nasty
suspicion that
there's going to be a fair amount of overhead involved
in
all this.)

   I want to get my interpretation of the API out
-now-,
because if I'm incorrect, I'd rather know about it
sooner,
rather than later. I'll get the back-end code out,
eventually,
but I'm sure you don't want to see a bunch of stubs
and
half-chewed code. (My hamster got into the computer.)

   I might miss a reply on the list, so if anyone is
interested
in the IGMPv3 stuff, I'd be grateful if you could CC
the
reply to imipak@yahoo.com. Also, if anyone else is
working on Linux IGMPv3 code, if they could drop me a
note, it would be helpful. Diversity is a good thing,
but
too much causes migranes in 8 out of 10 cats.

Thanks,

Jonathan Day


__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
--0-802426236-1009571244=:99127
Content-Type: application/x-gzip; name="igmp-patch.gz"
Content-Transfer-Encoding: base64
Content-Description: igmp-patch.gz
Content-Disposition: attachment; filename="igmp-patch.gz"

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
dHSv68Wm+/H04U+p+RO2/g9bduvLhi8AAA==

--0-802426236-1009571244=:99127--
