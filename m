Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317284AbSFCFt2>; Mon, 3 Jun 2002 01:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317285AbSFCFt1>; Mon, 3 Jun 2002 01:49:27 -0400
Received: from relay1.pair.com ([209.68.1.20]:39182 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S317284AbSFCFtZ>;
	Mon, 3 Jun 2002 01:49:25 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3CFB03B3.90353B54@kegel.com>
Date: Sun, 02 Jun 2002 22:50:43 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: SMB filesystem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Eric Cuendet wrote:
> [Currently], SMB access with Linux is done in the way:
> - Mount a share
> - Access it with rights defined at mount time.
> 
> I'm thinking of implementing an smb filesystem, the way AFS implement 
> the AFS client fs kernel driver.
> - Mount the smb filesystem on /smb (done at boot time)
> - Every user has list dir access on /smb
> - There, you see each workgroup/domain available on the network
> - Then in each domain, a list of machines
> - Then in each machine, a list of shares
> - Then a list of files/dirs
> Access will be granted using the SMB token (like a kerberos ticket) 
> issued by the primary domain controller.
> It's the way the windows explorer works. It's cool and useful.
> 
> What do you think of implementing it that way? Comments?
>
> I'd like to implement it with libsmbclient.so, a samba provided lib that 
> let you have access to workgroups/machines/shares in a MS network from 
> Linux (or UNIX).
> Then, it can't be kernel only. I need a userspace daemon

I've been hoping somebody would take this on.
Question: how will you carry the SMB token around? 
Let's imagine somebody starts a script that runs two programs 
that access SMB shares, and that they're initially not logged in at all.  
If this were Windows, it would prompt them once for their username 
and password, and then allow access from then on.
If you make the SMB token a property of the process, the 2nd program
won't be able to access the files after the 1st program somehow 
triggers the user to log in.
Perhaps it should be kept in the kernel in the process group,
so all processes in a process group can use the token?
- Dan
