Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbUL1VLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbUL1VLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 16:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbUL1VLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 16:11:55 -0500
Received: from gate.firmix.at ([80.109.18.208]:21670 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S261256AbUL1VLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 16:11:53 -0500
Subject: Re: description of struct sockaddr
From: Bernd Petrovitsch <bernd@firmix.at>
To: Karel Kulhavy <clock@twibright.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20041226164051.GA5529@beton.cybernet.src>
References: <20041123214300.GB2147@beton.cybernet.src>
	 <Pine.LNX.4.53.0411232309360.23119@yvahk01.tjqt.qr>
	 <20041226164051.GA5529@beton.cybernet.src>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Tue, 28 Dec 2004 22:11:46 +0100
Message-Id: <1104268307.8367.15.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-26 at 16:40 +0000, Karel Kulhavy wrote:
> On Tue, Nov 23, 2004 at 11:11:31PM +0100, Jan Engelhardt wrote:
> > >Hello
> > >
> > >man netdevice talks about struct sockaddr, but neither describes it,
> > >nor provides a link to descriptio, nor the "SEE ALSO" items
> > >(ip(7), proc(7), rnetlink(7)) provide the necessary information.
> > >
> > >"The hardware address is specified in a struct sockaddr".
> > 
> > I don't think so. The hardware address is, well, specific to the hardware (like
> > Ethernet, for example). IP/TCP/UDP however is not limited to Ethernet. And
> > 'sockaddr' clearly is something that does not deal with hardware.
> 
> It is a sentence from man netdevice. Should I send a bugreport to the manpage
> maintainer?

No. struct sockaddr basically holds only the common field "sa_family"
and an array of char which contains the hardware specific data
(see /usr/include/linux/socket.h). It is used by the socket API.
For different hardware types you have other structs, e.g. you have
struct sockaddr_in for IP sockets and struct sockaddr_un for Unix domain
sockets.
sockaddr_in has additionally to the common fields a field for the IP
address "sin_address" and "sin_port" for the port. sockaddr_un has
simply the field "sun_path" for the name in the filesystem.

Just grep for them under /usr/include...

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



