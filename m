Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315300AbSFCOPf>; Mon, 3 Jun 2002 10:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSFCOPe>; Mon, 3 Jun 2002 10:15:34 -0400
Received: from idefix.linkvest.com ([194.209.53.99]:54022 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S315300AbSFCOPe>; Mon, 3 Jun 2002 10:15:34 -0400
Subject: re: SMB filesystem
From: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
To: dank@kegel.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CFB03B3.90353B54@kegel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 03 Jun 2002 16:14:58 +0200
Message-Id: <1023113698.18181.5.camel@testbed.linkvest.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 03 Jun 2002 14:15:24.0478 (UTC) FILETIME=[1A5E15E0:01C20B09]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks for your answer.
Why did you hope someone took this one? Do you think it's REALLY needed
or is there non-solvable problems?

For The user/pwd problem, you are right, user should be prompted for a
password. This could be achieve in the following way:
- If no token available: logged in anonymous or Guest
- The application could ask the daemon if a token is available, then
prompt the user for it before accessing the files.
- Make a generic callback way to call an arbitrary process
- When no token available, return a "NO LOGIN" message, so the
application should ask the user/password, create the token, or failed.

I think that 1 or 4 is the best way to do it.

For the token proprietary, it could be a file on the disk:
/tmp/user.smb.token, like with kerberos
Or it could be a process attribute, like you suggest, but are all the
processes of one user automatically in the same group?
What about putting that in a ENV VAR?

Thanks for your help
-jec

I've been hoping somebody would take this on.
Question: how will you carry the SMB token around?
Let's imagine somebody starts a script that runs two programs
that access SMB shares, and that they're initially not logged in at
all. 
If this were Windows, it would prompt them once for their username
and password, and then allow access from then on.
If you make the SMB token a property of the process, the 2nd program
won't be able to access the files after the 1st program somehow
triggers the user to log in.
Perhaps it should be kept in the kernel in the process group,
so all processes in a process group can use the token?
- Dan


-- 
Jean-Eric Cuendet
Linkvest SA
Av des Baumettes 19, 1020 Renens Switzerland
Tel +41 21 632 9043  Fax +41 21 632 9090
E-mail: jean-eric.cuendet@linkvest.com
http://www.linkvest.com
--------------------------------------------------------


