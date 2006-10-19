Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423270AbWJSK62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423270AbWJSK62 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 06:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423268AbWJSK62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 06:58:28 -0400
Received: from mail29.messagelabs.com ([216.82.249.147]:12946 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S1423266AbWJSK61 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 06:58:27 -0400
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-17.tower-29.messagelabs.com!1161255506!29228091!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: kernel oops with extended serial stuff turned on...
Date: Thu, 19 Oct 2006 05:58:25 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9FA473ED@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel oops with extended serial stuff turned on...
Thread-Index: AcbzYtlU3m8gEqPMRPefBWenPw/TAwACXT+9
References: <335DD0B75189FB428E5C32680089FB9F803FE8@mtk-sms-mail01.digi.com> <20061018230939.GA7713@kroah.com> <335DD0B75189FB428E5C32680089FB9FA473E9@mtk-sms-mail01.digi.com> <45373F2F.90906@gmail.com> <45374868.5050109@gmail.com>
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Jiri Slaby" <jirislaby@gmail.com>
Cc: "Greg KH" <greg@kroah.com>, <Greg.Chandler@wellsfargo.com>,
       <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 19 Oct 2006 10:58:26.0534 (UTC) FILETIME=[80D93060:01C6F36D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,
 
Well, what I did in my drivers was the following:
 
1) Went to TTY_DRIVER_DYNAMIC_DEV.
2) Changed the "name" I use for my ttys from something generic like ttya0, ttyb0, etc,
to a more specific name of "drivername_tty0", "drivername_tty1", etc, etc.
(ie, in this case, isicom_tty0, isicom_tty1, etc)
3) Added the "tty_register_device()" to my driver to register those "extended" names.
4)Created special UDEV rules to look for <drivername>_tty*, and rename them
to something more common, ie, ttya0, ttya1, etc, etc.
 
This still doesn't *truly* fix the problem, because UDEV could still run into conflicts on
the renaming, but at least the problem moves from kernel space to user space...
 
Presumably we could "script" around the duplicate id problem in a UDEV script.
(ie, Maybe if "ttyM0" is already out there, move to "ttyN0" instead.)
 
Forgive me if this email looks a little choppy, I am coming down with the flu,
and don't really feel too well today...
 
Scott
 
________________________________

From: Jiri Slaby [mailto:jirislaby@gmail.com]
Sent: Thu 10/19/2006 4:42 AM
To: Jiri Slaby
Cc: Kilau, Scott; Greg KH; Greg.Chandler@wellsfargo.com; linux-kernel@vger.kernel.org; Alan Cox; Andrew Morton
Subject: Re: kernel oops with extended serial stuff turned on...



Jiri Slaby wrote:
> We have a few options:
> - rewrite them to use TTY_DRIVER_DYNAMIC_DEV (I'm going to do this in
> isicom anyway)

(But this won't solve anything if somebody has both "conflicting" cards.)

regards,
--
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E


