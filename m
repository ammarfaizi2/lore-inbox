Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbUKWKUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbUKWKUf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 05:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUKWKUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 05:20:34 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:57698 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262444AbUKWKU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 05:20:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=DijH6Yd5ZZuPmAVLpkcDWa0jhwYYI0yPPAGd/0O9oxT9QHTWYuebHQeAyh31KivBA4dmc306VwOdsLhdkgzkksuXz6Cs1U2Ngu5UdmFuWoRC6gF/usk3RgfYHhqqvP4seZPv2tq6KeHdybIDjsFttCRiq3RkiwaZOguWKy9vDrI=
Message-ID: <fcb9aa29041123022027c1ec06@mail.gmail.com>
Date: Tue, 23 Nov 2004 12:20:24 +0200
From: Ilya Pashkovsky <ilya.pashkovsky@gmail.com>
Reply-To: Ilya Pashkovsky <ilya.pashkovsky@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: tcp port reuse checking TCP_LISTEN state
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, fellow developers.

While BSD (and thus, MacOS X) has the SO_REUSEPORT socket option, and
Windows has SO_REUSEADDR socket option that integrates the port reuse
functionality, linux tends to differ.
Though the socket matching should be made using the tuple consisting
of both source address+port and destination address+port, there's a
check in the tcp implementation of linux kernel for TCP_LISTEN state,
which inhibits port reuse. While its logical to allow only one
listener on a socket, this can be accomplished by checking for the
socket state during the call to listen(). The current behavior breaks
applications that want to both listen on an port and initiate outgoing
connections from it (same port).
Can anyone please explain the logic behind the TCP_LISTEN check being
done on bind() calls and not listen() calls ?

--
 ilya
