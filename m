Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289320AbSAOAQP>; Mon, 14 Jan 2002 19:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289321AbSAOAQG>; Mon, 14 Jan 2002 19:16:06 -0500
Received: from adsl-63-192-223-74.dsl.snfc21.pacbell.net ([63.192.223.74]:32832
	"EHLO gateway.berkeley.innomedia.com") by vger.kernel.org with ESMTP
	id <S289320AbSAOAPz>; Mon, 14 Jan 2002 19:15:55 -0500
Message-ID: <3C4374BA.F8E26684@berkeley.innomedia.com>
Date: Mon, 14 Jan 2002 16:15:54 -0800
From: Christopher James <cjames@berkeley.innomedia.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test1-rtl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: linux-kernel@vger.kernel.org,
        Christopher James <cjames@berkeley.innomedia.com>
Subject: Re: Multicast fails when interface changed
In-Reply-To: <200201142016.XAA10180@ms2.inr.ac.ru>
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mangalore.zipworld.com.au id LAA29877

kuznet@ms2.inr.ac.ru wrote:

> Hello!
>
> > the app (vocal 1.2) does not use INADDR_ANY for imr_interface when
> > joining the multicast group
>
> Hmm... and what does it use?
>
> As soon as /proc/net/dev_mcast does not show membership on the second
> interface, it is not difficult to conclude that the applciation just forgot to
> request mmembership on it.
>
> Alexey

When joining the multicast group, imr_interface is set to the hostname
IP address, in this case 192.168.25.113.  This was verified by
by looking at the Vocal code,  and by putting printfs in Vocal code
to print out imr_interface when joining the multicast group.

More background on app and problem:  We are developing a high availability
solution where the application can run on one of two redundant networks.
The application uses either eth1 (connected to network1)
or  eth2 (connected to network2).  Only one interface is up at a time.
When the application comes up, it uses eth1.  Another process (other than
the application) monitors the health of network1.  If network1 goes down, then
the
monitoring process uses ifconfig to take down eth1, and ifconfig
to bring up eth2 (using the same configuration information  as used for
eth1).  This switch is  completely transparent to the application: the
application does
not know about the switch or do anything to make the switch;  the app does not
set
multicast membership on the new interface.

It was our expectation that the switch from the first to second interface  should

work without any involvement from the application because the second interface is
configured
exactly the same as the first interface.  After the switch, everything seems to
work with the
exception of multicasting:  the multicast membership information is not
propagated to the second
interface, it stays with the first interface.

Christopher
(I'm not on list so please CC with answers/comments)

ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
