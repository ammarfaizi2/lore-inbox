Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbTKXQeL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 11:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbTKXQeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 11:34:11 -0500
Received: from hosting-agency.de ([195.69.240.23]:31701 "EHLO mailagency.de")
	by vger.kernel.org with ESMTP id S263767AbTKXQeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 11:34:10 -0500
From: Jakob Lell <jlell@JakobLell.de>
To: linux-kernel@vger.kernel.org
Subject: hard links create local DoS vulnerability and security problems
Date: Mon, 24 Nov 2003 17:36:23 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311241736.23824.jlell@JakobLell.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
on Linux it is possible for any user to create a hard link to a file belonging 
to another user. This hard link continues to exist even if the original file 
is removed by the owner. However, as the link still belongs to the original 
owner, it is still counted to his quota. If a malicious user creates hard 
links for every temp file created by another user, this can make the victim 
run out of quota (or even fill up the hard disk). This makes a local DoS 
attack possible.

Furthermore, users can even create links to a setuid binary. If there is a 
security whole like a buffer overflow in any setuid binary, a cracker can 
create a hard link to this file in his home directory. This link still exists 
when the administrator has fixed the security whole by removing or replacing 
the insecure program. This makes it possible for a cracker to keep a security 
whole open until an exploit is available. It is even possible to create links 
to every setuid program on the system. This doesn't create new security 
wholes but makes it more likely that they are exploited.

To solve the problem, the kernel shouldn't allow users to create hard links to 
files belonging to someone else.

I could reproduce the problem on linux 2.2.19 and 2.4.21 (and found nothing 
about it in the changelogs to 2.4.23-rc3).

Regards
 Jakob

