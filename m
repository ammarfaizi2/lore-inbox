Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbUKQWdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbUKQWdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbUKQWbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:31:05 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:39857 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262587AbUKQW3E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:29:04 -0500
X-OB-Received: from unknown (205.158.62.55)
  by wfilter.us4.outblaze.com; 17 Nov 2004 22:29:02 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 17 Nov 2004 17:29:01 -0500
Subject: Re: broken gcc 3.x update ("3.4.3""fixed")
X-Originating-Ip: 172.163.58.125
X-Originating-Server: ws1-3.us4.outblaze.com
Message-Id: <20041117222901.01D43101D0@ws1-3.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-3.4.3 caveats:

While gcc-3.4.3 fixed the string literal parsing
bug I saw, which involved chunks of literal string
with escaped newlines sandwiched around repeated
instances of a string-valued macro and the whole
thing assigned directly as the value of a
const char *, 3.4.3 is more strict than gcc-3.3.x
about embedded, unescaped newlines.

In gcc-3.3.2, string literals like this merely
got a "deprecated" warning:

const char * msg = "hello
world";

gcc-3.4.3 refuses to parse that at all, reporting
a missing " error as soon as it sees the unescaped
newline after 'hello' (and then reporting itself
confused by the remainder of the source file).

(Recompiling a system full of old laissez faire
C applications code with gcc-3.4.3, there is going
to be some additional maintenance involved.)

gcc-3.4.3 also bloats the kernel a little.
While stripped application binaries
(-march=i686 -O2 -fno-strict-aliasing)
consistently end up smaller than they were
when compiled with gcc-2.95.3, a 2.4.28-rc3
kernel ended up 60k bigger with the same
.config.

Regards,

Clayton Weaver
<mailto: cgweav@email.com>

-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

