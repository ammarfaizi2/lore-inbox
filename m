Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756867AbWKZTq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbWKZTq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 14:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756869AbWKZTq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 14:46:59 -0500
Received: from server04.internet.akkaya.de ([213.168.65.229]:10969 "EHLO
	server04.internet.akkaya.de") by vger.kernel.org with ESMTP
	id S1756867AbWKZTq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 14:46:58 -0500
Message-ID: <4569EF28.4020009@akkaya.de>
Date: Sun, 26 Nov 2006 20:46:48 +0100
From: =?ISO-8859-15?Q?J=FCrgen_Pabel?= <jpabel@akkaya.de>
Organization: Akkaya Consulting GmbH
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Incorrect handling of descriptors put into UNIX domain sockets?
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I may have stumbled upon a bug (or is it a feature?). First off though,
I am reporting this based on my recollection - so my description might
not be 100% accurate (this happened about two months ago). Since I don't
have time to set up a verification scenario, I figured I'd just report
this and let some else do the grunt work (thank you) or just not worry
about it.

The problem (on a SLES9 - which is something like 2.6.5 plus SuSE
patches) was that a file descriptor, once put into a UNIX domain socket
would not be considered by the kernel when the according resource was
being closed. If the handle was taken "out of the UDS" after the
resource already has been closed than the handle appeared to represent a
resource that was no longer valid. What that would do if you actually
used the handle is entirely left untested.

Essentially what I observed was that the handle represented a TCP
hashtable entry that was no longer allocated in the kernel, but was
nevertheless "given" to the process. Technically speaking: "lsof"
reported a socket identifier not listed in /proc/net/tcp anymore (this
was double and triple checked at the time because it seemed so odd).

The process now appeared to have a handle to a TCP connection which was
no longer established. My assumption here is that the handle would
actually match the next connection that has the same TCP identity (IP
addresses/ports) and might "work" with that connection.

jp

-- 
Jürgen Pabel, CISSP

Akkaya Consulting GmbH
Eupener Straße 137
50933 Köln

Telefon: +49 221 9473007
Telefax: +49 221 4911970
Mobil:   +49 160 8806134

E-Mail:  jpabel@akkaya.de
Internet: http://www.akkaya.de
