Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135793AbRD3TJO>; Mon, 30 Apr 2001 15:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135799AbRD3TJE>; Mon, 30 Apr 2001 15:09:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45211 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135793AbRD3TI4>;
	Mon, 30 Apr 2001 15:08:56 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15085.47104.75880.572242@pizda.ninka.net>
Date: Mon, 30 Apr 2001 12:07:44 -0700 (PDT)
To: root@chaos.analogic.com
Cc: Torrey Hoffman <torrey.hoffman@myrio.com>,
        "'Kenneth Johansson'" <ken@canit.se>,
        Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: RE: 2.4 and 2GB swap partition limit
In-Reply-To: <Pine.LNX.3.95.1010430145555.15714A-100000@chaos.analogic.com>
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1B9F@mail0.myrio.com>
	<Pine.LNX.3.95.1010430145555.15714A-100000@chaos.analogic.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Richard B. Johnson writes:
 > On Mon, 30 Apr 2001, Torrey Hoffman wrote:
 > > In general, is there a safe way to replace executable files for
 > > programs that might be running while their on-disk images are
 > > replaced?
 > 
 > Yes. Perfectly safe:
 > 
 > mv /usr/bin/exeimage /usr/bin/exeimage.sav
 > cp /wherever/exeimage /usr/bin/exeimage
 > 
 > 
 > The executing task will continue to use the old image until it exits.

Even more effective is:

mv /wherever/exeimage /usr/bin/exeimage

The kernel keeps around the contents of the old file while
the executing process still runs.

This is also basically how things like libc get installed.
A single mv is not only preserves currently referenced contents,
it is atomic.

Later,
David S. Miller
davem@redhat.com
