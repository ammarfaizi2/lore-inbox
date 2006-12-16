Return-Path: <linux-kernel-owner+w=401wt.eu-S1030287AbWLPFHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWLPFHp (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 00:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWLPFHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 00:07:45 -0500
Received: from paperclip.laurelnetworks.com ([63.94.127.69]:45191 "EHLO
	paperclip.laurelnetworks.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932347AbWLPFHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 00:07:45 -0500
X-Greylist: delayed 1275 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 00:07:44 EST
Message-ID: <45837A24.9040207@laurelnetworks.com>
Date: Fri, 15 Dec 2006 23:46:28 -0500
From: Mike Accetta <maccetta@laurelnetworks.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Change in multiple NFS mount behavior in 2.6.19?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading an NFS client from 2.6.18 to 2.6.19 (and also with 
2.6.19.1) we see a change in behavior of multiple NFS mounts against the 
same server (running 2.4.20 in this case).  With 2.6.18 we could mount 
different pieces of the same remote file system with distinct read-only 
and read-write attributes at corresponding places on the client.  With 
2.6.19 if the first mount is read-only, subsequent mounts seem to 
inherit the read-only status even though not explicitly mounted read-only.

If I did the "git bisect" properly, the behavior changed with commit
54ceac4515986030c2502960be620198dd8fe25b and the description of this 
commit seems like it could indeed have caused this behavior, but perhaps 
not intentionally. I believe the client is making NFS V2 calls. Also, I 
am still able to issue a "mount -o remount,rw" on the client to regain 
read-write capability.  Was this a regression or is this now the 
expected behavior for multiple NFS client mounts in 2.6.19?
-- 
Mike Accetta

ECI Telecom Ltd.
Data Networking Division (previously Laurel Networks)
