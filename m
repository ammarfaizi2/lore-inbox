Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135945AbRDZVla>; Thu, 26 Apr 2001 17:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135946AbRDZVlT>; Thu, 26 Apr 2001 17:41:19 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:17682 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S135945AbRDZVlL>; Thu, 26 Apr 2001 17:41:11 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Marek P=?iso-8859-2?Q?=EAtlicki?= <marpet@buy.pl>
cc: linux-kernel@vger.kernel.org
Message-ID: <86256A3A.00771A06.00@smtpnotes.altec.com>
Date: Thu, 26 Apr 2001 16:40:41 -0500
Subject: Re: binfmt_misc on 2.4.3-ac14
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=0u1j7JX5n1ThcKw02kcgtUxvymZJdd9aHtITb6Q5qyUqDZQ4oYTVwk26"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=0u1j7JX5n1ThcKw02kcgtUxvymZJdd9aHtITb6Q5qyUqDZQ4oYTVwk26
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline



Marek P
--0__=0u1j7JX5n1ThcKw02kcgtUxvymZJdd9aHtITb6Q5qyUqDZQ4oYTVwk26
Content-type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-transfer-encoding: quoted-printable


=EAtlicki <marpet@buy.pl> wrote:

>The directory /proc/sys/fs/binfmt_misc/ exists, but nothing in it.

Try this:

mount -t binfmt_misc none /proc/sys/fs/binfmt_misc

In the recent -ac versions, binfmt_misc must be mounted separately.  I =
have the
following in my /etc/rc.d/rc.local so that it will work with both Linus=
' and
Alan's kernels (the third variation was for an older -ac kernel that di=
dn't
create the binfmt_misc directory either; it's really not needed anymore=
 but I
left it in just in case):

#
# Register entries in binfmt_misc
#
if [ -f /proc/sys/fs/binfmt_misc/register ] ; then
        echo ':DOSWin:M::MZ::/usr/local/bin/wine:' >
/proc/sys/fs/binfmt_misc/register
elif [ -d /proc/sys/fs/binfmt_misc ] ; then
        mount -t binfmt_misc none /proc/sys/fs/binfmt_misc
        echo ':DOSWin:M::MZ::/usr/local/bin/wine:' >
/proc/sys/fs/binfmt_misc/register
else
        mount -t binfmt_misc none /etc/binfmt_misc
        echo ':DOSWin:M::MZ::/usr/local/bin/wine:' > /etc/binfmt_misc/r=
egister
fi


Wayne
=

--0__=0u1j7JX5n1ThcKw02kcgtUxvymZJdd9aHtITb6Q5qyUqDZQ4oYTVwk26--

