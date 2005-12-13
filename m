Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVLMP5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVLMP5E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVLMP5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:57:03 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:62986 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932319AbVLMP5C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:57:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JzldNFV1j/PSpJyAeveSMsdRmmCOljECe8u6/utdXxO/kEqrNVKPoDjQbHrlxB9XFOR2PlDvG4uEs4uF33LUvfl3NEDTUd/PaJaSpukxxUf1+VQwNFUWJahkf1YTwc0J975LB07L7VzWD6SHWXhWIiaUroqMS/eOqpHevR6fgHo=
Message-ID: <e46c534c0512130756k18c409aen3d60df7aaee50062@mail.gmail.com>
Date: Tue, 13 Dec 2005 15:56:55 +0000
From: Filipe Cabecinhas <filcab@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Possible problem in fcntl
Cc: Nuno Lopes <ncpl@mega.ist.utl.pt>,
       =?ISO-8859-1?Q?Renato_Cris=F3stomo?= <racc@mega.ist.utl.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have written a little webserver for our CS course. But we have a
problem with fcntl.
We are using non-blocking sockets and per fcntl man page:
       On Linux, the new socket returned by accept () does  not  inherit  file
       status  flags such as O_NONBLOCK and O_ASYNC from the listening socket.
       This behaviour differs from the canonical BSD  sockets  implementation.
       Portable  programs should not rely on inheritance or non-inheritance of
       file status flags and always explicitly set all required flags  on  the
       socket returned from accept().

We call fcntl after calling bind and listen. Then we also call fcntl
for each accept'ed connection to set O_NONBLOCK:
				flags = fcntl(e, F_GETFL);
				fcntl(e, F_SETFL, flags | O_NONBLOCK);

$ uname -a
Linux lab9p2 2.6.11.12 #3 Sat Sep 3 20:09:17 WEST 2005 i686 Intel(R)
Pentium(R) 4 CPU 2.26GHz GenuineIntel GNU/Linux
$

The code is at http://mega.ist.utl.pt/~facab/proj/
(files httpd.n.[ch] have the line numbers)
The line that's causing the trouble is line 377 in httpd.c. Commenting
that line fixes the problem (although we think that shouldn't be
necessary).

However, in my laptop (with a different kernel version) it works. So,
does this kernel version (2.6.11.12) has a bug with fcntl or are we
doing something wrong?


Thanks in advance,
Filipe Cabecinhas

P.S: Please CC me, because I'm not subscribed to this list.
