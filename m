Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271621AbRIGJF5>; Fri, 7 Sep 2001 05:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271625AbRIGJFr>; Fri, 7 Sep 2001 05:05:47 -0400
Received: from tangens.hometree.net ([212.34.181.34]:27800 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S271621AbRIGJFl>; Fri, 7 Sep 2001 05:05:41 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
Date: Fri, 7 Sep 2001 09:06:00 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9na2lo$ad$1@forge.intermeta.de>
In-Reply-To: <20010906172316.E0B74BC06C@spike.porcupine.org> <E15f4ul-0000J5-00@the-village.bc.nu> <20010906221152.F13547@emma1.emma.line.org>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 999853560 25932 212.34.181.4 (7 Sep 2001 09:06:00 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 7 Sep 2001 09:06:00 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:

>On Thu, 06 Sep 2001, Alan Cox wrote:

>> If you accept 10.0.0.1 from the outside you are leaking information. It

>No, if you accept 10.*.*.* from the outside, your routers are broken.

BS. This has nothing to do with "accepting connections from addresses":

% telnet mail.intermeta.de smtp
Trying 212.34.181.3...            <---- Note!
Connected to mail.intermeta.de.
Escape character is '^]'.
220 mail.intermeta.de ESMTP Sendmail 8.11.6/8.11.6; Fri, 7 Sep 2001 11:00:01 +0200
HELO mail.hometree.net
250 mail.intermeta.de Hello IDENT:henning@tangens.hometree.net [212.34.181.34], pleased to meet you
MAIL FROM: <henning@hometree.net>
250 2.1.0 <henning@hometree.net>... Sender ok
RCPT TO: <henning@[192.168.2.1]>
550 5.7.1 <henning@[192.168.2.1]>... Relaying denied
RCPT TO: <henning@[192.168.2.3]>
250 2.1.5 <henning@[192.168.2.3]>... Recipient ok
RCPT TO: <henning@[10.11.12.13]>
550 5.7.1 <henning@[10.11.12.13]>... Relaying denied
QUIT

You may guess now, which the _real_ IP address of "mail.intermeta.de"
is.  Yes, "that other mailer" leaks this information. But only for its
own, local IP address.

More "real world" you can't get as in this example. The box transfers
about 1000 Mails per day which may not be much in todays internet but
is fine as "my little mail home". Percentage of failed mails because
of [ip-addr] adressing: 0.00%

So where lies the problem with all this? If the current reporting of
the netmasks is a bug: Fine, fix it, get on with life.  

I agree totally with Alan here. If the config can be reported by the
4.3 API, then it should be and be correct. If it can't: Well tough
luck for "really, really" portable mailers.

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
