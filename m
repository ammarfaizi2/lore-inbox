Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269964AbUJVOPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269964AbUJVOPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269962AbUJVOPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:15:52 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:11142 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S269964AbUJVONs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:13:48 -0400
From: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>
To: linux-kernel@vger.kernel.org
Subject: Gigantic memory leak in linux-2.6.[789]!
Date: Fri, 22 Oct 2004 16:13:35 +0200
User-Agent: KMail/1.6.2
Cc: umbrella@cs.aau.dk
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200410221613.35913.ks@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

After some more testing after the previous post of the OOPS in 
generic_delete_inode, we have now found a gigantic memory leak in Linux 2.6.
[789]. The scenario is the same:

File system: EXT3
Unpack and delete linux-2.6.8.1.tar.bz2 with this Bash while loop:

let "i = 0"
while [ "$i" -lt 10 ]; do
   tar jxf linux-2.6.8.1.tar.bz2;
   rm -fr linux-2.6.8.1;
   let "i = i + 1"
done

When the loop has completed, the system use 124 MB memory more _each_ time.... 
so it is pretty easy to make a denial-of-service attack :-(

We have tried the same test on a RHEL WS 3 host (running a RedHat 2.4 kernel) 
- and there is no problem.


Any deas?

-- 
Kristian Sørensen
- The Umbrella Project
  http://umbrella.sourceforge.net

E-mail: ipqw@users.sf.net, Phone: +45 29723816
