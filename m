Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289056AbSAZKjc>; Sat, 26 Jan 2002 05:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289057AbSAZKjW>; Sat, 26 Jan 2002 05:39:22 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:15371 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S289056AbSAZKjK>;
	Sat, 26 Jan 2002 05:39:10 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: brendan.simon@bigpond.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: touch commands in Makefiles 
In-Reply-To: Your message of "Fri, 25 Jan 2002 16:54:39 +1100."
             <3C50F31F.1090302@bigpond.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 26 Jan 2002 21:38:58 +1100
Message-ID: <20898.1012041538@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002 16:54:39 +1100, 
Brendan J Simon <brendan.simon@bigpond.com> wrote:
>Why are header file touched in Makefiles ?

To handle the two level dependencies on CONFIG options.  bar.c depends
on foo.h which depends on CONFIG_BLIP.  Change CONFIG_BLIP and the
Makefiles touch foo.h which in turn recompiles bar.c.

Yes, it sucks with source repositories.  Which is why kbuild 2.5
completely removes this "feature", with kbuild 2.5 you can build from a
read only file system.

>You then tell it which files you intend to modify and it 
>will check those files out as read-write to the local sandbox.

Even easier with kbuild 2.5, it has shadow trees.  You keep the base
read only, copy the files to modify to a separate tree and kbuild 2.5
logically merges all the files.

http://sourceforge.net/projects/kbuild/

