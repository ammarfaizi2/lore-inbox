Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSFBVDB>; Sun, 2 Jun 2002 17:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314243AbSFBVDA>; Sun, 2 Jun 2002 17:03:00 -0400
Received: from mta9n.bluewin.ch ([195.186.1.215]:62660 "EHLO mta9n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S314138AbSFBVC7>;
	Sun, 2 Jun 2002 17:02:59 -0400
Message-ID: <3CFA875D.1050300@linkvest.com>
Date: Sun, 02 Jun 2002 23:00:13 +0200
From: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SMB filesystem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Actually, SMB access with Linux is done in the way:
- Mount a share
- Access it with rights defined at mount time.

I'm thinking of implementing an smb filesystem, the way AFS implement 
the AFS client fs kernel driver.
- Mount the smb filesystem on /smb (done at boot time)
- Every user has list dir access on /smb
- There, you see each workgroup/domain available on the network
- Then in each domain, a list of machines
- Then in each machine, a list of shares
- Then a list of files/dirs
Access will be granted using the SMB token (like a kerberos ticket) 
issued by the primary domain controller.
It's the way the windows explorer works. It's cool and useful.

What do you think of implementing it that way? Comments?

I'd like to implement it with libsmbclient.so, a samba provided lib that 
let you have access to workgroups/machines/shares in a MS network from 
Linux (or UNIX).
Then, it can't be kernel only. I need a userspace daemon with which the 
kernel will communicate, since the shared lib can't be added to the kernel.
How do you think is the best way of doing things?
Making a minimal FS kernel driver that communicate with a complex 
userspace daemon?

Is it possible to implement a userspace filesystem? In which way?
Is there a generic interface in the kernel for userspace implemented 
filesystems?
Where is the doc on that?

Thanks for comments/ideas.
-jec


