Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbTFCOma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265033AbTFCOma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:42:30 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:54468 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S265032AbTFCOm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:42:29 -0400
To: <linux-kernel@vger.kernel.org>
Subject: select for UNIX sockets?
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 03 Jun 2003 02:08:18 +0200
Message-ID: <m3llwkauq5.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Should something like this work correctly?

while(1) {
        FD_ZERO(&set);
        FD_SET(fd, &set);
        select(FD_SETSIZE, NULL, &set, NULL, NULL); <<<<<<< for writing

        if (FD_ISSET(fd, &set))
                sendto(fd, &datagram, 1, 0, ...);
}

fd is a normal local datagram socket. It looks select() returns with
"fd ready for write" and sendto() then blocks as the queue is full.

I don't know if it's expected behaviour or just a not yet known bug.
Of course, I have a more complete test program if needed.

2.4.21rc6, haven't tried any other version.

strace shows:

select(1024, NULL, [3], NULL, NULL)     = 1 (out [3])
sendto(3, "\0", 1, 0, {sa_family=AF_UNIX, path="/tmp/tempUn"}, 13 <<< blocks
-- 
Krzysztof Halasa
Network Administrator
