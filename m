Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbUKRAnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbUKRAnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 19:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbUKRAln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 19:41:43 -0500
Received: from pop.gmx.net ([213.165.64.20]:22217 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262608AbUKQWCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:02:53 -0500
X-Authenticated: #1892127
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CA837452-38E4-11D9-8FA5-0003931E0B62@gmx.li>
Content-Transfer-Encoding: 7bit
From: Martin Schaffner <schaffner@gmx.li>
Subject: HFS+ Bug which causes coreutils "make test" to fail
Date: Wed, 17 Nov 2004 23:05:28 +0100
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm installing my system using an HFS+ partition as root.
When I installed the GNU coreutils, I noticed that some test fail, even 
though they succeed on other fs such as ext2.
I've tracked down one failure to the following:

mkdir a; chmod 1777 a; touch a/b; su otheruser -c "rm -rf a"

gives differing results. On ext2:

rm: cannot remove 'a': Permission denied

On HFS+:

rm: reading directory 'a/b': Not a directory
rm: cannot remove directory 'a': Directory not empty


The other failure related to the fact that all pipe files are suffixed 
by "|", and all links by "@" when doing "ls -1F" on HFS+

--
Martin

