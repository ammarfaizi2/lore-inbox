Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316577AbSF0GFp>; Thu, 27 Jun 2002 02:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSF0GFo>; Thu, 27 Jun 2002 02:05:44 -0400
Received: from w007.z208177141.sjc-ca.dsl.cnc.net ([208.177.141.7]:11395 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S316577AbSF0GFo>;
	Thu, 27 Jun 2002 02:05:44 -0400
Subject: Re: Status of capabilities?
From: Dax Kelson <dax@gurulabs.com>
To: Michael Kerrisk <m.kerrisk@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000101c21d12$b643aae0$0200a8c0@MichaelKerrisk>
References: <000101c21d12$b643aae0$0200a8c0@MichaelKerrisk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 Jun 2002 00:05:25 -0600
Message-Id: <1025157926.1652.35.camel@mentor>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-26 at 06:40, Michael Kerrisk wrote:

> What's still missing in 2.4, as far as I can see after reading the sources,
> is the ability to set capabilities on executable files so that a process
> gains those privileges when executing the file.  I recall seeing some
> information somewhere saying this wasn't possible / wasn't going to happen
> for ext2.  Is it on the drawing board for any file system?

The 2.5 VFS supports Extended Attributes (since 2.5.3). I think the plan
was use EAs to store capabilities. So I believe that the infrastructure
is in place, someone with the proper skills just needs to:

1. Define how capabilities will be stored as a EA
2. Teach fs/exec.c to use the capabilities stored with the file
3. Write lscap(1)
4. Write chcap(1)
5. Audit/fix all SUID root binaries to use capabilities
6. Set appropriate capabilities with for each with chcap(1) and then:
   # find / -type f -perm -4000 -user root -exec chmod u-s {} \;
7. Party and snicker in the general direction of that OS with the slogan
"One remote hole in the default install, in nearly 6 years!"

Dax Kelson
Guru Labs

Disclaimer: I could be completely wrong on any or all of the above

