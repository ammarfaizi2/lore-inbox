Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287591AbSALWK0>; Sat, 12 Jan 2002 17:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287588AbSALWKT>; Sat, 12 Jan 2002 17:10:19 -0500
Received: from smtp1.nbnet.nb.ca ([198.164.200.23]:41105 "EHLO
	mail-nb00s0.nbnet.nb.ca") by vger.kernel.org with ESMTP
	id <S287593AbSALWKI>; Sat, 12 Jan 2002 17:10:08 -0500
Message-ID: <3C40B526.D960AC26@nbnet.nb.ca>
Date: Sat, 12 Jan 2002 18:13:58 -0400
From: Senhua Tao <stao@nbnet.nb.ca>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Unauthorized connection blocking withing socket
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently I am working on a project which intends to stop unauthorized
processes sending emails or messages to the internet. The goal of the
project  is to tackle  the Distributed Service Denial problem.

>From the experience on telecommunication at socket level,  it is natural
for me to look at sys_connect().
My idea is that: every time when a process tries to make a connection,
the kernel checks whether the process has the permission to make such
connection. It requires:
1. The identification of the process.  I chose the absolute path since
it is unique, can't be tempted.
2. A config file which contains connection rules for processes.
Currently, there are  only two fields in a connection rule: <cmd path>
and  <ip mask> e.g.
    # <cmdpath>     <mask>
    /home/stao/test1        192.168.2.2
    /usr/bin/ftp    255.255.255.255

where test1 can connect any port on local host 192.168.2.2 and ftp can
connect to ports of any ip address.

The <cmd path> does not have to be an absolute path in the config file,
but it has to be converted to it before the kernel can against it with
the current process identification.

I did not put any port restriction here in order to simplify the config
file. The drawback is that any process that wants to make connection
through socket has to have a rule in the config file. Another approach
is to borrow apache's authentication mechanism. In that case, we can
configure that all processes under one directory can make or to be
denied a socket connection.

It is true that sys_connect() only handle tcp and udp (and only in unix
and linux world :-)), but it should be able to block some flooded
emails sent by unauthorized processes.

I am not sure that it is a good idea to mess around sys_connect() or any
one want to put such restriction on their computer. I don't see amy
problem for the people who just use applications on their computers
though. Any suggestion?

Sen


--

Senhua Tao
Intensional Software Inc.



